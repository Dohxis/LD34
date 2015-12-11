
import luxe.Input;

class Main extends luxe.Game {

    override function config(config:luxe.AppConfig) {

        return config;

    } //config

    override function ready() {

      Luxe.renderer.clear_color.rgb(0x121212);

    } //ready

    override function onkeyup( e:KeyEvent ) {

        if(e.keycode == Key.escape) {
            Luxe.shutdown();
        }

    } //onkeyup

    override function update(dt:Float) {



    } //update


} //Main
