package ;

import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import openfl.display.BlendMode;
import flixel.FlxG;

/**
 * ...
 * @author ...
 */
class Light extends FlxSprite
{ 
    private var darkness:FlxSprite;
    
    public function new(x:Float, y:Float, darkness:FlxSprite):Void{
		super(x, y, "assets/images/glow-light1.png");

		this.darkness = darkness;
		this.blend = BlendMode.SCREEN;
		FlxTween.tween(this, {alpha: 0.7},1.5, {type:FlxTween.PINGPONG});
    }
 
    override public function draw():Void {
      var screenXY:FlxPoint = getScreenPosition();	  
 
      darkness.stamp(this, Std.int(screenXY.x - this.width / 2), Std.int( screenXY.y - this.height / 2));	  
    }
}