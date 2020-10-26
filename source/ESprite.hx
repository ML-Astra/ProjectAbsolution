package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;

class ESprite extends FlxSprite
{
	static inline var SPEED:Float = 200;

	var walking:FlxSound;

	var up:Bool = false;
	var down:Bool = false;
	var left:Bool = false;
	var right:Bool = false;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		loadGraphic("assets/images/Player.png", true, 32, 32);
		animation.add("walk-dwn", [1, 0, 1, 2], 5, false);
		animation.add("walk-left", [4, 3, 4, 5], 5, false);
		animation.add("walk-right", [7, 6, 7, 8], 5, false);
		animation.add("walk-up", [10, 9, 10, 11], 5, false);

		// Add and load walking sound
		walking = FlxG.sound.load("assets/sounds/walk.wav", 0.5);
		drag.x = drag.y = 1600;

		setSize(32, 32);
		// offset.set(4, 4);
	}

	function updateMovement()
	{
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		if (up && down)
			up = down = false;
		if (left && right)
			left = right = false;

		if (up || down || left || right)
		{
			velocity.x = SPEED;
			velocity.y = SPEED;

			var newAngle:Float = 0;
			if (up)
			{
				newAngle = -90;
				if (left)
					newAngle -= 45;
				else if (right)
					newAngle += 45;
				facing = FlxObject.UP;
			}
			else if (down)
			{
				newAngle = 90;
				if (left)
					newAngle += 45;
				else if (right)
					newAngle -= 45;
				facing = FlxObject.DOWN;
			}
			else if (left)
			{
				newAngle = 180;
				facing = FlxObject.LEFT;
			}
			else if (right)
			{
				newAngle = 0;
				facing = FlxObject.RIGHT;
			}

			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), newAngle);

			if ((velocity.x != 0 || velocity.y != 0) && touching == FlxObject.NONE)
			{
				switch (facing)
				{
					case FlxObject.LEFT:
						animation.play("walk-left");
					case FlxObject.UP:
						animation.play("walk-up");
					case FlxObject.DOWN:
						animation.play("walk-dwn");
					case FlxObject.RIGHT:
						animation.play("walk-right");
				}
				walking.play();
			}
		}
	}

	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}
}
