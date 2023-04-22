package;

import flixel.FlxSprite;

class Project extends FlxSprite
{
    public function new(x:Float = 0.0, y:Float = 0.0, proj:String = 'null.png')
    {
        loadGraphic('assets/images/$proj');
        setPosition(x, y);
        antialiasing = true;

        super(x, y);
    }
}