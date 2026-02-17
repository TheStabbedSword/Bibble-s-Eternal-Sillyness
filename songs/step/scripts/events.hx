var bobbingIt:Bool = false;

function stepHit(curStep)
{
    switch (curStep)
    {
        case 120 | 124 | 128 | 132:
            defaultCamZoom += 0.1;
        case 136:
            defaultCamZoom -= 0.5;
        case 208:
            bobbingIt = true;
    }
}

function beatHit(curBeat)
{
    if (bobbingIt)
    {
        if (curBeat % 2 == 0)
        {
            camHUD.y -= 20;
            camHUD.x -= 20;
            FlxTween.tween(camHUD, {y: 0, x: 0}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.quadOut});
        } else {
            camHUD.y -= 20;
            camHUD.x += 20;
            FlxTween.tween(camHUD, {y: 0, x: 0}, (Conductor.stepCrochet / 1000) * 2, {ease: FlxEase.quadOut});
        }
    }
}