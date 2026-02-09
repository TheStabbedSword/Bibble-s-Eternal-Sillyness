import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextAlign;
import PlatformUtil;

var bg:FlxSprite = new FlxSprite(0, 0);
var taskbar:FlxSprite = new FlxSprite(0, 0);

var menuItems:FlxGroup = new FlxGroup();
var options:Array<String> = [
    {name: "Options", icon: "folder"},
    {name: "Internet\nExplorer", icon: "browser"}
];

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

    add(menuItems);

    for (i in 0...options.length)
    {
        var option = options[i];
        var name = option.name;
        var icon = option.icon;

        var spritey:FlxSprite = new FlxSprite(0, 0);
        spritey.loadGraphic(Paths.image("game/mainmenu/" + icon));
        spritey.scrollFactor.set();
        spritey.setGraphicSize(Std.int(spritey.width * 0.31));
        spritey.updateHitbox();
        spritey.ID = i;
        spritey.y = i * 110;

        var songNameTxt = new FlxText(0, 0, spritey.width + 1, name, 16);
        songNameTxt.setFormat(Paths.font("bibblesaveragehandwriting.ttf"), 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        songNameTxt.scrollFactor.set();

        songNameTxt.x = spritey.x;
        songNameTxt.y = spritey.y + spritey.height;

        add(spritey);
        add(songNameTxt);
        menuItems.add(spritey);
    }   
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