package com.dohxis.santarush.desktop;

import com.badlogic.gdx.backends.lwjgl.LwjglApplication;
import com.badlogic.gdx.backends.lwjgl.LwjglApplicationConfiguration;
import com.dohxis.santarush.SantaRush;

public class DesktopLauncher {
	public static void main (String[] arg) {
		LwjglApplicationConfiguration config = new LwjglApplicationConfiguration();

		config.width = SantaRush.WIDTH;
		config.height = SantaRush.HEIGHT;

		new LwjglApplication(new SantaRush(), config);
	}
}
