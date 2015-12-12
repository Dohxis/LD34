import luxe.States;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import phoenix.Texture;

class Menu extends luxe.State {
  
  var bgImage: Sprite;
  
  public function new() {

    super({ name:'menu' });

  }

  function create_background(){
    var bg_image = Luxe.resources.texture('assets/bg_image.png');

    bg_image.filter_min = bg_image.filter_mag = FilterType.nearest;

    bgImage = new Sprite({
      name: 'bgImage',
      texture: bg_image,
      pos: new Vector(320, 240),
      size: new Vector(640, 480)
    });
  }

  override function init() {
    create_background();
  }

  override function update( dt:Float ) {



  }

  override function onkeyup( e:KeyEvent ) {

    if(e.keycode == Key.escape) {
      Luxe.shutdown();
    }

  }

}
