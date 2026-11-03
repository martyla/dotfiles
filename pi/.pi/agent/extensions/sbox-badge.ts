/**
 * Prefixes the footer's cwd line with `(sbox)` when running inside `sbox`.
 * Wraps the built-in footer's render: `setStatus` can only add a separate line.
 */

import { FooterComponent } from "@earendil-works/pi-coding-agent";
import { truncateToWidth } from "@earendil-works/pi-tui";

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

// Shared across `/reload`s so each reload wraps the original render, not the previous wrapper.
const ORIGINAL_RENDER = Symbol.for("sbox-badge.originalRender");

type Render = (width: number) => string[];

export default function (pi: ExtensionAPI) {
	if (!process.env.SBOX) return;

	const proto = FooterComponent.prototype as unknown as Record<PropertyKey, Render>;
	const render = proto[ORIGINAL_RENDER] ?? proto.render;
	proto[ORIGINAL_RENDER] = render;

	let badge = "";
	proto.render = function (width: number): string[] {
		const lines = render.call(this, width);
		if (!badge || lines.length === 0) return lines;
		return [truncateToWidth(`${badge} ${lines[0]}`, width), ...lines.slice(1)];
	};

	pi.on("session_start", async (_event, ctx) => {
		if (ctx.mode !== "tui") return;
		badge = ctx.ui.theme.fg("warning", "(sbox)");
	});
}
