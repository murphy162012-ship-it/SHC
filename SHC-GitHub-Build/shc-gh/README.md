# SHC — Server Hacking Client (starter project)

Target: Minecraft Java 26.3 / Fabric Loader 0.19.5 / Fabric API 0.162.0+26.3.

This is a starter source project for a client-side menu. It registers Right Shift and opens a black/purple module screen. The module switches are currently UI toggles only; the listed game features are not implemented yet. It does not contain anti-cheat bypasses, X-ray bypasses, stealth logic, or ban-evasion features. No mod can guarantee that a server will not flag or ban a player.

## Build on Windows without Command Prompt

1. Install JDK 25.
2. Extract this ZIP somewhere easy to find, such as your Desktop.
3. Open the extracted `shc` folder.
4. Right-click `build.ps1` and choose **Run with PowerShell**. On some Windows versions, use **Show more options** first.
5. The script downloads Gradle automatically on its first run, builds the mod, and opens `build\\libs` when finished.
6. The `.jar` file will be in `build\\libs`.

Internet access is required for the first build so the script can download Gradle and Gradle can download Minecraft/Fabric dependencies. If Windows blocks the script or the build fails, take a screenshot of the PowerShell window.

## Lunar Client

Lunar's support for custom Fabric mods depends on the Minecraft version and Lunar's current Fabric integration. This starter project has not been compiled or tested in Lunar. The module switches are interface-only and do not implement cheats or anti-cheat bypasses.
