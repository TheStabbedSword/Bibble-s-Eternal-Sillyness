import flixel.util.FlxSpriteUtil;
import openfl.geom.Point;
import flixel.system.FlxAssets;

function postCreate(){
    haxeTxt = new FlxText(0,FlxG.height/2+60,FlxG.width,'Made with HaxeFlixel',16);
    
    add(logo = new FlxSprite(FlxG.width/2-50,FlxG.height/2-70).makeGraphic(100,100,0xFF000000));
    add(other = new FlxSprite(FlxG.width/2-50,FlxG.height/2-70).loadGraphic(Paths.image("game/splash/chud_productions_logo")));
    other.setGraphicSize(Std.int(other.width * 0.25));
    other.updateHitbox();
    other.screenCenter();
    other.visible = false;

    for (i in 0...5)
        new FlxTimer().start([0.12, 0.25, 0.5, 0.62, 0.75][i],[drawGreen,drawYellow,drawRed,drawBlu,drawBlueLight][i]);
    for (i in 0...5)
        new FlxTimer().start([0.12, 0.25, 0.5, 0.62, 0.75][i],function () haxeTxt.color = [0xff00b922,0xffffc132,0xfff5274e,0xff3641ff,0xff04cdfb][i]);

    be = FlxG.sound.load(Paths.sound("splashIntro"));
    be.play();
    FlxTween.tween(other,{alpha: 0},8,{ease: FlxEase.quadOut,startDelay : 2.87});
    FlxTween.tween(haxeTxt,{alpha: 0},8,{ease: FlxEase.quadOut,startDelay : 2.87,onComplete: End});

    new FlxTimer().start(1.75, function () {
        FlxG.cameras.flash(0xFFFFFFFF);
        logo.visible = false;
        other.visible = true;
        haxeTxt.visible = false;
    });
}

function vec(x,y) return new Point(x,y);

function drawGreen(){
    add(haxeTxt).alignment = 'center';
    FlxSpriteUtil.drawPolygon(logo,[vec(50, 13),vec(51,13),
        vec(87, 50),vec(87,51),
        vec(51,87),vec(50,87),
        vec(13,51),vec(13,50),
        vec(50,13)],0xff00b922);
}

function drawYellow()
    FlxSpriteUtil.drawPolygon(logo,[vec(0,0),vec(25,0),
        vec(50, 13),vec(13,50),
        vec(0,25),vec(0,0)],0xffffc132);
        
function drawRed()
    FlxSpriteUtil.drawPolygon(logo,[vec(100,0),vec(75,0),
        vec(50, 13),vec(87,50),
        vec(100,25),vec(100,0)],0xfff5274e);
        
function drawBlu()
    FlxSpriteUtil.drawPolygon(logo,[vec(0,100),vec(25,100),
        vec(50, 87),vec(13,50),
        vec(0,75),vec(0,100)],0xff3641ff);
        
function drawBlueLight()
    FlxSpriteUtil.drawPolygon(logo,[vec(100,100),vec(75,100),
        vec(50, 87),vec(87,50),
        vec(100,75),vec(100,100)],0xff04cdfb);
        
function End(){
    FlxG.switchState(new MainMenuState());
}