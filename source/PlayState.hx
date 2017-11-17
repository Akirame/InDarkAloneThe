package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.effects.FlxTrail;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxSpriteUtil;
import openfl.display.BlendMode;

class PlayState extends FlxState
{

	private var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;
	var background:FlxSprite;
	var darkness:FlxSprite;
	var light:Light;

	private var trail:FlxTrail;
	override public function create():Void
	{
		super.create();
		Reg.tilesGroup = new FlxTypedGroup();
		Reg.ladderGroup = new FlxTypedGroup();
		loader = new FlxOgmoLoader(AssetPaths.level1__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 32, 32, "tiles");
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.ANY);		
		loader.loadEntities(placeEntities, "entities");
		FlxG.worldBounds.set(tilemap.width, tilemap.height);
		FlxG.camera.follow(Reg.p1);
		
		background = new FlxSprite();
		background.makeGraphic(FlxG.width, FlxG.height);
		add(background);
		
		
		add(tilemap);
		add(Reg.tilesGroup);
		add(Reg.ladderGroup);
		add(Reg.p1);

		//

		darkness = new FlxSprite(0,0);
		darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
		darkness.blend = BlendMode.MULTIPLY;

		light = new Light(FlxG.width / 2, FlxG.height / 2, darkness);
		light.scale.set(7,7);
		add(light);
		add(darkness);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		light.setPosition(Reg.p1.x+Reg.p1.width/2, Reg.p1.y+Reg.p1.height/2);
		FlxG.collide(tilemap, Reg.p1);
	}

	private function placeEntities(entityName:String, entityData:Xml):Void // inicializar entidades
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

		switch (entityName)
		{
			case "player":
				Reg.p1 = new Player(x, y);
			case "ladder":
				var e = new Tiles(x, y, null);
				Reg.ladderGroup.add(e);
		}
	}

	override public function draw():Void
	{
		FlxSpriteUtil.fill(darkness,0xff000000);
		super.draw();
	}
}