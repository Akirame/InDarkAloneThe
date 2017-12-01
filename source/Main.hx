package;

import states.EndScreen;
import states.SplashScreen;
import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, SplashScreen,1,60,60,true));
	}
}