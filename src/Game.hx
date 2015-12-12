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

import luxe.collision.shapes.Polygon;
import luxe.collision.data.ShapeCollision;

import luxe.importers.tiled.TiledMap;
import luxe.importers.tiled.TiledObjectGroup;

class Game extends luxe.State {

  var map: TiledMap;
  var map_scale: Int = 1;

  var spawn_pos:Vector;
  var portals:Map<Int, Vector>;

  var sim:Simulation;

    public function new() {
        super({ name:'game' });
    }

    var playerMove : Player;
    var player : Sprite;

    override function onenter<T>(_:T) {

        //--------------------------------------------//
                    //Player
        var playerSprite = Luxe.resources.texture('assets/playerSprite.png');
		playerSprite.filter_min = playerSprite.filter_mag = FilterType.nearest;
			player = new Sprite({
				pos : Luxe.screen.mid,
				name : 'player',
				texture : playerSprite,
				size : new Vector(124, 124)
			});
        playerMove = new Player({name : 'player'});
        player.add(playerMove);
                    //Player
        //-------------------------------------------//

        create_map();
        create_map_collision();
        
  }

    override function update( delta:Float ) {
    }

    override function onkeyup( e:KeyEvent ) {
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }
    }

    function create_map_collision() {

        var bounds = map.layer('Tile Layer 1').bounds_fitted();
        for(bound in bounds) {
            bound.x *= map.tile_width * map_scale;
            bound.y *= map.tile_height * map_scale;
            bound.w *= map.tile_width * map_scale;
            bound.h *= map.tile_height * map_scale;
            //sim.obstacle_colliders.push(Polygon.rectangle(bound.x, bound.y, bound.w, bound.h, false));
        }

    } //create_map_collision

    function create_map() {

            //Fetch the loaded tmx data from the assets
        var map_data = Luxe.resources.text('assets/tilemap.tmx').asset.text;

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

 }
