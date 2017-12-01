package ilumination;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
class EndLight extends FlxSprite 
{

	private var light:Light;
	
	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);		
		makeGraphic(32, 32, 0x00000000);
		light = new Light(x+width/2,y+height/2, Reg.darkness);
		light.scale.set(7, 7);		
		FlxG.state.add(light);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
	}
}