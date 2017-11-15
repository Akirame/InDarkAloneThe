package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import openfl.display.BlendMode;

class PlayState extends FlxState
{

	private var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;
	var p1:Player;
	var background:FlxSprite;
	var darkness:FlxSprite;
	var light:Light;

	override public function create():Void
	{
		super.create();
		loader = new FlxOgmoLoader(AssetPaths.level1__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 16, 16, "tiles");
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.ANY);
		tilemap.setTileProperties(2, FlxObject.NONE);
		loader.loadEntities(placeEntities, "entities");
		add(tilemap);
		add(p1);

		//

		darkness = new FlxSprite(0,0);
		darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
		darkness.blend = BlendMode.MULTIPLY;

		light = new Light(FlxG.width / 2, FlxG.height / 2, darkness);
		add(light);
		add(darkness);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		light.setPosition(p1.x-light.width, p1.y);
		FlxG.collide(tilemap, p1);
	}

	private function placeEntities(entityName:String, entityData:Xml):Void // inicializar entidades
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

		switch (entityName)
		{
			case "player":
				p1 = new Player(x, y);
		}
	}

	override public function draw():Void
	{
		FlxSpriteUtil.fill(darkness,0xff000000);
		super.draw();
	}
}