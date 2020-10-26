package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class SplashScreen extends FlxState
{
	var splash = new FlxSprite();
	var count:Int;
	var splashSound:FlxSound;

	var splashTXT = new FlxText(375, 150, 500);

	override public function create()
	{
		// Loads splash sound
		splashSound = FlxG.sound.load("assets/sounds/Splash.wav");

		// Loads Logo image and makes it 128x128
		splash.loadGraphic("assets/images/Zer0Media.png");
		add(splash);
		splash.x = 620;
		splash.y = 310;
		splash.scale.set(5, 5);
		count = 0;

		// Loads font and sets it's size
		splashTXT.text = "Zer0Media";
		splashTXT.setFormat("assets/fonts/Meyrin.ttf", 70, FlxColor.WHITE, CENTER);
		add(splashTXT);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (count == 1)
		{
			splashSound.play();
		};

		if (count == 300)
		{
			FlxG.switchState(new MenuState());
		}
		else
		{
			count++;
		};
		super.update(elapsed);
	}
}
