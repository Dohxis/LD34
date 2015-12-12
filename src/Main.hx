import luxe.Input;
import luxe.States;

class Main extends luxe.Game {

    public static var state: States;

    override function config(config:luxe.AppConfig) {

        config.preload.textures.push({id:'assets/Tiles/1.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/2.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/3.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/4.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/5.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/6.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/7.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/8.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/9.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/10.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/11.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/12.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/13.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/14.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/15.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/16.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/17.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tiles/18.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/tileset.png', filter_min:nearest, filter_mag:nearest });

        config.preload.texts.push({id:'assets/tilemap.tmx'});

        config.preload.textures.push({id: 'assets/playerSprite.png'});
        config.preload.textures.push({id: 'assets/logo.png'});
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
