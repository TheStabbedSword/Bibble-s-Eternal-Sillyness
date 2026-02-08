import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextAlign;
import PlatformUtil;

enum EternalSillyModcharts
{
    Beanie; Jersey; None;
}

// modchart part!!

var eternalModchart:EternalSillyModcharts = EternalSillyModcharts.None;

// modchart part!!

var subtitle:FlxText;
var songNameTxt:FlxText;
var bobbingIt:Bool = false;

var glitchShader:CustomShader = new CustomShader("GlitchEffect");

var elapsedtime:Float = 0.00;

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

function stepHit(curStep)
{
    switch (PlayState.SONG.meta.name.toLowerCase())
    {
        case "eternal-sillyness":
            switch (curStep)
            {
                case 120:
                    subtitle.color = 0xFFFF0000;
                    subtitle.text = "ITS";
                case 124:
                    subtitle.text = "ON";
                case 128:
                    subtitle.text = "";
                    subtitle.color = 0xFFFFFFFF;
                case 1344:
                    subtitle.text = "Honestly...";
                case 1358:
                    subtitle.text = "DID";
                case 1361:
                    subtitle.text = "YOU REALLY";
                case 1369:
                    subtitle.color = 0xFFFF0000;
                    subtitle.text = "THINK?";
                case 1376:
                    subtitle.text = "YOU CAN";
                case 1380:
                    subtitle.text = "DO";
                case 1384:
                    subtitle.text = "FUCK";
                case 1386:
                    subtitle.text = "FUCKING";
                case 1392:
                    subtitle.text = "BETTER?";
                case 1400:
                    subtitle.text = "";
                    subtitle.color = 0xFFFFFFFF;
                case 1408:
                    eternalModchart = EternalSillyModcharts.Beanie;
                case 1912:
                    for (i in [camHUD, camGame])
                    {
                        i.addShader(glitchShader);
                    }
                    defaultCamZoom += 0.4;
                case 1916:
                    camGame.shake(0.01, (Conductor.stepCrochet / 1000) * 4);
                    defaultCamZoom += 0.1;
                case 1920:
                    for (i in [camHUD, camGame])
                    {
                        i.removeShader(glitchShader);
                    }
                    defaultCamZoom -= 0.5;
            }
    }
}

function beatHit(curBeat)
{
    switch (PlayState.SONG.meta.name.toLowerCase())
    {
        case "eternal-sillyness":
            switch (curBeat)
                {
                    case 32:
                        bobbingIt = true;
                }
    }

    if (bobbingIt)
    {
        if (curBeat % 2 == 0)
        {
            camHUD.zoom = 0.95;
            FlxTween.tween(camHUD, {zoom: 1}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.quadOut});
        } else {
            camHUD.zoom = 1.05;
           FlxTween.tween(camHUD, {zoom: 1}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.quadOut});
        }
    }
}

function postUpdate(elapsed:Float)
{
    elapsedtime += elapsed;

    switch (eternalModchart)
    {
        case EternalSillyModcharts.Beanie:
            playerStrums.forEach(function(spr)
            {
                spr.x += Math.sin(elapsedtime * 16);
                spr.y += Math.cos((elapsedtime * 4) * (spr.ID + 1)) * 0.25;
            });

            cpuStrums.forEach(function(spr)
            {
                spr.x -= Math.sin(elapsedtime * 16);
                spr.y -= Math.cos((elapsedtime * 4) * (spr.ID + 1)) * 0.25;
            });

            camHUD.y -= Math.sin(elapsedtime * 2) * 0.15;
    }

    glitchShader.time = elapsedtime;
}