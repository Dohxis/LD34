import luxe.States;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import luxe.Transform;
import luxe.Component;
import luxe.Entity;

class Player extends Component{
	var player : Sprite;

	override function init(){
		player = cast entity;
		move_keys();
	}

	function move_keys(){
        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('left', Key.key_a);
    }

	var speedMax : Float = 300;
    var mSpeed : Float = 0;
	var sim : Simulation;

	override function update(delta:Float) {
		auto_move(delta);
		player.pos.copy_from(sim.player_collider.position);
    }

	function auto_move(delta : Float){
		if(Luxe.input.inputdown('left')){
            if(mSpeed > -speedMax) mSpeed -= 800*delta;
            sim.player_velocity.x += mSpeed * delta;
        }
        else{
            if(mSpeed < speedMax) mSpeed += 800*delta;
            sim.player_velocity.x += mSpeed * delta;
        }
	}
}
