package com.dohxis.santarush.Screens;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.Screen;
import com.badlogic.gdx.graphics.*;
import com.badlogic.gdx.graphics.g2d.BitmapFont;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.scenes.scene2d.Stage;
import com.badlogic.gdx.scenes.scene2d.actions.Actions;
import com.badlogic.gdx.scenes.scene2d.ui.Image;
import com.badlogic.gdx.scenes.scene2d.ui.Label;
import com.badlogic.gdx.scenes.scene2d.ui.Table;
import com.badlogic.gdx.utils.viewport.StretchViewport;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.dohxis.santarush.SantaRush;

public class MenuScreen implements Screen {

    private SantaRush game;
    private OrthographicCamera camera;
    private Viewport viewport;

    Texture bgTexture;
    Sprite background;
    Stage stage;
    Image logo;
    Label startText;
    Table table;


    public MenuScreen(SantaRush game){
        this.game = game;
        camera = new OrthographicCamera();
        camera.setToOrtho(false, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
        viewport = new StretchViewport(Gdx.graphics.getWidth(), Gdx.graphics.getHeight(), camera);
        stage = new Stage();

        // Background
        bgTexture = new Texture("bg_image.png");
        bgTexture.setFilter(Texture.TextureFilter.Linear, Texture.TextureFilter.Linear);
        background = new Sprite(bgTexture);
        background.setSize(Gdx.graphics.getWidth(), Gdx.graphics.getHeight());

        // Logo
        logo = new Image(new Texture("logo_image.png"));
        logo.setSize(logo.getWidth(), logo.getHeight());
        logo.setPosition((Gdx.graphics.getWidth() - logo.getWidth()) / 2,
                        (Gdx.graphics.getHeight() - logo.getHeight()) / 2 - Gdx.graphics.getHeight());

        logo.addAction(Actions.sequence(
                Actions.moveTo((Gdx.graphics.getWidth() - logo.getWidth()) / 2,
                                (Gdx.graphics.getHeight() - logo.getHeight()) / 2 + 200, 0.5f)));

        stage.addActor(logo);

        // startText
        table = new Table();
        table.top().setFillParent(true);
        startText = new Label("Press to start!", new Label.LabelStyle(new BitmapFont(Gdx.files.internal("font.fnt")), Color.WHITE));
        table.add(startText).expandX().padTop(logo.getY() * -0.7f);

        stage.addActor(table);
    }

    @Override
    public void show() {

    }

    @Override
    public void render(float delta) {
        Gdx.gl.glClearColor(0, 0, 0, 1);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);
        camera.update();
        game.batch.setProjectionMatrix(camera.combined);
        game.batch.begin();

            background.draw(game.batch);

        game.batch.end();
        stage.act();
        stage.draw();

        isTouched();

    }

    @Override
    public void resize(int width, int height) {
        viewport.update(width, height);
    }

    @Override
    public void pause() {

    }

    @Override
    public void resume() {

    }

    @Override
    public void hide() {

    }

    @Override
    public void dispose() {
        bgTexture.dispose();
        stage.dispose();
    }

    private void isTouched(){
        if(Gdx.input.isTouched()){
            dispose();
            game.setScreen(new PlayScreen(game));
        }
    }

}
