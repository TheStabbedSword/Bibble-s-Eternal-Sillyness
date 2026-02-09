import funkin.backend.system.framerate.Framerate;
import openfl.system.Capabilities;

function new()
{
    FlxG.save.data.windowResolutionX = Capabilities.screenResolutionX;
    FlxG.save.data.windowResolutionY = Capabilities.screenResolutionY;

    window.fullscreen = false;
    window.resizable = false;
}

function postStateSwitch()
{
    Framerate.fontName = Assets.getPath(Paths.file('fonts/bibblesaveragehandwriting.ttf'));

    Framerate.memoryCounter.visible = false;
    Framerate.codenameBuildField.y = Framerate.memoryCounter.y;
    Framerate.codenameBuildField.text = "Bibble's Eternal Sillyness (IN-DEV)";
}