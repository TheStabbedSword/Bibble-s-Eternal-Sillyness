import PlatformUtil;

var elapsedtime:Float = 0.00;

function onSongStart()
{
    songNameTxt.text = "Screw you! " + PlatformUtil.getUserFromDiscord() + "\n" + PlayState.SONG.meta.displayName;
    songNameTxt.y -= 24;
}

function postUpdate(elapsed:Float)
{
    elapsedtime += elapsed;

    var toy = -100 + -Math.sin((curStep / 9.5) * 2) * 30 * 5;
	var tox = -330 -Math.cos((curStep / 9.5)) * 100;

    dad.x += (tox - dad.x) / 12;
	dad.y += (toy - dad.y) / 12;

    camHUD.angle = Math.sin(Conductor.songPosition / 1000) * 4;
    camHUD.zoom = 1 + (Math.cos(Conductor.songPosition / 1000) * 0.04);
}