package com.dohxis.santarush.Entities;

import com.badlogic.gdx.Gdx;
import com.badlogic.gdx.graphics.Texture;
import com.badlogic.gdx.graphics.g2d.Sprite;
import com.badlogic.gdx.graphics.g2d.SpriteBatch;
import com.badlogic.gdx.graphics.g2d.TextureRegion;
import com.badlogic.gdx.math.Vector2;
import com.badlogic.gdx.math.Vector3;
import com.badlogic.gdx.physics.box2d.*;

public class Player extends Sprite {

    public World world;
    public Body body;
    boolean goingLeft = false;

    public final int SPEED = 10;

    public Player(World world){
        super(new Texture("SantaShit.png"));
        this.world = world;
        createPlayerCollision();
    }

    private void createPlayerCollision(){
        BodyDef bodyDef = new BodyDef();
        bodyDef.position.set(100 / 2, 380 / 2);
        bodyDef.type = BodyDef.BodyType.DynamicBody;
        body = world.createBody(bodyDef);

        FixtureDef fixtureDef = new FixtureDef();
        CircleShape shape = new CircleShape();
        shape.setRadius(50);

        fixtureDef.shape = shape;
        body.createFixture(fixtureDef);
    }

    public void controls(Vector3 pos){
       if(!goingLeft)
           body.applyLinearImpulse(new Vector2(SPEED, 0), body.getWorldCenter(), true);

        if((pos.x > Gdx.graphics.getWidth() / 2) && Gdx.input.isTouched()){
            // Jump
        } else if((pos.x < Gdx.graphics.getWidth() / 2) && Gdx.input.isTouched()){
            goingLeft = true;
            body.applyLinearImpulse(new Vector2(-SPEED, 0), body.getWorldCenter(), true);
        }

        if(!Gdx.input.isTouched())
            goingLeft = false;

        setPosition(body.getPosition().x, body.getPosition().y);
    }

    public void renderPlayer(SpriteBatch batch){
        draw(batch);
    }

}
