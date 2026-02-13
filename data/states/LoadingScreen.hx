var bg:FunkinSprite = new FunkinSprite(0, 0);

function create()
{
    add(bg).loadGraphic(Paths.image("menus/menuBG"));
    bg.scale.set(1.25, 1.25);
    bg.updateHitbox();
    bg.screenCenter();
    bg.antialiasing = true;
}