package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import lime.system.System;

class MenuState extends FlxState
{
	var playButton:FlxButton;
	var menuTXT = new FlxText(375, 150, 500);
	var quitButton:FlxButton;
	var menuMusic:FlxSound;
	var verTXT = new FlxText(0, 675);

	override public function create()
	{
		// Menu Music
		menuMusic = FlxG.sound.load("assets/music/menu.ogg", 0.5, true);
		// Versioin Text
		verTXT.text = "Version 0.0.3 - Map switching + Audio additions";
		verTXT.setFormat("assets/fonts/LeagueGothic.ttf", 35, FlxColor.WHITE, LEFT);
		add(verTXT);
		// Play button draw sequence
		playButton = new FlxButton(590, 400, "Play", clickPlay);
		playButton.scale.set(4, 4);
		//playButton.setSize(300, 175);
		add(playButton);
		// Menu Text
		menuTXT.text = "Project:\nAbsolution";
		menuTXT.setFormat("assets/fonts/Meyrin.ttf", 65, FlxColor.WHITE, CENTER);
		add(menuTXT);
		// Quit Button Draw
		quitButton = new FlxButton(590, 500, "Quit", quitGame);
		quitButton.scale.set(4, 4);
		add(quitButton);
		menuMusic.play();
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}

	function quitGame()
	{
		System.exit(0);
	}
}
