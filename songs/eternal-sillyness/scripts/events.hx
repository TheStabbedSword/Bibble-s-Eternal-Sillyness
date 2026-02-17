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

var bobbingIt:Bool = false;
var mad:Bool = true;

var dadNotesCam:HudCamera = new HudCamera();

var glitchShader:CustomShader = new CustomShader("GlitchEffect");
var colorCorrection:CustomShader = new CustomShader("ColorCorrection");
var fishEye:CustomShader = new CustomShader("Fisheye");

var elapsedtime:Float = 0.00;

var fuckingblackshitcuzcamerasucksatflashing = new FlxSprite(0, 0);
var goofyahhwhitebackgroundig = new FlxSprite(0, 0);

var daX:Float = -1000, daY:Float = 600;
var limitAdder:Float = 1400;

var notePoses:Array<Float> = [];
var pi:Float = 3.41;

var choice:String = (Options.downscroll ? "down" : "up");

function postCreate()
{
	FlxG.cameras.insert(dadNotesCam, 1, false).bgColor = FlxColor.TRANSPARENT;

    if ((dadNotes = strumLines?.members[0]) != null)
    {
        dadNotes.notes.limit += limitAdder;
        dadNotes.cameras = [camGame];

        var gfIndex = members.indexOf(gf);
	    remove(strumLines);
	    insert(gfIndex > -1 ? gfIndex : members.indexOf(dad), strumLines);
    }

	camZooming = true;
    centerCamera();

    camGame.addShader(colorCorrection);
    colorCorrection.contrast = 30;
    colorCorrection.hue = -10;
    colorCorrection.saturation = -10;

	var keyCount:Int = playerStrums.length;
    var noteWidth:Float = playerStrums.members[0].width;
    var totalWidth:Float = (keyCount * noteWidth);

    var startX:Float = (FlxG.width - totalWidth) / 2;

    for (i in 0...keyCount)
    {
        playerStrums.members[i].x = startX + (i * noteWidth);
    }
}

function stepHit(curStep)
{
    switch (curStep)
    {
        case 120:
            subtitle.color = 0xFFFF0000;
            subtitle.text = "ITS";
           	defaultCamZoom += 0.3;
        case 124:
            subtitle.text = "ON";
        case 128:
            subtitle.text = "";
            subtitle.color = 0xFFFFFFFF;
            defaultCamZoom -= 0.3;
        case 832:
            centerCamera();
        case 1152:
            centerCamera();
        case 1344:
            subtitle.text = "Honestly...";
            defaultCamZoom += 0.4;
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
            changeShit(true);
            defaultCamZoom -= 0.4;
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
        case 2160:
            add(fuckingblackshitcuzcamerasucksatflashing).makeGraphic(FlxG.width * 4, FlxG.height * 4, 0xFFFFFFFF);
            fuckingblackshitcuzcamerasucksatflashing.alpha = 0;
            fuckingblackshitcuzcamerasucksatflashing.camera = camGame;
            fuckingblackshitcuzcamerasucksatflashing.screenCenter(FlxAxes.XY);

            FlxTween.tween(fuckingblackshitcuzcamerasucksatflashing, {alpha: 1}, (Conductor.stepCrochet / 1000) * 16);
        case 2176:
            eternalModchart = EternalSillyModcharts.None;
            changeShit(false);

            goofyahhwhitebackgroundig.makeGraphic(FlxG.width * 4, FlxG.height * 4, 0xFFFFFFFF);
            var shit = members.indexOf(dad);
            insert(shit > -1 ? shit : members.indexOf(dad), goofyahhwhitebackgroundig);
            goofyahhwhitebackgroundig.screenCenter(FlxAxes.XY);

            FlxTween.tween(fuckingblackshitcuzcamerasucksatflashing, {alpha: 0}, (Conductor.stepCrochet / 1000) * 64);
            bobbingIt = false;

            dad.color = 0xff000000;
            bf.color = 0xff000000;
        case 2520:
            goofyahhwhitebackgroundig.destroy();

           	dad.color = 0xffffffff;
            bf.color = 0xffffffff;
        case 2528:
            mad = true;
            eternalModchart = EternalSillyModcharts.Jersey;

            camGame.flash(0xFFFFFFFF);
    }
}

function beatHit(curBeat)
{
	switch (curBeat)
    {
        case 32:
            bobbingIt = true;
        case 552:
            mad = false;
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
        case EternalSillyModcharts.None:
            camHUD.y = 0;
        case EternalSillyModcharts.Jersey:
            playerStrums.forEach(function(spr)
            {
                spr.x += Math.sin(elapsedtime * 16);
            });

            cpuStrums.forEach(function(spr)
            {
                spr.x -= Math.sin(elapsedtime * 16);
            });
    }

    glitchShader.time = elapsedtime;
}

function onDadHit(event)
{
	if (mad)
    {
        if (!event.note.isSustainNote)
        {
            camGame.shake(0.009, 0.05);

            if (health > 0.1)
            {
                health -= 0.02;
            }
        } else {
            camGame.shake(0.005, 0.05);
        }
    }

    switchSides();
}

public function centerCamera()
{
    curCameraTarget = -1;
    camFollow.setPosition(FlxMath.lerp(dad.getCameraPosition().x, bf.getCameraPosition().x, 0.5), FlxMath.lerp(dad.getCameraPosition().y, bf.getCameraPosition().y, 0.5));
}

public function changeShit(yes)
{
    if (yes)
    {
        FlxTween.num(0,  -50, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quartOut}, val -> colorCorrection.brightness = val);
        FlxTween.num(-10,  -10, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quartOut}, val -> colorCorrection.hue = val);
        FlxTween.num(-10,  50, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quartOut}, val -> colorCorrection.saturation = val);
        FlxTween.num(30,  100, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quartOut}, val -> colorCorrection.contrast = val);
    } else {
        FlxTween.num(-50,  0, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quartOut}, val -> colorCorrection.brightness = val);
        FlxTween.num(-10,  -10, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quartOut}, val -> colorCorrection.hue = val);
        FlxTween.num(50,  -10, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quartOut}, val -> colorCorrection.saturation = val);
        FlxTween.num(100,  30, (Conductor.stepCrochet / 1000) * 16, {ease: FlxEase.quartOut}, val -> colorCorrection.contrast = val);
    }
}

function onStrumCreation(event) if (event.player == 0) event.cancelAnimation();
function onPostStrumCreation(event) if (event.player == 0) {
	event.strum.angle = -90;
	event.strum.setPosition(dad.x + event.strum.y + daX, -event.strum.x + daY);
	event.strum.scrollFactor.set(1, 1);
}

function switchSides()
{
    for (i in playerStrums.members)
    {
        switch (choice)
        {
            
        }
    }
}