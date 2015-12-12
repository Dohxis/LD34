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
import Player;

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

    var move : Player;

    override function init() {

        move.init();
        create_map();
        create_map_collision();

            //start the simulation
        sim.paused = false;

  }

    override function update( delta:Float ) {
        move.update(delta);
    }

    override function onkeyup( e:KeyEvent ) {
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }
    }

    function create_map_collision() {

        var bounds = map.layer('collision').bounds_fitted();
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
        var map_data = Luxe.resources.text('assets/tilemap.tmx').asset.text;

            //parse that data into a usable TiledMap instance
        map = new TiledMap({ format:'tmx', tiled_file_data: map_data });

            //Create the tilemap visuals
        map.display({ scale:map_scale, filter:FilterType.nearest });

        for(_group in map.tiledmap_data.object_groups) {
            for(_object in _group.objects) {

                switch(_object.type) {

                    case 'spawn': {

                        //The spawn position is set from the map (this is an egzample so I dont forget)

                    }

                } //switch type
            } //each object
        } //each object group

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


            //fetch the goemetry for the foreground
        var _rows = map.visual.geometry_for_layer('visualfg');

            //for each row in the tiles
        for(_row in _rows) {
                //for each tile in that row
            for(_geom in _row) {
                    //if there is a tile at all
                if(_geom != null) {
                        //move it above the player depth
                    _geom.depth = 5;
                }
            }
        } //each row

    } //create_map

 }
