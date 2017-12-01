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
	DROPTEXT;
	START;
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
			case "DROP":
				tipo = DROPTEXT;
			case "START":
				tipo = START;
		}
		textito = new FlxTypeText(x - 70, y - 70,0, "nada", 16);
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
				textito.start(0.05, false, true, null);
			case TypeText.LANTERNTEXT:
				textito.fieldWidth = 250;
				textito.resetText("Stay below the lantern to regain light");
				textito.start(0.02, false, true, null);
			case TypeText.TUTORIALTEXT:
				textito.resetText("Left & Right to move");
				textito.start(0.02, false, true, null);
			case TypeText.DROPTEXT:
				textito.resetText("Press Down to drop off");
				textito.start(0.02, false, true, null);
			case TypeText.START:
				textito.fieldWidth = 200;
				textito.resetText("Find the exit before the light run out");
				textito.italic = true;
				textito.start(0.02, false, true, null);
		}
	}

}