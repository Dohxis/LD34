import luxe.States;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import phoenix.Texture;

class Menu extends luxe.State {

  var bgImage: Sprite;
  var logo: Sprite;

  public function new() {

    super({ name:'menu' });

  }

  function create_background(){
    var bg_image = Luxe.resources.texture('assets/bg_image.png');
    var logo_image = Luxe.resources.texture('assets/logo.png');

    bg_image.filter_min = bg_image.filter_mag = FilterType.nearest;
    logo_image.filter_min = logo_image.filter_mag = FilterType.nearest;

    bgImage = new Sprite({
      name: 'bgImage',
      texture: bg_image,
      pos: new Vector(320, 240),
      size: new Vector(640, 480)
    });

    logo = new Sprite({
      name: 'logoImage',
      texture: logo_image,
      pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y),
      size: new Vector(300, 60)
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
