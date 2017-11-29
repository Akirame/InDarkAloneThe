package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class LightSucker extends FlxSprite 
{

	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);
		makeGraphic(32, 32, 0xFFFFFFFF);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (FlxG.overlap(this, Reg.p1))
		{
			Reg.lightCountDown -= FlxG.elapsed * 10;
		}
	}
	
}