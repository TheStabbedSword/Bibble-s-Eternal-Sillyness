import funkin.backend.utils.DiscordUtil;
import funkin.editors.ui.UITextBox;
import funkin.backend.system.framerate.SystemInfo;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxBackdrop;
import hxvlc.flixel.FlxVideoSprite;
import StringTools;
import sys.Http;
import Sys;
import haxe.Json;
import funkin.options.Options;
import flixel.text.FlxTextAlign;
import funkin.game.PlayState;
import flixel.text.FlxTextFormatMarkerPair;
import flixel.text.FlxTextFormat;
import flixel.text.FlxTextBorderStyle;
import PlatformUtil;
import flixel.FlxG;

// !! THE GOAT HIMSELF 
var tord:FunkinSprite = new FunkinSprite(0, 0, Paths.image("game/talkingtord/idle"));
var jumpscare:FlxVideoSprite = new FlxVideoSprite();
// !! THE GOAT HIMSELF 

var elapsedtime:Float = 0.00;
var typing:Bool = true;
var displayText:FlxText;
var escapelol:FlxText;
var typeText:UITextBox;
var randomResponses = [
    "no",
    "yes",
    "eugh",
    "evil laugh"
];
var bg:FlxSprite = new FlxSprite(0, 0); 

function create()
{
    FlxG.sound.playMusic(Paths.music("talkingtordbgmusic"));

    var blackScreen = new FlxBackdrop(FlxGridOverlay.createGrid(80, 80, 160, 160, true, 0xFF898989, 0xFF000000));
    blackScreen.velocity.set(25, 25);
    blackScreen.alpha = 0.2;

    add(bg).loadGraphic(Paths.image(FlxG.random.bool(0.1) ? "game/mainmenu/bg so secret" : "game/mainmenu/bg"));
    bg.setGraphicSize(Std.int(Std.int(bg.width * 0.7)));
    bg.updateHitbox();
    bg.screenCenter();
    bg.scrollFactor.set(0.15, 0.15);
    add(blackScreen);

    add(tord).screenCenter(FlxAxes.XY);
    tord.y -= 150;

    typeText = new UITextBox(100, 0, "", 1080, 32, false, false);
    typeText.y = ((FlxG.height - typeText.height) / 2) + 150;
    add(typeText);

    displayText = new FlxText(0, typeText.y + 100, FlxG.width, "Talking Tord!\nYes or No questions only!", 32);
	displayText.setFormat("Arial", 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	displayText.size *= 2;
    displayText.borderSize = 1.5;
	displayText.antialiasing = false;
    add(displayText);

    escapelol = new FlxText(0, 0, FlxG.width, "Press ESCAPE to leave", 32);
	escapelol.setFormat("Arial", 16);
	escapelol.antialiasing = false;
    add(escapelol);
    escapelol.y = FlxG.height - escapelol.height;

    add(jumpscare).load(Assets.getPath(Paths.file('videos/eviljumpscare.mkv')), [':no-audio']);
    jumpscare.visible = false;
    jumpscare.screenCenter(FlxAxes.XY);
    jumpscare.scrollFactor.set();
    jumpscare.bitmap.onEndReached.add(function() {
        PlatformUtil.sendFakeError("yes i am evil\n-Evil Tord");
        Sys.exit(0);
    });

    FlxG.mouse.visible = true;
}

function update(elapsed:Float)
{
    elapsedtime += elapsed;

    tord.y += (Math.sin(elapsedtime) * 0.2);
    tord.x += (Math.cos(elapsedtime) * 0.2);

    if (FlxG.keys.justPressed.ENTER && typing) {
        var thingSent = typeText.label.text;
        var chosenthing = randomResponses[FlxG.random.float(0, randomResponses.length)];

        switch (thingSent.toLowerCase())
        {
            case "are u evil" | "are you evil" | "are you evil?" | "are u evil?" | "shucks" | "aw shucks":
                FlxG.sound.music.fadeOut(0.1, 0);
                FlxG.sound.play(Paths.music("tordshucky"), 2);
                jumpscare.visible = true;
                jumpscare.play();
            case "be evil":
                FlxG.cameras.flash();
                tord.color = 0xFFFF0000;
            case "its the jews fault":
                FlxG.sound.play(Paths.sound("btjdie"), 2);

                var btj:FunkinSprite = new FunkinSprite(-500,0,Paths.image("game/talkingtord/btj"));
                btj.setGraphicSize(Std.int(btj.width * 2));
                btj.screenCenter(FlxAxes.Y);
                add(btj);
                FlxTween.tween(btj, {x: FlxG.width + 100, angle: -360}, 0.69);
                new FlxTimer().start(0.69, ()->{ FlxG.cameras.shake(0.005, 0.2); });
            default:
                tord.loadGraphic(Paths.image("game/talkingtord/" + chosenthing));
                new FlxTimer().start(1, ()->{ tord.loadGraphic(Paths.image("game/talkingtord/idle")); });
                FlxG.sound.play(Paths.sound("talkingtord/" + chosenthing), 2);
                trace(chosenthing);
        }
    }

    if (FlxG.keys.justPressed.ESCAPE && !gettingJumpscared)
    {
        FlxG.switchState(new MainMenuState());
    }

    jumpscare.screenCenter(FlxAxes.XY);
}