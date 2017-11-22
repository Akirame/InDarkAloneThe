package ilumination;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class LightAreaUp extends FlxSprite 
{
	private var light:Light;
	
	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);
		loadGraphic(AssetPaths.lantern__png, true, 64, 128);
		animation.add("idle", [0, 1, 2, 3, 4, 3, 2, 1], 3, true);
		animation.play("idle");
		light = new Light(x+width/2,y+height/2, Reg.darkness);
		light.scale.set(7, 7);		
		FlxG.state.add(light);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.overlap(this, Reg.p1, Reg.p1.lightRenew);
	}
}