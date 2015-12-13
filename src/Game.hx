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

    public function new() {
        super({ name:'game' });
    }

    var player : Sprite;
    var anim : SpriteAnimation;

    public var sim : Simulation;

    override function onenter<T>(_:T) {

        Luxe.renderer.clear_color.rgb(0xd5edf7);

        var bg_image = Luxe.resources.texture('assets/bg2.png');
        bgImage = new Sprite({
          name: 'bgImage',
          depth: -1,
          texture: bg_image,
          pos: new Vector(320, 240),
          size: new Vector(3200, 480)
        });

        sim = Luxe.physics.add_engine(Simulation);
        sim.draw = false;
        assets_loaded();
        sim.player_collider = Polygon.rectangle(100, 370, 90, 90);
    }

    function assets_loaded(){
        create_player();
        create_player_animation();
        move_keys();
        create_map();
        create_map_collision();
    }

    function create_player(){
        var playerSprite = Luxe.resources.texture('assets/SantaShit.png');
		playerSprite.filter_min = playerSprite.filter_mag = FilterType.nearest;

			player = new Sprite({
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
        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('jump', Key.key_x);
        Luxe.input.bind_key('jump', Key.space);
    }

    var speedMax : Float = 300;
    var mSpeed : Float = 0;

    override function update( delta:Float ) {
        if(player == null) {
            return;
        }
        auto_move(delta);
        jump(delta);
        camera_follow(delta);
		player.pos.copy_from(sim.player_collider.position);
    }

    function auto_move(delta : Float){
        if(mSpeed > 0) player.flipx = true;
        else player.flipx = false;

		if(Luxe.input.inputdown('left')){
            if(mSpeed > -speedMax) mSpeed -= 800*delta;
                sim.player_velocity.x = mSpeed;
        }
        else{
            if(mSpeed < speedMax) mSpeed += 800*delta;
            	sim.player_velocity.x = mSpeed;
        }
	}

    function camera_follow(delta : Float){

        camX = player.pos.x + 425;
        camY = player.pos.y - 251 - (player.pos.y - 371);

        Luxe.camera.focus(new Vector(camX, camY), delta);
    }

    var jumpSize : Float = 500;

    function jump(delta : Float){
        if(Luxe.input.inputdown('jump') && sim.player_can_jump == true){
            sim.player_velocity.y = -jumpSize;
        }
    }

    override function onkeyup( e:KeyEvent ) {
        if(e.keycode == Key.escape) {
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
        var map_data = Luxe.resources.text('assets/level1.tmx').asset.text;

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
      Luxe.camera.focus(new Vector(320, 240));
    }

 }
