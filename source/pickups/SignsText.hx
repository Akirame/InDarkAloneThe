package pickups;
import flixel.FlxG;
import flixel.addons.text.FlxTypeText;
import pickups.Collectable;

/**
 * ...
 * @author ...
 */
enum TypeText
{
	DOORTEXT;
	LANTERNTEXT;
	TUTORIALTEXT;
}
class SignsText extends Collectable
{
	private var textito:FlxTypeText;
	private var tipo:TypeText;
	public function new(?X:Float=0, ?Y:Float=0,type:String)
	{
		super(X, Y);
		switch (type)
		{
			case "DOOR":
				tipo = DOORTEXT;
			case "TUTORIAL":
				tipo = TUTORIALTEXT;
			case "LANTERN":
				tipo = LANTERNTEXT;
		}
		textito = new FlxTypeText(x - 80, y - 70, 250, "nada", 16);
		textito.delay = 0.1;
		textito.color = 0xFFFFFFFF;
		textito.autoErase = true;
		textito.waitTime = 5.0;
		FlxG.state.add(textito);
		
		makeGraphic(32, 32, 0x00000000);
	}
	override public function pickup(c:Collectable, p:Player):Void
	{
		super.pickup(c, p);
		switch (tipo)
		{
			case TypeText.DOORTEXT:
				textito.resetText("You need a key to open this door");
				textito.start(0.02, false, true, null);
			case TypeText.LANTERNTEXT:
				textito.resetText("Stay below the lantern to regain light");
				textito.start(0.02, false, true, null);
			case TypeText.TUTORIALTEXT:
				textito.resetText("Every second you lose light, if reach 0 you die");
				textito.start(0.02, false, true, null);
		}
	}

}