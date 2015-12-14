import luxe.Color;
import luxe.Rectangle;
import luxe.utils.Maths;
import luxe.tilemaps.Ortho;
import phoenix.Texture.FilterType;
import luxe.States;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import luxe.Transform;
import luxe.Entity;
import luxe.Component;
import luxe.Log.log;

import luxe.Parcel;
import luxe.ParcelProgress;
import phoenix.Texture;
import luxe.components.sprite.SpriteAnimation;

import luxe.collision.shapes.Polygon;
import luxe.collision.data.ShapeCollision;

import luxe.importers.tiled.TiledMap;
import luxe.importers.tiled.TiledObjectGroup;

class Game extends luxe.State {

    var map: TiledMap;
    var map_scale: Int = 1;
    var bgImage: Sprite;
    var camX: Float;
    var camY: Float;

    var spawn_pos:Vector;
    var portals:Map<Int, Vector>;

    var spikes = [];

    var bullets = [];
    var bulletDirections = [];
    var canShoot : Bool = true;
    var shootCooldown : Float = 1;
    var cooldown : Float = 0;

    var level : Int = 1;

    var jumpPadVelocity = 700;
    var jumpPadResetsSpeed = true;

    var oldScore : Int;
    var score : Int;

    public function new(lvl : Int, scr : Int) {
        super({ name:'game' });
        level = lvl;
        score = scr;
        oldScore = scr;
    }

    var player : Sprite;
    var anim : SpriteAnimation;

    public var sim : Simulation;

    override function onenter<T>(_:T) {

        Luxe.events.listen('simulation.triggers.collide', on_trigger);

        Luxe.renderer.clear_color.rgb(0xd5edf7);

        var bg_image = Luxe.resources.texture('assets/bg2.png');
        bgImage = new Sprite({
            name: 'bgImage',
            depth: -1,
            texture: bg_image,
            pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y),
            size: new Vector(1280, 720)
        });

