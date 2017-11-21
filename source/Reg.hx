package;

import Tiles;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import pickups.Collectable;

/**
 * ...
 * @author G
 */
class Reg 
{
	static public var p1:Player;
	static public var tileGroup:FlxTypedGroup<Tiles>;	
	static public var gravity:Int = 1500;
	static public var velocityX:Int = 150;	
	static public var tilemapActual:FlxTilemap;
	static public var collectableGroup:FlxTypedGroup<Collectable>;
	static public var darkness:FlxSprite;
}