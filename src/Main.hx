import luxe.Input;
import luxe.States;

class Main extends luxe.Game {

    public static var state: States;

    override function config(config:luxe.AppConfig) {

        config.preload.textures.push({id:'assets/tileset.png', filter_min:nearest, filter_mag:nearest });

        config.preload.texts.push({id:'assets/tilemap.tmx'});

        config.preload.textures.push({id: 'assets/playerSpriteBeauty.png'});
        config.preload.textures.push({id: 'assets/logo.png'});
        config.preload.textures.push({ id:'assets/bg_image.png' });
        config.preload.textures.push({ id:'assets/play.png' });

        return config;

    } //config

    override function ready() {

        state = new States({ name: 'state' });

        state.add( new Game() );
        state.add( new Menu() );
        state.set('menu');
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
