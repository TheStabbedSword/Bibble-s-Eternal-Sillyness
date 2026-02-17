var bobbingIt:Bool = false;
var vibing:Bool = false;

function stepHit(curStep)
{
    switch (curStep)
    {
        case 256:
            bobbingIt = true;
        case 736 | 742 | 748 | 754 | 760 | 764:
            defaultCamZoom += 0.05;
        case 768:
            bobbingIt = false;
            vibing = true;

            defaultCamZoom -= 0.3;
        case 1024:
            vibing = false;
            bobbingIt = true;
    }
}

function update(elapsed:Float)
{
    if (vibing)
    {
        camHUD.angle = Math.sin(Conductor.songPosition / 1000) * 4;
        camHUD.zoom = 1 + (Math.cos(Conductor.songPosition / 1000) * 0.04);
    }
}

function beatHit(curBeat)
{
    if (bobbingIt)
    {
        if (curBeat % 2 == 0)
        {
            camHUD.zoom = 0.95;
            camHUD.angle = -1.5;
            FlxTween.tween(camHUD, {zoom: 1, angle: 0}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.quadOut});
        } else {
            camHUD.zoom = 0.95;
            camHUD.angle = 1.5;
            FlxTween.tween(camHUD, {zoom: 1, angle: 0}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.quadOut});
        }
    }
}