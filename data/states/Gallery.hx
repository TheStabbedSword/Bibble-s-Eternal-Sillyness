import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextAlign;

var bg:FlxSprite = new FlxSprite(0, 0);
var boomboom:FunkinSprite = new FunkinSprite(0, 0);

function create()
{
    add(bg).loadGraphic(Paths.image("game/mainmenu/browserShit"));
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.updateHitbox();
    bg.antialiasing = true;
    bg.screenCenter();

    var title = new FlxText(50, 12.5, FlxG.width, "goonstash", 16);
    title.setFormat("Arial", 32, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    title.borderSize = 0.3;
    title.antialiasing = true;
    title.scrollFactor.set();
    add(title);
}

function update(elapsed:Float)
{
    if (controls.BACK)
    {
        FlxG.switchState(new MainMenuState());
    }

    if (FlxG.mouse.pressed)
    {
        //doBoomBoom(FlxG.mouse.x - 32.5, FlxG.mouse.y - 52.5);
    }
}

function doBoomBoom(x, y)
{
    var boomboom = new FunkinSprite(x, y).loadGraphic(Paths.image("game/explosion"));
    boomboom.frames = Paths.getFrames("game/explosion");
    boomboom.addAnim("explosion", "explosion boom", 24);
    boomboom.playAnim("explosion");
    add(boomboom);

    be = FlxG.sound.load(Paths.sound("badexplosion"));
    be.play();

    if (boomboom.isAnimFinished())
    {
        boomboom.destroy();
    }
}