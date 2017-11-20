package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.addons.effects.FlxTrail;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxRandom;
import flixel.system.FlxSound;
import flixel.tile.FlxTilemap;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;
import openfl.display.BlendMode;
import openfl.display.Tile;

class PlayState extends FlxState
{

	private var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;
	private var background:FlxSprite;
	private var darkness:FlxSprite;
	private var light:Light;
	private var randLightning:FlxRandom;
	private var contaLightning:Float = 0;
	private var lightning:FlxSprite;
	private var thunderSound:FlxSound;		
	private var trail:FlxTrail;
	
	override public function create():Void
	{
		super.create();
		randLightning = new FlxRandom();
		thunderSound = FlxG.sound.load(AssetPaths.thunder__wav, 1);		
		Reg.tilesGroup = new FlxTypedGroup();		
		loader = new FlxOgmoLoader(AssetPaths.level1__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 32, 32, "tiles");
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.ANY);		
		loader.loadEntities(placeEntities, "entities");
		FlxG.worldBounds.set(tilemap.width, tilemap.height);
		FlxG.camera.follow(Reg.p1);
		Reg.tilemapActual = tilemap;
		
		background = new FlxSprite();
		background.loadGraphic(AssetPaths.rainBackground__png, true, 960, 720);
		background.animation.add("active", [0, 1], 8, true);
		background.animation.play("active");
		background.scrollFactor.x = 0.2;
		
		add(tilemap);
		add(Reg.tilesGroup);		
		add(Reg.p1);
		add(background);
	
		//

		darkness = new FlxSprite(0,0);
		darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		darkness.scrollFactor.set(0, 0);
		darkness.blend = BlendMode.MULTIPLY;
		lightning = new FlxSprite(0, 0);
		lightning.makeGraphic(FlxG.width, FlxG.height, 0xFFFFFFFF);
		lightning.scrollFactor.set(0, 0);
		lightning.alpha = 0;
		
		light = new Light(Reg.p1.x+Reg.p1.width/2, Reg.p1.y+Reg.p1.height/2, darkness);
		light.scale.set(7, 7);
		
		add(light);
		add(darkness);
		add(lightning);
		
		FlxG.sound.play(AssetPaths.rain2__wav, 0.2, true);
		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(AssetPaths.rain1__wav,1);	
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);		
		light.setPosition(Reg.p1.x+Reg.p1.width/2, Reg.p1.y+Reg.p1.height/2);
		FlxG.collide(tilemap, Reg.p1);		
		FlxG.collide(Reg.tilesGroup, Reg.p1, tileEffect);		
		LightningOK();
	}	
	function tileEffect(t:Tiles,p:Player):Void
	{		
		
		if (t.getTipo() == Tiles.TipoTile.Ladder && FlxG.keys.justPressed.DOWN)
		{
			t.solid = false;			
		}
	}
	
	function lightningEnd(tween:FlxTween):Void
	{
		FlxTween.tween(lightning, {alpha:0}, 0.2, {type:FlxTween.ONESHOT});
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
				var e = new Tiles(x, y, Tiles.TipoTile.Ladder);
				e.allowCollisions = FlxObject.UP;				
				Reg.tilesGroup.add(e);
		}
	}
	
	function LightningOK():Void 
	{
		if (contaLightning > 30)
		{
			if (randLightning.bool(70))
			{					
				thunderSound.play();
				FlxTween.tween(lightning, {alpha:1}, 0.2, {type:FlxTween.ONESHOT, onComplete:lightningEnd});			
			}
			contaLightning = 0;
		}
		else
			contaLightning += FlxG.elapsed;
	}

	override public function draw():Void
	{
		FlxSpriteUtil.fill(darkness,0xff000000);
		super.draw();
	}
}