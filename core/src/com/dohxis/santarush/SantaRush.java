package com.dohxis.santarush;

import com.badlogic.gdx.ApplicationAdapter;
import com.badlogic.gdx.Game;
import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.math.Vector2;
import com.dohxis.santarush.Screens.MenuScreen;

public class SantaRush extends Game {

    public final static int WIDTH = 1280;
    public final static int HEIGHT = 720;

    public final static Vector2 GRAVITY = new Vector2(0, -800);

	public SpriteBatch batch;
	
	@Override
	public void create () {
		batch = new SpriteBatch();
		setScreen(new MenuScreen(this));
	}

	@Override
	public void render () {
		super.render();
	}
}
