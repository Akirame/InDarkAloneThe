package;

import Tiles;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import ilumination.Light;
import ilumination.LightAreaUp;
import ilumination.Torch;
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
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import openfl.display.BlendMode;
import openfl.display.Tile;
import pickups.Upgrades;

class PlayState extends FlxState
{

	private var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;
	private var background:FlxSprite;
	private var darkness:FlxSprite;	
	private var randLightning:FlxRandom;
	private var contaLightning:Float = 0;
	private var lightning:FlxSprite;
	private var thunderSound:FlxSound;		
	private var trail:FlxTrail;
	private var _barLight:FlxBar;
	private var battery:FlxSprite;
	
	override public function create():Void
	{
		super.create();
		
		
		
		randLightning = new FlxRandom();
		thunderSound = FlxG.sound.load(AssetPaths.thunder__wav, 1);		
		Reg.darkness = new FlxSprite(0,0);
		Reg.darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		Reg.darkness.scrollFactor.set(0, 0);
		Reg.darkness.blend = BlendMode.MULTIPLY;
		Reg.spritesGroup = new FlxTypedGroup();
		
		Reg.tileGroup = new FlxTypedGroup();		
		loader = new FlxOgmoLoader(AssetPaths.level1__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 32, 32, "tiles");
		tilemap.setTileProperties(0, FlxObject.NONE);
		tilemap.setTileProperties(1, FlxObject.ANY);
		tilemap.setTileProperties(2, FlxObject.ANY, Falloff);
		loader.loadEntities(placeEntities, "entities");
		FlxG.worldBounds.set(tilemap.width, tilemap.height);
		FlxG.camera.follow(Reg.p1);
		Reg.tilemapActual = tilemap;
		
		battery = new FlxSprite(19, FlxG.height - 50, AssetPaths.battery__png);
		battery.scrollFactor.set(0, 0);
		_barLight = new FlxBar(20, FlxG.height - 50, LEFT_TO_RIGHT, 99, 20, Reg.p1, "lightCountDown", 35, 100);
		_barLight.createFilledBar(FlxColor.BLACK, FlxColor.WHITE, false, FlxColor.WHITE);
		_barLight.numDivisions = 100;
		_barLight.scrollFactor.set(0, 0);
		
		background = new FlxSprite();
		background.loadGraphic(AssetPaths.rainBackground__png, true, 960, 720);
		background.animation.add("active", [0, 1], 8, true);
		background.animation.play("active");
		background.scrollFactor.x = 0.2;
		
		add(tilemap);
		add(Reg.tileGroup);				
		add(Reg.spritesGroup);
		add(Reg.p1); 
		
		
	
		//

		
		lightning = new FlxSprite(0, 0);
		lightning.makeGraphic(FlxG.width, FlxG.height, 0xFFFFFFFF);
		lightning.scrollFactor.set(0, 0);
		lightning.alpha = 0;
		
	
		add(Reg.darkness);
		add(lightning);
		
		FlxG.sound.play(AssetPaths.rain2__wav, 0.2, true);
		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(AssetPaths.rain1__wav,1);	
		}
	}
	
	function Falloff(t:FlxObject, o:FlxObject):Void
	{
		if (FlxG.keys.justPressed.DOWN)
		t.allowCollisions = FlxObject.NONE;
		else if (o.y >= t.y)
		t.allowCollisions = FlxObject.CEILING;
	}

	override public function update(elapsed:Float):Void
	{
		respawnEntities();
		super.update(elapsed);			
		FlxG.collide(tilemap, Reg.p1);			
		LightningOK();
	}		

	private function placeEntities(entityName:String, entityData:Xml):Void // inicializar entidades
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

		switch (entityName)
		{
			case "player":
				Reg.p1 = new Player(x, y);
			case "upgradeJump":
				var e = new pickups.Upgrades(x, y, TypeUpgrade.JUMP);
				Reg.spritesGroup.add(e);
				e.kill();
			case "upgradeWallJump":
				var e = new pickups.Upgrades(x, y, TypeUpgrade.WALLJUMP);		
				Reg.spritesGroup.add(e);
				e.kill();
			case "torch":
				var e = new ilumination.Torch(x, y,(Std.parseInt(entityData.get("direction"))));			
				Reg.spritesGroup.add(e);
				e.kill();
			case "lightUp":
				var e = new ilumination.LightAreaUp(x, y);
				Reg.spritesGroup.add(e);
				e.kill();
			case "torchUp":
				var e = new Upgrades(x, y, TypeUpgrade.LIGHT);
				Reg.spritesGroup.add(e);
				e.kill();
		}
	}
	
	function LightningOK():Void 
	{
		if (contaLightning > 30)
		{
			if (randLightning.bool(70))
			{					
				thunderSound.play();
				camera.flash(FlxColor.WHITE, 1.5);		
				FlxG.camera.shake(0.025, 1);	
			}
			contaLightning = 0;
		}
		else
			contaLightning += FlxG.elapsed;
	}

	public function respawnEntities():Void
	{
		for (entities in Reg.spritesGroup)
		{
			if (entities.isOnScreen() && !entities.alive)
				entities.revive();
			else if (!entities.isOnScreen() && entities.alive)
				entities.kill();
		}
	}
	
	override public function draw():Void
	{
		FlxSpriteUtil.fill(Reg.darkness, 0xff000000);		
		add(_barLight);
		add(battery);
		super.draw();
	}
}