package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxSpriteUtil;
import openfl.display.BlendMode;


class MenuState extends FlxState
{
  
	private var darkness:FlxSprite;
	private var background:FlxSprite;
	
	override public function create():Void
	{		
		background = new FlxSprite(0, 0, "assets/images/Chrysanthemum.jpg");
		background.makeGraphic(FlxG.width, FlxG.height);

		darkness = new FlxSprite(0,0);
		darkness.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
		darkness.blend = BlendMode.MULTIPLY;

		add(background);		
		var light:Light = new Light(FlxG.width / 2, FlxG.height / 2, darkness);
		add(light);
		add(darkness);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}
	 
	override public function draw():Void {
	  FlxSpriteUtil.fill(darkness,0xff000000);
	  super.draw();
	}
	
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}	
}