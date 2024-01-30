import { $ } from "./dependencies.ts"

export const isWsl = () =>
  Deno.build.os === "linux" &&
  Deno.osRelease().toLowerCase().includes("microsoft")

export const reload = () => $`exec $SHELL -l`
