package com.dohxis.santarush.Screens;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.InputAdapter;
import com.badlogic.gdx.Screen;
import com.badlogic.gdx.graphics.GL20;
import com.badlogic.gdx.graphics.OrthographicCamera;
import com.badlogic.gdx.maps.MapObject;
import com.badlogic.gdx.maps.objects.RectangleMapObject;
import com.badlogic.gdx.maps.tiled.TiledMap;
import com.badlogic.gdx.maps.tiled.TmxMapLoader;
import com.badlogic.gdx.maps.tiled.renderers.OrthoCachedTiledMapRenderer;
import com.badlogic.gdx.math.Rectangle;
import com.badlogic.gdx.math.Vector2;
import com.badlogic.gdx.math.Vector3;
import com.badlogic.gdx.physics.box2d.*;
import com.badlogic.gdx.utils.viewport.StretchViewport;
import com.badlogic.gdx.utils.viewport.Viewport;
import com.dohxis.santarush.Entities.Map;
import com.dohxis.santarush.Entities.Player;
import com.dohxis.santarush.SantaRush;

public class PlayScreen extends InputAdapter implements Screen {

    private SantaRush game;
    private OrthographicCamera camera;
    private Viewport viewport;
    public Player player;

    public int level = 1;

    private World world;
    private Map map;
    private Box2DDebugRenderer box2DDebugRenderer;

    public Vector3 mousePos;

    PlayScreen(SantaRush game){
        this.game = game;
        camera = new OrthographicCamera();
        camera.setToOrtho(false, Gdx.graphics.getWidth(), Gdx.graphics.getHeight());
        viewport = new StretchViewport(Gdx.graphics.getWidth(), Gdx.graphics.getHeight(), camera);

        world = new World(SantaRush.GRAVITY, true);
        box2DDebugRenderer = new Box2DDebugRenderer();
        map = new Map(world, level);

        player = new Player(world);
        mousePos = new Vector3(0, 0, 0);
    }

    @Override
    public void show() {

    }

    @Override
    public void render(float delta) {
        update(delta);

        Gdx.gl.glClearColor(0.843137255f, 0.929411765f, 0.968627451f, 1);
        Gdx.gl.glClear(GL20.GL_COLOR_BUFFER_BIT);

        game.batch.enableBlending();
        Gdx.gl.glEnable(GL20.GL_BLEND);
        Gdx.gl.glBlendFunc(GL20.GL_SRC_ALPHA, GL20.GL_ONE_MINUS_SRC_ALPHA);
            map.render();
            game.batch.begin();
                player.renderPlayer(game.batch);
            game.batch.end();
        Gdx.gl.glDisable(GL20.GL_BLEND);

        box2DDebugRenderer.render(world, camera.combined);

        game.batch.setProjectionMatrix(camera.combined);
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

    }

    private void handleInput(){
        if(Gdx.input.isTouched()) {
            mousePos.set(Gdx.input.getX(), Gdx.input.getY(), 0);
            camera.unproject(mousePos);
        }
        player.controls(mousePos);
    }

    private void update(float dt){
        handleInput();
        world.step(1 / 60f, 6, 2);
        camera.update();
        map.renderer.setView(camera);
    }
}
