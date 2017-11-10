package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author asd
 */
class Player extends FlxSprite 
{

	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(16, 16, 0xFFFF0000);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		velocity.set(0, 0);
				
		if (FlxG.keys.pressed.LEFT)
		{
			velocity.x -= 200;
		}
		if (FlxG.keys.pressed.RIGHT)
		{
			velocity.x += 200;
		}
		if (FlxG.keys.pressed.UP)
		{
			velocity.y -= 200;
		}
		if (FlxG.keys.pressed.DOWN)
		{
			velocity.y += 200;
		}
	}
	
}