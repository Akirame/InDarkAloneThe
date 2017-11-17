package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.effects.FlxTrail;
import flixel.addons.util.FlxFSM;
import flixel.effects.particles.FlxEmitter;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * ...
 * @author asd
 */
class Player extends FlxSprite 
{
	public var fsm:FlxFSM<FlxSprite>;
	private var trail:FlxTrail;
	private var gfx:FlxEmitter;
	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(32, 32, 0xFFFF0000);
		acceleration.y = 1500;
		fsm = new FlxFSM<FlxSprite>(this);
		fsm.transitions
		.add(Idle, Jump, Conditions.jump)
		.add(Jump, Idle, Conditions.grounded)
		.add(Jump, DoubleJump, Conditions.doubleJump)
		.add(DoubleJump, Idle, Conditions.grounded)
		.start(Idle);
		
		gfx = new FlxEmitter();
		gfx.
		trail = new FlxTrail(this, null, 10, 3, 0.4);
		FlxG.state.add(trail);
	}
	
	override public function update(elapsed:Float):Void 
	{
		fsm.update(elapsed);
		super.update(elapsed);
	}
	override public function destroy():Void 
	{
		fsm.destroy();
		fsm = null;
		super.destroy();		
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
	public static function doubleJump(owner:FlxSprite):Bool
	{
		return (FlxG.keys.justPressed.Z && !owner.isTouching(FlxObject.FLOOR));
	}
}

class Idle extends FlxFSMState<FlxSprite>
{	
	override public function enter(owner:FlxSprite,fsm:FlxFSM<FlxSprite>):Void
	{
		
	}
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.velocity.x = 0;
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			owner.velocity.x = FlxG.keys.pressed.LEFT ? -300:300;
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
			owner.velocity.x = FlxG.keys.pressed.LEFT ? -300:300;
		}
	}
}
class DoubleJump extends FlxFSMState<FlxSprite>
{
	override public function enter(owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
		owner.velocity.y -= 800;
	}
	
	override public function update(elapsed:Float, owner:FlxSprite, fsm:FlxFSM<FlxSprite>):Void 
	{
			owner.velocity.x = 0;
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.RIGHT)
		{
			owner.velocity.x = FlxG.keys.pressed.LEFT ? -300:300;
		}
	}
}