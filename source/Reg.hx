package;

import flixel.group.FlxGroup.FlxTypedGroup;
import openfl.display.Tilemap;
import Player;

/**
 * ...
 * @author G
 */
class Reg 
{
	static public var p1:Player;
	static public var tilesGroup:FlxTypedGroup<Tiles>;	
	static public var gravity:Int = 1500;
	static public var velocityX:Int = 150;
	static public var tilemapActual:Tilemap;
}