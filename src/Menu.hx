import luxe.States;
import luxe.Input;

class Game extends luxe.State {

  public function new() {

    super({ name:'menu' });

  }

  override function update( dt:Float ) {



  }

  override function onkeyup( e:KeyEvent ) {

    if(e.keycode == Key.escape) {
      Luxe.shutdown();
    }

  }

}
