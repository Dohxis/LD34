import luxe.States;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import luxe.Transform;

class Player{
	var player : Sprite;
	var playerSprite = Luxe.resources.texture('assets/playerSprite.png');

	function init(){
		player_create();
	}

    function player_create() {
        Luxe.renderer.clear_color.rgb(0x010101);
        player = new Sprite({
            pos : Luxe.screen.mid,
            name : 'player',
            texture : playerSprite,
            size : new Vector(124, 124)
        });
        move_keys();
    }

	function move_keys(){
        Luxe.input.bind_key('left', Key.left);
        Luxe.input.bind_key('left', Key.key_a);
    }

	var speedMax : Float = 300;
    var mSpeed : Float = 0;

	public function update(delta:Float) {
        if(Luxe.input.inputdown('left')){
            if(mSpeed > -speedMax) mSpeed -= 800*delta;
            player.pos.x += mSpeed * delta;
        }
        else{
            if(mSpeed < speedMax) mSpeed += 800*delta;
            player.pos.x += mSpeed * delta;
        }
    }
}
