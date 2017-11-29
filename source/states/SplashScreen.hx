package states;

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

	override public function create():Void 
	{
		super.create();
		var textoTitle:FlxText = new FlxText(FlxG.camera.width / 4, FlxG.camera.y-80, 0, "DarkInTheAlone", 64);
		var textoP1:FlxText = new FlxText(FlxG.camera.width / 2, FlxG.camera.height/2, 0, "by", 48);
		var textoP2:FlxText = new FlxText(FlxG.camera.width / 2 - 80, FlxG.camera.height / 2 + 54, 0, "Gaston Villalba", 48);
		var textoP3:FlxText = new FlxText(FlxG.camera.width / 4, FlxG.camera.width / 2 + 60, 0, "Press Z to Start", 48);
		FlxFlicker.flicker(textoP3, 0, 1, true, true);
		add(textoTitle);
		add(textoP1);
		add(textoP2);
		add(textoP3);
		
		textoTitle.color = 0xFFFF00FF;
		FlxTween.tween(textoTitle, {y: FlxG.camera.height / 2 - 100}, 3, {ease:FlxEase.smoothStepIn, type:FlxTween.ONESHOT});
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);		
		if (FlxG.keys.justPressed.Z)
		{
			FlxG.switchState(new states.PlayState());
		}
	}
	
}