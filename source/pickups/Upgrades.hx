package pickups;
import flixel.FlxG;
import flixel.addons.text.FlxTypeText;
import flixel.effects.particles.FlxEmitter;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import pickups.Collectable;

/**
 * ...
 * @author G
 */
enum TypeUpgrade
{
	JUMP;
	WALLJUMP;
}
class Upgrades extends pickups.Collectable 
{
	private var tipo:TypeUpgrade;
	private var textito:FlxTypeText;
	private var particles:FlxEmitter;
	
	public function new(?X:Float=0, ?Y:Float=0,type:TypeUpgrade) 
	{
		super(X, Y);
		textito = new FlxTypeText(x - 50, y - 30, 300, "nada", 16);		
		textito.delay = 0.1; 
		textito.color = 0xFFFFFFFF;		
		textito.autoErase = true;
		textito.waitTime = 5.0;
		tipo = type;
		particles = new FlxEmitter(x+width/2, y+height/2);
		particles.makeParticles(4, 4, FlxColor.WHITE, 200);
		particles.launchAngle.set(-180, 180);
		particles.velocity.set( -100, -100, 100, 100);
		particles.lifespan.set(0.1, 1.5);

		
		switch (tipo) 
		{
			case TypeUpgrade.JUMP:
				loadGraphic(AssetPaths.upgradeJump__png, false, 32, 32);
			case TypeUpgrade.WALLJUMP:
				loadGraphic(AssetPaths.upgradeWallJump__png, false, 32, 32);
		}
		FlxTween.tween(this, {y:y + 10}, 1, {type:FlxTween.PINGPONG, ease:FlxEase.smoothStepInOut });
		FlxG.state.add(textito);
		FlxG.state.add(particles);
		particles.start(false, 0.05);
	}
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		particles.setPosition(x+width/2, y+height/2);
	}
	
	override public function pickup(c:Collectable, p:Player):Void 
	{
		super.pickup(c, p);
			switch (tipo) 
		{
			case TypeUpgrade.JUMP:
				Reg.p1.getJump();
				textito.resetText("Press Z to Jump");
				textito.start(0.02, false, true, null);			
				particles.destroy();
				FlxG.sound.play(AssetPaths.pickupUpgrade__wav, 0.70);
			case TypeUpgrade.WALLJUMP:
				Reg.p1.getWallJump();
				textito.resetText("WallJump!");
				textito.start(0.02, false, true, null);				
				particles.destroy();
				FlxG.sound.play(AssetPaths.pickupUpgrade__wav, 0.70);
		}
	}
}