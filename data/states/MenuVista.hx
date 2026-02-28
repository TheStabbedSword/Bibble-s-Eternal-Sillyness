import funkin.editors.EditorPicker;
import funkin.menus.ModSwitchMenu;
import flixel.text.FlxTextBorderStyle;
import flixel.text.FlxTextAlign;
import PlatformUtil;
import funkin.editors.ui.UIState;
import Date;
import funkin.options.OptionsMenu;

var bootupCamera:FlxCamera = new FlxCamera();
var menuCamera:FlxCamera = new FlxCamera();

var bg:FlxSprite = new FlxSprite(0, 0);
var taskbar:FlxSprite = new FlxSprite(0, 0);
var songFolder:FlxSprite = new FlxSprite(0, 0);
var folderCloseHitbox:FlxSprite = new FlxSprite(0, 0);

var btj:FunkinSprite = new FunkinSprite(0, 0, Paths.image("game/mainmenu/BTJ walking"));
var btjIsMoving:Bool = false;
var pressedB = false;
var pressedT = false;
var pressedJ = false;

var menuItems:FlxGroup = new FlxGroup();

var options:Array<String> = [
    {name: "Options", icon: "settings"},
    {name: "goon stash", icon: "folder"},
    {name: "Bibble Explorer", icon: "browser"},
    {name: "Songs", icon: "folder"}
];

var browserThing:FlxSprite = new FlxSprite(0, 0);
var browserCloseHitbox:FlxSprite = new FlxSprite(0, 0);

var eternalSillynessHitbox:FlxSprite = new FlxSprite(0, 0).makeGraphic(623, 69, 0xFFFFFFFF);

var timeTxt:FlxText;

var lastClickTime:Float = 0;

function create()
{
    FlxG.cameras.insert(menuCamera, 1, false).bgColor = FlxColor.TRANSPARENT;
    FlxG.cameras.insert(bootupCamera, 2, false).bgColor = FlxColor.TRANSPARENT;

    if (!FlxG.save.data.alreadyOpenedOS)
    {
        FlxG.save.data.alreadyOpenedOS = true;

        // bootup

        var bgthing:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        bgthing.camera = bootupCamera;
        bgthing.screenCenter();
        add(bgthing);

        var chudproducts:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("game/bootup/chudos"));
        chudproducts.setGraphicSize(Std.int(chudproducts.width * 0.25));
        chudproducts.camera = bootupCamera;
        chudproducts.screenCenter();
        chudproducts.y -= 150;
        add(chudproducts);

        var littleBootup:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image("game/bootup/bootupwait"));
        littleBootup.setGraphicSize(Std.int(littleBootup.width * 0.3));
        littleBootup.camera = bootupCamera;
        littleBootup.screenCenter();
        littleBootup.y += 200;
        add(littleBootup);

        var lil:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        lil.camera = bootupCamera;
        lil.screenCenter();
        add(lil);

        FlxTween.tween(lil, {alpha: 0}, 1);
        FlxTween.tween(littleBootup, {angle: 360}, 1, {type: FlxTween.LOOPING});

        be = FlxG.sound.load(Paths.sound("mainmenu/chudos pc startupsound"));
        be.play();

        new FlxTimer().start(11.26, () -> {
            FlxTween.tween(bootupCamera, {alpha: 0}, 1);
        });

        new FlxTimer().start(15.99, () -> {
            FlxG.sound.playMusic(Paths.music("WindowsMenu"));
        });

        // bootup
    }

    add(bg).loadGraphic(Paths.image(FlxG.random.bool(0.1) ? "game/mainmenu/bg so secret" : "game/mainmenu/bg"));
    bg.setGraphicSize(Std.int(Std.int(bg.width * 0.7)));
    bg.updateHitbox();
    bg.screenCenter();
    bg.scrollFactor.set(0.15, 0.15);

    add(taskbar).makeGraphic(FlxG.width, 35, 0xFFD3FFD3);
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
        spritey.camera = menuCamera;
        spritey.x = 40 + i * 110;   // spacing to the right
        spritey.y = 40;            // fixed vertical line

        var songNameTxt = new FlxText(0, 0, spritey.width + 1, name, 16);
        songNameTxt.setFormat("Arial", 16, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        songNameTxt.borderSize = 0.2;
        songNameTxt.antialiasing = true;
        songNameTxt.scrollFactor.set();

        songNameTxt.camera = menuCamera;

        songNameTxt.x = spritey.x;
        songNameTxt.y = spritey.y + spritey.height + 5;

        add(spritey);
        add(songNameTxt);

        menuItems.add(spritey);
    }  

    add(browserThing).loadGraphic(Paths.image("game/mainmenu/browserPage"));
    browserThing.scrollFactor.set();
    browserThing.visible = false;
    browserThing.setGraphicSize(FlxG.width, FlxG.height - 50);
    browserThing.screenCenter();
    browserThing.y -= 25;

    add(browserCloseHitbox).makeGraphic(30, 30, 0xFF000000);
    browserCloseHitbox.x = FlxG.width - 30;
    browserCloseHitbox.alpha = 0;
    browserCloseHitbox.visible = false;
    browserCloseHitbox.scrollFactor.set();

    add(songFolder).loadGraphic(Paths.image("game/mainmenu/browserShit"));
    songFolder.scrollFactor.set();
    songFolder.screenCenter();
    songFolder.visible = false;

    add(eternalSillynessHitbox).camera = menuCamera;
    eternalSillynessHitbox.alpha = 0;
    eternalSillynessHitbox.visible = false;
    eternalSillynessHitbox.screenCenter();
    eternalSillynessHitbox.y -= 128;

    add(folderCloseHitbox).makeGraphic(31, 20, 0xFF000000);
    folderCloseHitbox.setPosition(songFolder.width + 254.5, songFolder.y + 10);
    folderCloseHitbox.alpha = 0;
    folderCloseHitbox.visible = false;
    folderCloseHitbox.scrollFactor.set();

    timeTxt = new FlxText(-5, FlxG.height - 32.5, taskbar.width, "time you dumbass", 16);
    timeTxt.setFormat("Arial", 12, FlxColor.WHITE, FlxTextAlign.RIGHT);
    timeTxt.borderSize = 0;
    timeTxt.antialiasing = true;
    timeTxt.scrollFactor.set();
    add(timeTxt);

    add(btj).camera = menuCamera;
    btj.frames = Paths.getFrames("game/mainmenu/BTJ walking");
    btj.addAnim("walkacross", "BTJ WALKING NOW OR ELSE YOUR RAMADAMNINGNINGNUING", 24, true);
    btj.setGraphicSize(Std.int(btj.width) * 0.5);
    btj.screenCenter();
    btj.setPosition(-200, (FlxG.height - btj.height) + 12.5);
    btj.playAnim("walkacross");

    for (i in [taskbar, bg, browserThing, timeTxt, songFolder])
    {
        i.antialiasing = true;
        i.camera = menuCamera;
    }
}

