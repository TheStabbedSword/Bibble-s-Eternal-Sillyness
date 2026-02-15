import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextAlign;
import PlatformUtil;

public var subtitle:FlxText;
public var songNameTxt:FlxText;

function postCreate()
{
    subtitle = new FlxText(0, healthBarBG.y - 100, FlxG.width, "", 36);
    subtitle.setFormat(Paths.font("bibblesaveragehandwriting.ttf"), 50, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    subtitle.borderSize *= 2;
    subtitle.screenCenter(FlxAxes.X);
    add(subtitle);

    songNameTxt = new FlxText(4, 0, FlxG.width, "", 16);
    songNameTxt.setFormat(Paths.font("bibblesaveragehandwriting.ttf"), 16, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    songNameTxt.text = PlayState.SONG.meta.displayName;
    add(songNameTxt);
    songNameTxt.y = (FlxG.height - songNameTxt.height);

    for (i in [subtitle, songNameTxt, scoreTxt, accuracyTxt, missesTxt])
    {
        i.cameras = [camHUD];
        i.font = Paths.font("bibblesaveragehandwriting.ttf");
    }
}