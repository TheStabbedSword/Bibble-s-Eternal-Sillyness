import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;

var bg:FlxSprite = new FlxSprite(0, 0);
var taskbar:FlxSprite = new FlxSprite(0, 0);

function create()
{
    FlxG.sound.playMusic(Paths.music("WindowsMenu"));

    add(bg).loadGraphic(Paths.image("game/mainmenu/bg"));
    bg.setGraphicSize(Std.int(Std.int(bg.width * 0.7)));
    bg.antialiasing = true;
    bg.updateHitbox();
    bg.screenCenter();
    bg.scrollFactor.set(0.15, 0.15);

    add(taskbar).makeGraphic(FlxG.width, 50, 0xFFD3FFD3);
    taskbar.alpha = 0.5;
    taskbar.screenCenter(FlxAxes.X);
    taskbar.y = FlxG.height - taskbar.height;
    taskbar.scrollFactor.set();
}

function update(elapsed:Float)
{
    FlxG.camera.scroll.set(FlxG.mouse.screenX * 0.15, FlxG.mouse.screenY * 0.15);

    #if MOD_SUPPORT
	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
	}
	#end

    if (controls.DEV_ACCESS) {
		openSubState(new EditorPicker());
	}
}