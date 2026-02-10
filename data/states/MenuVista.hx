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
    {name: "goon stash", icon: "folder"}
];

var goonstashFolder:FlxSprite = new FlxSprite(0, 0);
var optionsFolder:FlxSprite = new FlxSprite(0, 0);

var lastClickTime:Float = 0;
var dragging:FlxSprite = null;
var dragOffsetX:Float = 0;
var dragOffsetY:Float = 0;

function create()
{
    FlxG.sound.playMusic(Paths.music("WindowsMenu"));

    add(bg).loadGraphic(Paths.image("game/mainmenu/bg"));
    bg.setGraphicSize(Std.int(Std.int(bg.width * 0.7)));
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
        spritey.antialiasing = true;
        spritey.ID = i;
        spritey.y = i * 110;

        var songNameTxt = new FlxText(0, 0, spritey.width + 1, name, 16);
        songNameTxt.setFormat("Arial", 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        songNameTxt.borderSize = 0.2;
        songNameTxt.antialiasing = true;
        songNameTxt.scrollFactor.set();

        songNameTxt.x = spritey.x;
        songNameTxt.y = spritey.y + spritey.height;

        add(spritey);
        add(songNameTxt);
        menuItems.add(spritey);
    }  

    add(goonstashFolder).loadGraphic(Paths.image("game/mainmenu/browserShit"));
    goonstashFolder.scrollFactor.set();
    goonstashFolder.screenCenter();
    goonstashFolder.visible = false;

    add(optionsFolder).loadGraphic(Paths.image("game/mainmenu/browserShit"));
    optionsFolder.scrollFactor.set();
    optionsFolder.screenCenter();
    optionsFolder.visible = false;

    for (i in [goonstashFolder, optionsFolder, taskbar, bg])
    {
        i.antialiasing = true;
    }
}

function update(elapsed:Float)
{
    FlxG.camera.scroll.set(FlxG.mouse.screenX * 0.15, FlxG.mouse.screenY * 0.15);

    #if MOD_SUPPORT
    if (controls.SWITCHMOD) openSubState(new ModSwitchMenu());
    #end

    if (controls.DEV_ACCESS) openSubState(new EditorPicker());

    for (icon in menuItems.members)
    {
        if (icon == null) continue;

        var mouseOver = FlxG.mouse.overlaps(icon);

        if (mouseOver)
        {
            icon.alpha = 0.5;
        }
        else
        {
            icon.alpha = 1;
        }

        if (mouseOver && FlxG.mouse.justPressed)
        {
            var now = FlxG.game.ticks / 1000;
            if (now - lastClickTime < 0.3)
            {
                switch (icon.ID)
                {
                    case 0: toggleFolder(optionsFolder, goonstashFolder);
                    case 1: toggleFolder(goonstashFolder, optionsFolder);
                }
            }
            lastClickTime = now;
        }
    }

    for (win in [goonstashFolder, optionsFolder])
    {
        if (!win.visible) continue;

        var over = FlxG.mouse.overlaps(win);

        if (over && FlxG.mouse.justPressed)
        {
            dragging = win;
            dragOffsetX = FlxG.mouse.screenX - win.x;
            dragOffsetY = FlxG.mouse.screenY - win.y;
        }
    }

    if (dragging != null)
    {
        if (FlxG.mouse.pressed)
        {
            dragging.x = FlxG.mouse.screenX - dragOffsetX;
            dragging.y = FlxG.mouse.screenY - dragOffsetY;
        }
        else
        {
            dragging = null;
        }
    }
}


function toggleFolder(open:FlxSprite, close:FlxSprite)
{
    FlxTween.cancelTweensOf(open);
    close.visible = false;

    open.visible = !open.visible;
    open.scale.set(0.7, 0.7);
    open.updateHitbox();

    FlxTween.tween(open.scale, {x: 1, y: 1}, 0.25, {ease: FlxEase.quadOut});

    FlxG.sound.play(Paths.sound("mainmenu/click"));
}