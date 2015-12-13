import luxe.States;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import phoenix.Texture;
import luxe.Color;
import luxe.tween.Actuate;
import luxe.Rectangle;
import luxe.Text.TextAlign;

class GameOver extends luxe.State {
  
  var bgImage : Sprite;
  var score : Int = 0;
  
  public function new() {
    super({ name:'game over' });
  }

  override function onenter<T>(_:T) {
    
    var bg_image = Luxe.resources.texture('assets/bg_image.png');
    
    bgImage = new Sprite({
      name: 'bgImage',
      texture: bg_image,
      pos: new Vector(320, 240),
      size: new Vector(640, 480)
    });
    
    Luxe.draw.text({
      text : "Game over!",
      bounds : new Rectangle(0, 25, Luxe.screen.w * 0.99, Luxe.screen.h * 0.98),
      color : new Color().rgb(0x12004d),
      align : TextAlign.center,
      align_vertical : TextAlign.top,
      point_size : 64
    });
  
    Luxe.draw.text({
      text : "Your score was: " + score,
      bounds : new Rectangle(0, 150, Luxe.screen.w * 0.99, Luxe.screen.h * 0.98),
      color : new Color().rgb(0x12004d),
      align : TextAlign.center,
      align_vertical : TextAlign.top,
      point_size : 32
    });
    
    Luxe.draw.text({
      text : "Press X to restart",
      bounds : new Rectangle(0, 200, Luxe.screen.w * 0.99, Luxe.screen.h * 0.98),
      color : new Color().rgb(0x12004d),
      align : TextAlign.center,
      align_vertical : TextAlign.top,
      point_size : 16
    });
  
  }

  override function update( delta:Float ) {
    
  }
  
  override function onkeyup( e:KeyEvent ) {
    if(e.keycode == Key.escape) {
      Luxe.shutdown();
    }
  }
  
  override function onleave<T>(_:T) {
    bgImage.destroy();
  }

 }