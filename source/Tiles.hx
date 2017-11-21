package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author G
 */
enum TipoTile
{
	Ladder;
}
class Tiles extends FlxSprite 
{
	private var tipo:TipoTile;
	
	public function new(?X:Float=0, ?Y:Float=0, type:TipoTile) 
	{
		super(X, Y);		
		tipo = type;
		immovable = true;
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);		
	}	
	public function getTipo():TipoTile
	{
		return tipo;
	}
}