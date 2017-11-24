package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author ...
 */
class Door extends FlxSprite 
{

	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);
		loadGraphic(AssetPaths.door__png, false, 32, 96);
		immovable = true;
		
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.collide(this, Reg.p1, openDoor);
	}
	
	function openDoor(d:Door,p:Player):Void
	{
		if (Reg.p1.getKey())
		{
		Reg.p1.doorKey();
		destroy();
		}
	}
}