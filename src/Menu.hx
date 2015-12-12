import luxe.States;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import phoenix.Texture;
import luxe.Color;

// Snow
import luxe.options.ParticleOptions;
import luxe.Particles;

class Menu extends luxe.State {

  var bgImage: Sprite;
  var logo: Sprite;
  var snow: ParticleSystem;

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
      pos: new Vector(Luxe.screen.mid.x, Luxe.screen.mid.y - 150),
      size: new Vector(290, 50)
    });

  }

  override function onenter<T>(_:T) {
    create_background();
    create_snow();
  }

  override function onleave<T>(_:T) {
    snow.destroy();
  }

  override function update( dt:Float ) {



  }

  override function onkeyup( e:KeyEvent ) {

    if(e.keycode == Key.escape) {
      Luxe.shutdown();
    }

  }

  function create_snow(){
    snow = new ParticleSystem({ name: 'snow' });
    snow.pos = new Vector(200, 0);

    var emitter: ParticleEmitterOptions = {};

    emitter.name = 'eSnow';
    emitter.pos = new Vector();
    emitter.cache_wrap = false;
    emitter.pos_random = new Vector(Luxe.screen.w, 0);
    emitter.cache_size = 512;
    emitter.particle_image = Luxe.resources.texture('assets/snow.png');
    emitter.start_color = new Color();
    emitter.end_color = new Color(1,1,1,0);
    emitter.start_size = new Vector(10, 10);
    emitter.end_size = new Vector(2, 2);
    emitter.rotation_random = 360;
    emitter.gravity  = new Vector(-10, 600);
    emitter.speed_random = 0.01;
    emitter.life = 1;
    emitter.depth = 1;
    emitter.emit_count = 16;
    emitter.emit_time  = 0.2;

    snow.add_emitter(emitter);

  }

}
