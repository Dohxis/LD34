import luxe.Input;
import luxe.States;

class Main extends luxe.Game {

    public static var state: States;

    override function config(config:luxe.AppConfig) {
        config.preload.textures.push({id: 'assets/playerSprite.png'});
<<<<<<< HEAD
=======

>>>>>>> origin/master
        config.preload.textures.push({ id:'assets/bg_image.png' });
        return config;

    } //config

    override function ready() {

      state = new States({ name: 'state' });

      state.add( new Game() );
      state.add( new Menu() );
      state.set('game');

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {

    } //update


} //Main
