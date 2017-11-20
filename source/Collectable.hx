package;

import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */

class Collectable extends FlxSprite 
{
	private var conta:Float = 0;	
	public function new(?X:Float=0, ?Y:Float=0)
	{
		super(X, Y);
		acceleration.y = 500;
	}
	
	override public function update(elapsed:Float):Void 
	{
		FlxG.collide(this, Reg.tilemapActual);
		super.update(elapsed);
		if (conta > 5)
		destroy();
		conta += FlxG.elapsed;
		FlxG.overlap(this, Reg.p1, pickup);
		FlxG.collide(this, Reg.tilesGroup);
	}
	
	public function pickup(c:Collectable,p:Player):Void
	{
		c.destroy();
	}
}
