package;

import flixel.FlxSprite;

class Transport extends FlxSprite
{
	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic("assets/images/TP-Sprite.png", true, 32, 32);
		animation.add("tp", [0, 1, 0, 1], 3, true);
	}

	override function update(elapsed:Float)
	{
		animation.play("tp");
		super.update(elapsed);
	}

	override function kill()
	{
		alive = false;
		// FlxTween.tween(this, {alpha: 0, y: y - 16}, 0.33, {ease: FlxEase.circOut, onComplete: finishKill});
	}

	function finishKill(_)
	{
		exists = false;
	}
}
