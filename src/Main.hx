import luxe.Input;
import luxe.States;

class Main extends luxe.Game {

    public static var state: States;

    override function config(config:luxe.AppConfig) {

        config.preload.textures.push({id:'assets/bg2.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/tileset.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/tileset2.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Igloo.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Crystal.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/IceBox.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Sign_2.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/caneGreenSmall.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/caneRedSmall.png', filter_min:nearest, filter_mag:nearest });
        config.preload.textures.push({id:'assets/Tree_2.png', filter_min:nearest, filter_mag:nearest });
        config.preload.texts.push({id:'assets/level2.tmx'});
        config.preload.textures.push({id:'assets/string.png', filter_min:nearest, filter_mag:nearest });


        config.preload.textures.push({id:'assets/snowball.png'});
        config.preload.jsons.push({id:'assets/snowball.json'});

        config.preload.texts.push({id:'assets/level1.tmx'});
        config.preload.texts.push({id:'assets/level3.tmx'});

        config.preload.textures.push({id: 'assets/SantaShit.png'});
        config.preload.jsons.push({id: 'assets/PlayerAnimation.json'});

        config.preload.textures.push({id: 'assets/snowman.png'});
        config.preload.jsons.push({id: 'assets/snowman.json'});

        config.preload.textures.push({id: 'assets/logo.png'});
        config.preload.textures.push({ id:'assets/bg_image.png' });
        config.preload.textures.push({ id:'assets/play.png' });

        return config;

    } //config

    override function ready() {

        state = new States({ name: 'state' });

        state.add( new Game() );
        state.add( new Menu() );
        state.add( new GameOver() );
        state.add( new Win() );
        state.set('game');

    } //ready

    override function update(dt:Float) {

    } //update


} //Main
