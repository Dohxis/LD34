import luxe.Input;
import luxe.States;
import luxe.Sound;

class Main extends luxe.Game {

    public static var state: States;
    public static var strin: Sound;
    public static var jump: Sound;

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

        config.preload.sounds.push({id: 'assets/Music.wav', name: 'music', is_stream : true});
        config.preload.sounds.push({id: 'assets/jump.wav', name: 'jump', is_stream : true});
        config.preload.sounds.push({id: 'assets/string.wav', name: 'string', is_stream : true});

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

        strin = Luxe.audio.get('string');
        jump = Luxe.audio.get('jump');

        strin.volume = 0.5;
        jump.volume = 0.5;

        state.add( new Menu() );
        state.add( new Game(1, 0) );
        state.set('menu');
        //trace(state.current_state);
        music();

    } //ready

    function music() {
        var music = Luxe.audio.get('music');
                music.volume = 0.1;
                music.loop();
    }

    override function update(dt:Float) {
    } //update


} //Main
