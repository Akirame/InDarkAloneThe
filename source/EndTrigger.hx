package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;

/**
 * ...
 * @author G
 */
class EndTrigger extends FlxSprite 
{

	public function new(?X:Float = 0, ?Y:Float = 0)
	{
		super(X, Y);
		makeGraphic(96, 32, 0x00000000);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		FlxG.overlap(this, Reg.p1, endGame);
	}
	
	function endGame(t:EndTrigger,p:Player):Void
	{
		FlxG.camera.follow(this);
		FlxG.camera.fade(FlxColor.BLACK, 5, false, GameOverTrue);
	}
	
		function GameOverTrue():Void
	{
		FlxG.sound.pause();
		Reg._gameOver = true;
	}

}