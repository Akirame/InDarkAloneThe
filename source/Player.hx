package;

import ilumination.Light;
import ilumination.LightAreaUp;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.effects.FlxTrail;
import flixel.addons.util.FlxFSM;
import flixel.effects.particles.FlxEmitter;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import openfl.display.BlendMode;

/**
 * ...
 * @author asd
 */
class Player extends FlxSprite
{
	public var fsm:FlxFSM<FlxSprite>;
	private var trail:FlxTrail;
	private var gfx:FlxEmitter;	
	private var light:ilumination.Light;
	private var lightCountDown:Float = 100;
	
	static public var wallDirection:Int = 0;
	
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(32, 32, 0xFFFF0000);
		acceleration.y = Reg.gravity;		
		light = new Light(x+width/2,y+height/5, Reg.darkness);
		light.scale.set(Reg.luminity, Reg.luminity);
		FlxG.state.add(light);
		
		fsm = new FlxFSM<FlxSprite>(this);
		fsm.transitions
		.add(Idle, Fall, Conditions.fall)	
		.add(Fall, Idle, Conditions.grounded)
		.start(Idle);
		
		gfx = new FlxEmitter();		
		trail = new FlxTrail(this, null, 10, 3, 0.4);
		
	}
	
	override public function update(elapsed:Float):Void 
	{
		fsm.update(elapsed);
		super.update(elapsed);
		lightOff();
		trace(lightCountDown);
	}
	override public function destroy():Void 
	{
		fsm.destroy();
		fsm = null;
		super.destroy();		
	}
	public function getJump():Void
	{	
		fsm.transitions
		.add(Idle, Jump, Conditions.jump)
		.add(Jump, Idle, Conditions.grounded);	
	}
	public function getWallJump():Void
	{
		fsm.transitions
			.add(Fall,Sliding,Conditions.onWall)
			.add(Jump, Sliding, Conditions.onWall)	
			.add(Sliding, WallJump, Conditions.onWallJump)		
			.add(Sliding, Fall, Conditions.offWall)
			.add(WallJump, Sliding, Conditions.onWall)
			.add(WallJump, Idle, Conditions.grounded);
	}
	
	public function lightOff():Void 
	{
		light.scale.set(lightCountDown*Reg.luminity/100,lightCountDown*Reg.luminity/100);
		light.setPosition(x + width / 2, y + height / 5 );
		if(lightCountDown > 35)
		lightCountDown -= FlxG.elapsed * Reg.luminityDown;
		else
			lightCountDown = 35;
	}
	
	public function lightRenew(l:ilumination.LightAreaUp,p:Player):Void
	{
		if(lightCountDown<100)
		lightCountDown += FlxG.elapsed*20;
		else
		lightCountDown = 100;
	}
	public function lightPlusPlus():Void
	{
		Reg.luminityDown -= 0.1;
	}
	public function percentLight():Float
	{
		return (lightCountDown);
	}
}

class Conditions
{
	public static function jump(owner:FlxSprite):Bool
	{
		return (FlxG.keys.justPressed.Z && owner.isTouching(FlxObject.FLOOR));
	}
	
	public static function grounded(owner:FlxSprite):Bool
	{
		return owner.isTouching(FlxObject.FLOOR);
	}
	public static function onWall(owner:FlxSprite):Bool
	{
		return (owner.isTouching(FlxObject.WALL) && !owner.isTouching(FlxObject.FLOOR));
	}
	public static function onWallJump(owner:FlxSprite):Bool
	{
		return (!owner.isTouching(FlxObject.FLOOR) && FlxG.keys.justPressed.Z);
	}
	public static function offWall(owner:FlxSprite):Bool
	{
		return(owner.isTouching(FlxObject.FLOOR) || FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.RIGHT || !owner.isTouching(FlxObject.WALL));
	}
	public static function fall(owner:FlxSprite):Bool
	{
		return(!owner.isTouching(FlxObject.FLOOR));
	}
	public static function platformFall(owner:FlxSprite):Bool
	{
		return(FlxG.collide(Reg.tileGroup, owner));
	}
}

class Idle extends FlxFSMState<FlxSprite>
{	
	override public function enter(owner:FlxSprite,fsm:FlxFSM<FlxSprite>):Void
	{
		owner.makeGraphic(32, 32, 0xFFFF0000);
	}
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.velocity.x = 0;
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			owner.velocity.x = FlxG.keys.pressed.LEFT ? -Reg.velocityX:Reg.velocityX;
		}
	}
}

class Jump extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.velocity.y -= 400;				
	}
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.velocity.x = 0;
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			owner.velocity.x = FlxG.keys.pressed.LEFT ? -Reg.velocityX:Reg.velocityX;			
		}
	}
}
class Fall extends FlxFSMState<FlxSprite>
{	
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{			
		owner.velocity.x = 0;
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			owner.velocity.x = FlxG.keys.pressed.LEFT ? -Reg.velocityX:Reg.velocityX;			
		}
	}
}
class Sliding extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.makeGraphic(32, 32, 0xFF00FF00);
	}
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		if (owner.isTouching(FlxObject.LEFT))
		{
			owner.velocity.x -= 1;
			Player.wallDirection = -1;
		}
		else if (owner.isTouching(FlxObject.RIGHT))
		{			
			owner.velocity.x += 1;
			Player.wallDirection = 1;
		}
		owner.velocity.y = 0;
	}
	override public function exit(owner:FlxSprite):Void 
	{		
		owner.velocity.x = 0;
	}
}
class WallJump extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.velocity.y -= 400;
		if (Player.wallDirection == -1)
		{
			owner.velocity.x += 200;
			Player.wallDirection = 0;
		}
		else if (Player.wallDirection == 1)
		{
			owner.velocity.x -= 200;		
			Player.wallDirection = 0;
		}
	}
	
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			owner.velocity.x = FlxG.keys.pressed.LEFT ? -Reg.velocityX:Reg.velocityX;			
		}
	}
}