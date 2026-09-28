/**
 * Claude Code-style working line, e.g. `✻ 6m 42s · 1.2k tokens · thinking...`.
 * Output tokens are estimated from streamed chars until the provider reports usage.
 */

import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

const FRAMES = ["·", "✢", "✳", "✶", "✻", "✽", "✻", "✶", "✳", "✢"];
const FRAME_INTERVAL_MS = 120;
const TICK_MS = 1000;
// Rough chars-per-token ratio for English/code; only used until real usage arrives.
const CHARS_PER_TOKEN = 4;
const STATUS_KEY = "response-timer";

type Phase = "waiting" | "thinking" | "responding" | "preparing";

export function formatDuration(ms: number): string {
	const total = Math.max(0, Math.floor(ms / 1000));
	const h = Math.floor(total / 3600);
	const m = Math.floor((total % 3600) / 60);
	const s = total % 60;
	if (h > 0) return `${h}h ${m}m`;
	if (m > 0) return `${m}m ${s}s`;
	return `${s}s`;
}

export function formatTokens(n: number): string {
	if (n >= 1_000_000) return `${(n / 1_000_000).toFixed(1)}M tokens`;
	if (n >= 1_000) return `${(n / 1_000).toFixed(1)}k tokens`;
	return `${n} tokens`;
}

export default function (pi: ExtensionAPI) {
	let startedAt: number | undefined;
	let timer: ReturnType<typeof setInterval> | undefined;
	let phase: Phase = "waiting";
	let preparingTool = "";
	const runningTools = new Map<string, string>();
	let completedTokens = 0;
	let streamedChars = 0;
	let reportedTokens = 0;

	const streamEstimate = () => Math.round(streamedChars / CHARS_PER_TOKEN);
	const liveTokens = () => completedTokens + Math.max(streamEstimate(), reportedTokens);

	const activity = (): string => {
		if (runningTools.size === 1) return `running ${[...runningTools.values()][0]}...`;
		if (runningTools.size > 1) return `running ${runningTools.size} tools...`;
		switch (phase) {
			case "waiting":
				return "waiting...";
			case "thinking":
				return "thinking...";
			case "responding":
				return "responding...";
			case "preparing":
				return preparingTool ? `preparing ${preparingTool}...` : "preparing tool call...";
		}
	};

	const stats = (): string => {
		const parts = [formatDuration(Date.now() - (startedAt ?? Date.now()))];
		const tokens = liveTokens();
		if (tokens > 0) parts.push(formatTokens(tokens));
		return parts.join(" · ");
	};

	const render = (ctx: ExtensionContext) => {
		if (startedAt === undefined) return;
		ctx.ui.setWorkingMessage(`${stats()} · ${activity()}`);
	};

	const stopTimer = () => {
		if (timer) clearInterval(timer);
		timer = undefined;
	};

	const reset = () => {
		stopTimer();
		startedAt = undefined;
		phase = "waiting";
		preparingTool = "";
		runningTools.clear();
		completedTokens = 0;
		streamedChars = 0;
		reportedTokens = 0;
	};

	pi.on("session_start", async (_event, ctx) => {
		reset();
		if (ctx.mode !== "tui") return;
		ctx.ui.setStatus(STATUS_KEY, undefined);
		ctx.ui.setWorkingIndicator({
			frames: FRAMES.map((f) => ctx.ui.theme.fg("accent", f)),
			intervalMs: FRAME_INTERVAL_MS,
		});
	});

	pi.on("session_shutdown", async () => {
		reset();
	});

	// Retries and queued follow-ups re-emit `agent_start`: only the first one starts the clock.
	pi.on("agent_start", async (_event, ctx) => {
		if (ctx.mode !== "tui" || startedAt !== undefined) return;
		startedAt = Date.now();
		ctx.ui.setStatus(STATUS_KEY, undefined);
		timer = setInterval(() => render(ctx), TICK_MS);
		render(ctx);
	});

	pi.on("turn_start", async (_event, ctx) => {
		phase = "waiting";
		render(ctx);
	});

	pi.on("message_start", async (event) => {
		if (event.message.role !== "assistant") return;
		streamedChars = 0;
		reportedTokens = 0;
	});

	pi.on("message_update", async (event, ctx) => {
		if (startedAt === undefined) return;
		const e = event.assistantMessageEvent;
		switch (e.type) {
			case "thinking_start":
			case "thinking_delta":
				phase = "thinking";
				break;
			case "text_start":
			case "text_delta":
				phase = "responding";
				break;
			case "toolcall_start":
			case "toolcall_delta": {
				phase = "preparing";
				const block = e.partial.content[e.contentIndex];
				preparingTool = block?.type === "toolCall" ? block.name : "";
				break;
			}
			default:
				return;
		}
		if ("delta" in e) streamedChars += e.delta.length;
		reportedTokens = e.partial.usage?.output ?? 0;
		render(ctx);
	});

	pi.on("message_end", async (event, ctx) => {
		if (startedAt === undefined || event.message.role !== "assistant") return;
		const reported = event.message.usage?.output ?? 0;
		completedTokens += reported > 0 ? reported : streamEstimate();
		streamedChars = 0;
		reportedTokens = 0;
		render(ctx);
	});

	pi.on("tool_execution_start", async (event, ctx) => {
		runningTools.set(event.toolCallId, event.toolName);
		phase = "waiting";
		render(ctx);
	});

	pi.on("tool_execution_end", async (event, ctx) => {
		runningTools.delete(event.toolCallId);
		render(ctx);
	});

	pi.on("agent_settled", async (_event, ctx) => {
		if (startedAt === undefined) return;
		ctx.ui.setStatus(STATUS_KEY, ctx.ui.theme.fg("dim", `✻ ${stats()}`));
		ctx.ui.setWorkingMessage();
		reset();
	});
}
