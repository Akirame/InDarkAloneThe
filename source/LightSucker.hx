package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.effects.FlxFlicker;
/**
 * ...
 * @author G
 */
class LightSucker extends FlxSprite 
{

	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);
		loadGraphic(AssetPaths.blackHole__png, true, 32, 32);
		animation.add("active", [0, 1], 4, true);
		animation.play("active");
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (FlxG.overlap(this, Reg.p1))
		{
			Reg.lightCountDown -= FlxG.elapsed * 10;
			FlxFlicker.flicker(Reg.p1, 0.3, 0.09, true, false);
		}
	}
	
}