function update(elapsed:Float)
{
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
                    case 0: FlxG.switchState(new OptionsMenu());
                    case 1: FlxG.switchState(new ModState("Gallery"));
                    case 2: openUpBrowser();
                    case 3: toggleFolder();
                }
            }
            lastClickTime = now;
        }
    }

    if (FlxG.mouse.pressed)
    {
        if (FlxG.mouse.overlaps(browserCloseHitbox))
        {
            if (browserCloseHitbox.visible)
            {
                openUpBrowser();
            }
        }

        if (FlxG.mouse.overlaps(folderCloseHitbox))
        {
            if (folderCloseHitbox.visible)
            {
                toggleFolder();
            }
        }

        if (FlxG.mouse.overlaps(eternalSillynessHitbox))
        {
            if (eternalSillynessHitbox.visible)
            {
                PlayState.loadSong("eternal-sillyness", "normal");
                FlxG.switchState(new PlayState());
            }
        }

        if (FlxG.mouse.overlaps(btj))
        {
            if (btjIsMoving)
            {
                PlayState.loadSong("blame-them", "jews");
                FlxG.switchState(new PlayState());
            }
        }
    }

    if (FlxG.keys.justPressed.B && !pressedB)
    {
        pressedB = true;
        trace("pressed b");
    }

    if (FlxG.keys.justPressed.T && pressedB && !pressedT)
    {
        pressedT = true;
        trace("pressed t");
    }

    if (FlxG.keys.justPressed.J && pressedB && pressedT && !pressedJ)
    {
        pressedJ = true;
        trace("pressed j");
    }

    if (pressedB && pressedT && pressedJ)
    {
        sendInTheBlamer();

        pressedB = false;
        pressedT = false;
        pressedJ = false;
    }

    timeTxt.text = getTimeString() + "\n" + getYearString();
}

function toggleFolder()
{
    songFolder.visible = !songFolder.visible;
    eternalSillynessHitbox.visible = songFolder.visible;
    folderCloseHitbox.visible = songFolder.visible;
}

function openUpBrowser()
{
    browserThing.visible = !browserThing.visible;
    browserCloseHitbox.visible = browserThing.visible;
}

function getTimeString():String
{
    var d = Date.now();
    return d.getHours() + ":" + d.getMinutes() + ":" + d.getSeconds();
}

function getYearString():String
{
    var d = Date.now();
    return d.getMonth() + "/" + d.getDay() + "/" + d.getFullYear();
}

function sendInTheBlamer()
{
    btjIsMoving = true;

    btj.x = -200;
    FlxTween.tween(btj, {x: FlxG.width}, 5);
}