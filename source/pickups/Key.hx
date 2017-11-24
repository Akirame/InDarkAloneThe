package pickups;
import flixel.FlxG;
import flixel.addons.text.FlxTextField;
import flixel.addons.text.FlxTypeText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import pickups.Collectable;

/**
 * ...
 * @author ...
 */
class Key extends Collectable 
{
	private var textito:FlxTypeText;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		loadGraphic(AssetPaths.key__png, false, 32, 32);
		FlxTween.tween(this, {y:y + 10}, 1, {type:FlxTween.PINGPONG, ease:FlxEase.smoothStepInOut});
		textito = new FlxTypeText(x - 20, y - 30, 250, "nada", 16);
		textito.delay = 0.1;
		textito.color = 0xFFFFFFFF;
		textito.autoErase = true;
		textito.waitTime = 5.0;
		FlxG.state.add(textito);
	}
	override public function pickup(c:Collectable, p:Player):Void 
	{
		super.pickup(c, p);
		textito.resetText("Key!");
		textito.start(0.02, false, true, null);
		FlxG.sound.play(AssetPaths.pickupUpgrade__wav, 0.70);
		Reg.p1.doorKey();
	}
	
}