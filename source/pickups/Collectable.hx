package pickups;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author Yope
 */
class Collectable extends FlxSprite 
{
	private var conta:Float = 0;
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);		
	}
	
	override public function update(elapsed:Float):Void 
	{		
		super.update(elapsed);
		FlxG.overlap(this, Reg.p1, pickup);		
	}
	
	public function pickup(c:Collectable,p:Player):Void
	{
		c.destroy();
	}
}