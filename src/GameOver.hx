import luxe.States;
import luxe.Input;
import luxe.Sprite;
import luxe.Vector;
import phoenix.Texture;
import luxe.Color;
import luxe.tween.Actuate;
import luxe.Rectangle;
import luxe.Text.TextAlign;
import luxe.Text;

class GameOver extends luxe.State {
  
  var bgImage : Sprite;
  var score : Int = 0;
  
  var text1 : Text;
  var text2 : Text;
  var text3 : Text;
  
  public function new() {
    super({ name:'game over' });
  }

  override function onenter<T>(_:T) {
    
    var bg_image = Luxe.resources.texture('assets/bg_image.png');
    
    text1 = new Text({});
    text2 = new Text({});
    text3 = new Text({});
    
    bgImage = new Sprite({
      name: 'bgImage',
      texture: bg_image,
      pos: new Vector(320, 240),
      size: new Vector(640, 480)
    });
    
    text1.geom = Luxe.draw.text({
      text : "Game over!",
      bounds : new Rectangle(0, 25, Luxe.screen.w * 0.99, Luxe.screen.h * 0.98),
      color : new Color().rgb(0x12004d),
      align : TextAlign.center,
      align_vertical : TextAlign.top,
      point_size : 64
    });
  
    text2.geom = Luxe.draw.text({
      text : "Your score was: " + score,
      bounds : new Rectangle(0, 150, Luxe.screen.w * 0.99, Luxe.screen.h * 0.98),
      color : new Color().rgb(0x12004d),
      align : TextAlign.center,
      align_vertical : TextAlign.top,
      point_size : 32
    });
    
    text3.geom = Luxe.draw.text({
      text : "Press X to restart",
      bounds : new Rectangle(0, 200, Luxe.screen.w * 0.99, Luxe.screen.h * 0.98),
      color : new Color().rgb(0x12004d),
      align : TextAlign.center,
      align_vertical : TextAlign.top,
      point_size : 16
    });
  
  }
  
  override function onkeyup( e:KeyEvent ) {
    if(e.keycode == Key.key_x) {
      destroy_text();
      Main.state.set('game');
    }
  }
  
  function destroy_text(){
    text1.text = ' ';
    text1.destroy();
    text2.text = ' ';
    text2.destroy();
    text3.text = ' ';
    text3.destroy();
  }
  
  override function onleave<T>(_:T) {
    bgImage.destroy();
  }

 }