import flixel.text.FlxTextBorderStyle;
import flixel.FlxObject;
import flixel.text.FlxTextAlign;
import funkin.editors.ui.UIState;

var bg:FlxSprite = new FlxSprite(0, 0);
var boomboom:FunkinSprite = new FunkinSprite(0, 0);

var camFollow:FlxObject = new FlxObject(0, 0, 1, 1);
var curSelected:Int = 0;

var boomed:Bool = false;

var goonFolderShit = [
    "tord1",
    "tord2",
    "tord3",
    "tord4",
    "tord5",
    "tord6",
    "tord7",
    "Screenshot_2026-02-15_014923",
    "Screenshot_2026-02-15_014930",
    "Screenshot_2026-02-15_014940"
];
var tordsleft:Int;

var goonerrrrr:FlxGroup = new FlxGroup();

function create()
{
    add(bg).loadGraphic(Paths.image("game/mainmenu/browserShitss"));
    bg.setGraphicSize(FlxG.width, FlxG.height);
    bg.updateHitbox();
    bg.scrollFactor.set();
    bg.antialiasing = true;
    bg.screenCenter();

    var title = new FlxText(50, 12.5, FlxG.width, "goonstash", 16);
    title.setFormat("Arial", 32, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    title.borderSize = 0.3;
    title.antialiasing = true;
    title.scrollFactor.set();
    add(title);

    add(camFollow);
    add(goonerrrrr);

    for (i => image in goonFolderShit)
    {
        var goon = new FlxSprite(0, 0).loadGraphic(Paths.image("game/goonstash/" + image));
        goon.setGraphicSize(FlxG.width / 1.7, FlxG.height / 1.7);
        goon.updateHitbox();
        goon.ID = i;
        goon.antialiasing = true;
        goon.screenCenter();
        goon.x = 0 + (i * (640 + 200));
        goonerrrrr.add(goon);
    }

    tordsleft = goonerrrrr.length;
    trace(tordsleft);

    FlxG.camera.follow(camFollow, null, 0.06);
    FlxG.mouse.visible = true;
    changeItem(curSelected);
}

function update(elapsed:Float)
{
    if (controls.BACK)
    {
        FlxG.switchState(new MainMenuState());
    }

    if (controls.LEFT_P)
    {
        curSelected = (curSelected - 1 + goonerrrrr.length) % goonerrrrr.length;
        changeItem(curSelected);
    }

    if (controls.RIGHT_P)
    {
        curSelected = (curSelected + 1) % goonerrrrr.length;
        changeItem(curSelected);
    }

    if (FlxG.mouse.pressed)
    {
        if (FlxG.mouse.overlaps(goonerrrrr.members[curSelected]))
        {
            if (!boomed)
            {
                boomed = true;
                boomboomthatshit(curSelected);

                goonerrrrr.members[curSelected].destroy();
                tordsleft -= 1;
                trace(tordsleft);
                
                new FlxTimer().start(1, function(timer:FlxTimer)
                {
                    boomed = false;
                });
            }
        }
    }

    if (tordsleft == 0)
    {
        FlxG.switchState(new UIState(true, 'TalkingTord'));
    }
}

function doBoomBoom(x, y)
{
    var boomboom = new FunkinSprite(x, y).loadGraphic(Paths.image("game/explosion"));
    boomboom.frames = Paths.getFrames("game/explosion");
    boomboom.setGraphicSize(Std.int(boomboom.width * 16));
    boomboom.addAnim("explosion", "explosion boom", 24);
    boomboom.playAnim("explosion");
    add(boomboom);

    be = FlxG.sound.load(Paths.sound("badexplosion"));
    be.play();

    if (boomboom.isAnimFinished() == "explosion")
    {
        boomboom.destroy();
    }
}

function changeItem(huh:Int = 0)
{
    goonerrrrr.forEach(function(spr:FlxSprite)
    {
        if (spr.ID == curSelected)
        {
            FlxTween.tween(spr, {alpha: 1}, 0.25, {ease: FlxEase.quadOut});

            var mid = spr.getGraphicMidpoint();
			camFollow.setPosition(mid.x - spr.width / 1.25, mid.y - spr.height / 1.25);
			mid.put();
        } else if (!boomed) {
            FlxTween.tween(spr, {alpha: 0.4}, 0.25, {ease: FlxEase.quadOut});
        }
    });
}

function boomboomthatshit(id)
{
    goonerrrrr.forEach(function(spr:FlxSprite)
    {
        if (spr.ID == id)
        {
            doBoomBoom(FlxG.mouse.x - 32.5, FlxG.mouse.y - 52.5);
        }
    });
}