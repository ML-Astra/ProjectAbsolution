package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	var eSprite:ESprite;
	var map:FlxOgmo3Loader;
	var tiles:FlxTilemap;
	var walls:FlxTilemap;
	var map2:FlxOgmo3Loader;
	var tp:Transport;
	var z:Float = 2;

	override public function create()
	{
		// TODO: Create Map+Player Swapping OTF
		// Load Ogmo file
		map = new FlxOgmo3Loader("assets/data/Absolution.ogmo", "assets/data/l1.json");
		map2 = new FlxOgmo3Loader("assets/data/Absolution.ogmo", "assets/data/l1.json");
		// Load Tilemap for Layer "Floor"
		tiles = map.loadTilemap("assets/data/tiles.png", "floor");
		// tiles.follow();
		// Grass Floor item
		tiles.setTileProperties(1, FlxObject.NONE);
		add(tiles);
		// Load tilemap for layer "walls"
		walls = map2.loadTilemap("assets/data/tiles.png", "walls");
		// walls.follow();
		// Horizon Wall
		walls.setTileProperties(264, FlxObject.ANY);
		// Vertical Wall
		walls.setTileProperties(276, FlxObject.ANY);
		// Left cap barrier
		walls.setTileProperties(265, FlxObject.ANY);
		// Mid Barrier
		walls.setTileProperties(266, FlxObject.ANY);
		// Right Cap Barrier
		walls.setTileProperties(267, FlxObject.ANY);
		// MapMarker
		walls.setTileProperties(576, FlxObject.NONE);
		add(walls);

		// Player Load
		eSprite = new ESprite();
		tp = new Transport();

		// Load Entity map
		map.loadEntities(placeEntities, "entities");

		// Final Stage
		add(eSprite);
		add(tp);
		FlxG.camera.follow(eSprite, TOPDOWN, 1);
		FlxG.camera.zoom = z;
		super.create();
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			eSprite.setPosition(entity.x, entity.y);
		}
		else if (entity.name == "Transport")
		{
			tp.setPosition(entity.x, entity.y);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(eSprite, walls);
		FlxG.overlap(eSprite, tp, playerTP);
	}

	function playerTP(eSprite:ESprite, tp:Transport)
	{
		FlxG.switchState(new StartArea());
	}
}
