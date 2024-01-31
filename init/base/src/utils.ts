import { $ } from "./dependencies.ts"

export const isWsl = () =>
  Deno.build.os === "linux" &&
  Deno.osRelease().toLowerCase().includes("microsoft")

export const which = async (command: string) =>
  (await $`fish -c "which ${command}"`.text()).trim()

export const exists = async (command: string) => {
  try {
    const path = await which(command)
    return path.length > 0
  } catch {
    return false
  }
}
