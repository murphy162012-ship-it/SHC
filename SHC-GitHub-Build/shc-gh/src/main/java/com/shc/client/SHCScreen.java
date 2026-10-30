package com.shc.client;

import net.minecraft.client.gui.GuiGraphics;
import net.minecraft.client.gui.components.Button;
import net.minecraft.client.gui.screens.Screen;
import net.minecraft.network.chat.Component;
import java.util.LinkedHashMap;
import java.util.Map;

public final class SHCScreen extends Screen {
    private final Map<String, Boolean> modules = new LinkedHashMap<>();

    public SHCScreen() {
        super(Component.literal("SHC | Server Hacking Client"));
        modules.put("Coordinates HUD", true);
        modules.put("FPS Counter", true);
        modules.put("Fullbright", false);
        modules.put("Toggle Sprint", false);
        modules.put("Freecam (permitted worlds)", false);
        modules.put("Player ESP (permitted worlds)", false);
    }

    @Override
    protected void init() {
        int panelWidth = 300;
        int left = (this.width - panelWidth) / 2;
        int top = Math.max(24, (this.height - 250) / 2);
        int y = top + 62;

        for (String name : modules.keySet()) {
            addRenderableWidget(Button.builder(label(name), button -> {
                modules.put(name, !modules.get(name));
                button.setMessage(label(name));
            }).bounds(left + 18, y, panelWidth - 36, 25).build());
            y += 30;
        }

        addRenderableWidget(Button.builder(Component.literal("Close"), button -> onClose())
                .bounds(left + 18, Math.min(this.height - 38, y + 5), panelWidth - 36, 22).build());
    }

    private Component label(String name) {
        return Component.literal((modules.get(name) ? "§aON  " : "§cOFF ") + "§f" + name);
    }

    @Override
    public void render(GuiGraphics graphics, int mouseX, int mouseY, float delta) {
        renderBackground(graphics, mouseX, mouseY, delta);
        int panelWidth = 300;
        int panelHeight = Math.min(300, this.height - 24);
        int left = (this.width - panelWidth) / 2;
        int top = (this.height - panelHeight) / 2;
        graphics.fill(left, top, left + panelWidth, top + panelHeight, 0xEE101018);
        graphics.fill(left, top, left + panelWidth, top + 3, 0xFF9B5CFF);
        graphics.drawCenteredString(this.font, "SERVER HACKING CLIENT", this.width / 2, top + 15, 0xFFE7D8FF);
        graphics.drawCenteredString(this.font, "SHC  •  MODULES", this.width / 2, top + 34, 0xFFB7A0D8);
        super.render(graphics, mouseX, mouseY, delta);
    }

    @Override
    public boolean isPauseScreen() {
        return false;
    }
}