        sim = Luxe.physics.add_engine(Simulation);
        sim.draw = false;
        assets_loaded();
        sim.player_collider = Polygon.rectangle(100, 370, 80, 80);
    }

    function assets_loaded(){
        //create_enemy();
        create_map();
        create_map_collision();
        load_spikes();

        //loads jump pads
        var lay : Bool = false;
        for(laye in map.layers){
          if(laye.name == 'jump'){
            lay = true;
          }
        }
        if(lay){
          load_jumps();
        }

        load_exit();

        create_player();
        create_player_animation();
        move_keys();
        //sim.draw = true;
    }

    function load_spikes() { // a bit buggy but works ok

      var bounds = map.layer('collide').bounds_fitted();
      for(bound in bounds) {
        var shape = Polygon.rectangle(
          bound.x = bound.x * map.tile_width * map_scale + 50,
          bound.y = bound.y * map.tile_height * map_scale + 50,
          bound.w = bound.w * map.tile_width * map_scale - 10,
          bound.h = bound.h * map.tile_height * map_scale
        );

        shape.tags.set('type', 'collide');
        sim.trigger_colliders.push(shape);
      }
    }

    function load_jumps() {

      var bounds = map.layer('jump').bounds_fitted();
      for(bound in bounds) {
        var shape = Polygon.rectangle(
          bound.x = bound.x * map.tile_width * map_scale + 37.5,
          bound.y = bound.y * map.tile_height * map_scale + 25,
          bound.w = bound.w * 1.5 * map.tile_width * map_scale,
          bound.h = bound.h * 1.5 * map.tile_height * map_scale
        );

        shape.tags.set('type', 'jump');
        sim.trigger_colliders.push(shape);
      }
    }

    function load_exit() {

      var bounds = map.layer('exit').bounds_fitted();
      for(bound in bounds) {
        var shape = Polygon.rectangle(
          bound.x = bound.x * map.tile_width * map_scale + 250,
          bound.y = bound.y * map.tile_height * map_scale + 250,
          bound.w = bound.w * map.tile_width * map_scale,
          bound.h = bound.h * map.tile_height * map_scale
        );

        shape.tags.set('type', 'exit');
        sim.trigger_colliders.push(shape);
      }
    }

    function on_trigger(collisions:Array<ShapeCollision>){
        for(collision in collisions) {
            var _type = collision.shape2.tags.get('type');

            switch(_type) {
                case 'collide':
                  Main.state.add(new GameOver(level, score, oldScore));
                  Main.state.set('game over');

                case 'jump':
                  if(jumpPadResetsSpeed){
                    sim.player_velocity.y = 0;
                    Main.strin.play();
                  }
                  sim.player_velocity.y = -jumpPadVelocity;

                case 'exit':
                  if(level == 3){
                    trace("-------------level: " + level);
                    Main.state.add(new Win(score));
                    Main.state.set('win');
                  }
                  else{
                    trace("--------------going to next level!!!");
                    Main.state.add(new Game(level+1, score));
                    Main.state.set('game');
                  }
                  //Main.state.unset('game') ; //kill remove unset

          } //switch type

      } //each collision
    }

    function create_player(){
        var playerSprite = Luxe.resources.texture('assets/SantaShit.png');
			      player = new Sprite({
            depth: 99,
				    name : 'player',
				    texture : playerSprite,
            size : new Vector(124,124)
			   });
    }

    function create_player_animation(){
        var anim_object = Luxe.resources.json('assets/PlayerAnimation.json');
        anim = player.add( new SpriteAnimation({ name:'anim' }) );
        anim.add_from_json_object( anim_object.asset.json );
        anim.animation = 'run';
        anim.play();
    }

    function move_keys(){
        Luxe.input.bind_key('left', Key.key_z);
        Luxe.input.bind_key('action', Key.key_x);
    }

    var enemy = [];
    var enemyAnim : SpriteAnimation;
    var enemyCount : Int = 0;

    function create_enemy(){
        var enemySprite = Luxe.resources.texture('assets/snowman.png');
        enemy.push(new Sprite({
            name: "enemy",
            texture: enemySprite,
            pos: player.pos,
            size : new Vector(72,72)
        }));
        create_enemy_animation();
    }

    function create_enemy_animation(){
        var enemy_object = Luxe.resources.json('assets/snowman.json');
        enemyAnim = enemy[enemyCount].add( new SpriteAnimation({ name:'anim' }) );
        enemyAnim.add_from_json_object( enemy_object.asset.json );
        enemyAnim.animation = 'idle';
        enemyCount++;
        enemyAnim.play();
    }

    var speedMax : Float = 300;
    var mSpeed : Float = 0;

    override function update( delta:Float ) {
        if(player == null) return;

        auto_move(delta);
        action(delta);
        camera_follow(delta);
	    player.pos.copy_from(sim.player_collider.position);
        handle_bullets(delta);
        count_time(delta);
        
        bgImage.pos.x = player.pos.x + 420;
    }
    
    var timeAdd : Float = 0;
    var time : Int;
    
    function count_time(delta){
            timeAdd = timeAdd + delta;
            time = Std.int(timeAdd);
            trace(time);
    }

    function auto_move(delta : Float){
        if(mSpeed > 0) player.flipx = true;
        else player.flipx = false;

        if(sim.player_velocity.x == 0 && anim.animation != 'idle'){
            anim.animation = 'idle';
        }

		    if(Luxe.input.inputdown('left')){
            if(mSpeed > -speedMax){
                mSpeed -= 800*delta;
                if(mSpeed > 0 && sim.player_velocity.x != 0) anim.animation = 'slide';
                if(mSpeed < 0) anim.animation = 'run';
            }
            sim.player_velocity.x = mSpeed;
        }

        else{
            if(mSpeed < speedMax){
                mSpeed += 800*delta;
                if(mSpeed < 0 && sim.player_velocity.x != 0) anim.animation = 'slide';
                if(mSpeed > 0) anim.animation = 'run';
            }
            sim.player_velocity.x = mSpeed;
        }
    }

    function camera_follow(delta : Float){
        camX = player.pos.x + 425;
        camY = player.pos.y - 251 - (player.pos.y - 371);

        Luxe.camera.focus(new Vector(camX, camY), delta);
    }

    var jumpSize : Float = 550;
    var once : Bool = false;

    function action(delta : Float){
      if(Luxe.input.inputdown('action') && sim.player_can_jump == true){
          sim.player_velocity.y = -jumpSize;
      }
      if(sim.player_can_jump == false){
          anim.animation = 'jump';
          once = false;
      }
      if(sim.player_can_jump == true && once == false && sim.player_velocity.x != 0){
          once = true;
          anim.animation = 'run';
      }
      if(sim.player_can_jump == true && once == false && sim.player_velocity.x == 0){
          once = true;
          anim.animation = 'idle';
      }
    }

    function handle_bullets(delta : Float){
        if(!canShoot) cooldown += delta;
        if(cooldown >= shootCooldown) {
            cooldown = 0;
            canShoot = true;
        }
        if(bullets != null){
            var i : Int = 0;
            for(bullet in bullets){
              if(bulletDirections[i]) bullet.pos.x += 500 * delta;
              else bullet.pos.x += -500 * delta;
              i++;
            }
        }
    }

    override function onkeyup( e:KeyEvent ) {
        if(e.keycode == Key.escape) {
          Main.state.add(new GameOver(level, score, oldScore));
          Main.state.set('game over');
        }
    }

    function create_map_collision() {
        var bounds = map.layer('ground').bounds_fitted();
        for(bound in bounds) {
            bound.x *= map.tile_width * map_scale;
            bound.y *= map.tile_height * map_scale;
            bound.w *= map.tile_width * map_scale;
            bound.h *= map.tile_height * map_scale;
            sim.obstacle_colliders.push(Polygon.rectangle(bound.x, bound.y, bound.w, bound.h, false));
        }
    } //create_map_collision

    function create_map() {

        //Fetch the loaded tmx data from the assets
        var map_data = Luxe.resources.text('assets/level' + level + '.tmx').asset.text;

        //parse that data into a usable TiledMap instance
        map = new TiledMap({ format:'tmx', tiled_file_data: map_data });

        //Create the tilemap visuals
        map.display({ scale:map_scale, filter:FilterType.nearest });

        for(layer in map.tiledmap_data.image_layers) {

            new luxe.Sprite({
                name:'image_layer.${layer.name}',
                centered: false, depth:-1,
                pos: new Vector(map.pos.x+(layer.x*map_scale), map.pos.y+(layer.y * map_scale)),
                scale: new Vector(map_scale, map_scale),
                texture: Luxe.resources.texture('assets/'+layer.image.source),
                color: new Color(1,1,1, layer.opacity),
                visible: layer.visible
            });

        } //each image_layer

    } //create_map

    override function onleave<T>(_:T) {
        player.destroy();
        map.destroy();
        bgImage.destroy();
        Luxe.camera.focus(new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y));

        sim.obstacle_colliders = []; //hax
        sim.trigger_colliders = []; // hax

        //sim.destroy(); <------------------------ (todo)
    }

 }
