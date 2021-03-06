package states;

import flixel.FlxSprite;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import ilumination.LightAreaUp;
import ilumination.LightMenu;
import ilumination.Torch;
import openfl.display.BlendMode;
import states.PlayState;
import flixel.FlxG;
import flixel.FlxState;
import flixel.effects.FlxFlicker;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

/**
 * ...
 * @author G
 */
class SplashScreen extends FlxState 
{
	private var tilemap:FlxTilemap;
	private var loader:FlxOgmoLoader;
	private var background:FlxSprite;
	private var darkness:FlxSprite;
	var textoTitle:FlxText;
	var textoP3:FlxText;
	var textoP2:FlxText;


	override public function create():Void 
	{
		super.create();
		
		Reg.darkness = new FlxSprite(0,0);
		Reg.darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		Reg.darkness.scrollFactor.set(0, 0);
		Reg.darkness.blend = BlendMode.MULTIPLY;
		
		
		loader = new FlxOgmoLoader(AssetPaths.level2__oel);
		tilemap = loader.loadTilemap(AssetPaths.tiles__png, 32, 32, "tiles");
		loader.loadEntities(placeEntities, "entities");
		
		background = new FlxSprite();
		background.loadGraphic(AssetPaths.rainBackground__png, true, 960, 720);
		background.animation.add("active", [0, 1], 8, true);
		background.animation.play("active");
		background.scrollFactor.set(0, 0);
		
		add(tilemap);
		add(background);
		add(Reg.darkness);
		
		FlxG.sound.play(AssetPaths.rain2__wav, 0.2, true);
		if (FlxG.sound.music == null)
		{
			FlxG.sound.playMusic(AssetPaths.rain1__wav,1);
		}
		
		textoTitle = new FlxText(FlxG.camera.width / 4 - 50, FlxG.camera.height / 2 + 40, 0, "In the Darkness", 64);
		textoTitle.alpha = 0;
		textoP2 = new FlxText(FlxG.camera.width / 2 - 80, FlxG.camera.height-58, 0, "Gaston Villalba", 48);
		textoP3 = new FlxText(FlxG.camera.width / 4, FlxG.camera.width / 2 + 60, 0, "Press Z to Start", 48);
		FlxFlicker.flicker(textoP3, 0, 1, true, true);
		add(textoTitle);
		
		
		textoTitle.color = 0xFF990000;
		
		FlxTween.tween(textoTitle, {alpha: 1}, 5, {ease:FlxEase.smoothStepIn, type:FlxTween.ONESHOT,onComplete:lightning});
	}
	
	function lightning(t:FlxTween):Void
	{
		camera.flash(FlxColor.WHITE, 1.5);
		FlxG.camera.shake(0.025, 1);
		FlxG.sound.play(AssetPaths.thunder__wav);
		add(textoP2);
		add(textoP3);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);		
		if (FlxG.keys.justPressed.Z)
		{
			FlxG.switchState(new states.PlayState());
		}
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void // inicializar entidades
	{
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));

		switch (entityName)
		{
			case "lantern":
				var e = new LightMenu(x, y);
				add(e);
			case "torch":
				var e = new ilumination.Torch(x, y, (Std.parseInt(entityData.get("direction"))));
				add(e);
			
		}
	}
	
	override public function draw():Void
	{
		FlxSpriteUtil.fill(Reg.darkness, 0xff000000);
		super.draw();
	}
}