/**
 * ghost-turn-fix — auto-retry empty assistant turns.
 *
 * Some providers occasionally end a turn with stopReason "stop" but no usable
 * content (empty content array, or thinking-only with no text/toolCall). The
 * agent treats this as a clean end-of-turn and goes silent.
 *
 * Ghost fingerprint:
 *   - role === "assistant"
 *   - stopReason === "stop"
 *   - no text block with non-empty text
 *   - no toolCall block
 *
 * Fix: re-issue the request once with a hidden "continue" message via
 * pi.sendMessage (display:false). Shown to the LLM as role:"user" by
 * convertToLlm, but not rendered in the TUI. Non-empty content is required
 * because providers reject empty user messages. Capped at 1 retry via a
 * single-shot flag so a genuinely stuck stream surfaces instead of looping.
 *
 * Observed on Bedrock converse-stream (Claude Opus with high/xhigh thinking)
 * and similar reports from claude-code: 
 * https://github.com/anthropics/claude-code/issues/50597.
 *
 * Enabled on all models (afaict there is minimal downside).
 */

import type { ExtensionAPI, TurnEndEvent } from "@earendil-works/pi-coding-agent";

/** Minimal shape we care about on an assistant AgentMessage. */
interface AssistantLike {
	role?: string;
	stopReason?: string;
	content?: Array<{ type: string; text?: string }>;
}

export function isGhostTurn(message: unknown): boolean {
	if (!message || typeof message !== "object") return false;
	const m = message as AssistantLike;
	if (m.role !== "assistant") return false;
	if (m.stopReason !== "stop") return false;
	const blocks = m.content ?? [];
	// Ghost iff no non-empty text and no toolCall. Thinking-only and empty
	// arrays both qualify.
	for (const b of blocks) {
		if (b.type === "toolCall") return false;
		if (b.type === "text" && typeof b.text === "string" && b.text.trim().length > 0) {
			return false;
		}
	}
	return true;
}

export default function (pi: ExtensionAPI) {
	// Single-shot retry gate; prevents retrying twice in a row.
	let retryInFlight = false;

	pi.on("turn_end", (event: TurnEndEvent, ctx) => {
		const ghost = isGhostTurn(event.message);

		// Non-ghost turn resets the gate.
		if (!ghost) {
			retryInFlight = false;
			return;
		}

		if (retryInFlight) {
			// Second consecutive ghost — give up.
			retryInFlight = false;
			if (ctx.hasUI) {
				ctx.ui.notify(
					"[ghost-turn-fix] Retry also produced an empty turn; giving up. Re-prompt to continue.",
					"warning",
				);
			}
			return;
		}

		retryInFlight = true;
		if (ctx.hasUI) {
			ctx.ui.notify("[ghost-turn-fix] Model returned an empty turn; auto-continuing…", "info");
		}

		// Hidden nudge: sendMessage with display:false keeps it out of the TUI
		// but convertToLlm still serializes it as role:"user". Non-empty content
		// required (providers reject empty user messages). followUp lets the
		// agent loop pick it up instead of exiting.
		try {
			pi.sendMessage(
				{
					customType: "ghost-turn-continue",
					content: "continue",
					display: false,
				},
				{ triggerTurn: true, deliverAs: "followUp" },
			);
		} catch (err) {
			retryInFlight = false;
			if (ctx.hasUI) {
				const msg = err instanceof Error ? err.message : String(err);
				ctx.ui.notify(`[ghost-turn-fix] Could not queue continuation: ${msg}`, "error");
			}
		}
	});
}
