import luxe.States;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import luxe.Transform;
import Player;

class Game extends luxe.State {

    public function new() {
        super({ name:'game' });
    }

    var move : Player;

    override function init(){
        move.init();
    }

    override function update( delta:Float ) {
        move.update(delta);
    }

    override function onkeyup( e:KeyEvent ) {
        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }
    }

 }
