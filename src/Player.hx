import luxe.States;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import luxe.Transform;
import luxe.Component;
import luxe.Entity;
import luxe.collision.shapes.Polygon;
import luxe.collision.data.ShapeCollision;

class Player extends Component{
	var player : Sprite;
	var sim: Simulation;

	override function init(){
		sim = Luxe.physics.add_engine(Simulation);
        sim.draw = false;
        sim.player_collider = Polygon.rectangle(0,0,0,0);
		player = cast entity;
		move_keys();
		sim.player_collider.position = Luxe.screen.mid;
	}

	function move_keys(){
        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('left', Key.key_a);
    }

	var speedMax : Float = 300;
    var mSpeed : Float = 0;

	override function update(delta:Float) {
		auto_move(delta);
		player.pos.copy_from(sim.player_collider.position);
    }

	function auto_move(delta : Float){
		if(Luxe.input.inputdown('left')){
            if(mSpeed > -speedMax) mSpeed -= 800*delta;
            	sim.player_velocity.x = mSpeed;
        }
        else{
            if(mSpeed < speedMax) mSpeed += 800*delta;
            	sim.player_velocity.x = mSpeed;
        }
	}
}
