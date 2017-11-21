package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class Torch extends FlxSprite 
{
	private var light:Light;
	
	public function new(?X:Float = 0, ?Y:Float = 0,dir:Int)
	{
		super(X, Y);		
		loadGraphic(AssetPaths.torchTile__png, true, 32, 32);
		setFacingFlip(FlxObject.LEFT, true, false);
		setFacingFlip(FlxObject.RIGHT, false, false);
		
		animation.add("idle", [0, 1], 8, true);
		animation.play("idle");
		scale.set(1.5,1.5);
		
		light = new Light(x+width/2,y+height/2, Reg.darkness);
		light.scale.set(7, 7);		
		FlxG.state.add(light);
		
		if (dir == 1)
		facing = FlxObject.RIGHT;
		else if (dir == -1)
		facing = FlxObject.LEFT;
	}
	
	
}