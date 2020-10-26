package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.tile.FlxTilemap;

class StartArea extends FlxState
{
	var eSprite:ESprite;
	var map:FlxOgmo3Loader;
	var floor:FlxTilemap;
	var walls:FlxTilemap;
	var zoom:Float = 2;

	override public function create():Void
	{
		// Load Ogmo+Json for StartArea-Floors
		map = new FlxOgmo3Loader("assets/data/Absolution.ogmo", "assets/data/Start-Area.json");
		// Load TileMap for Floors
		floor = map.loadTilemap("assets/data/tiles.png", "floor");
		setFloorTiles();
		walls = map.loadTilemap("assets/data/tiles.png", "walls");
		//setWallTiles();
		add(floor);
		add(walls);

		eSprite = new ESprite();
		map.loadEntities(placeEntities, "entities");
		add(eSprite);
		FlxG.camera.follow(eSprite, TOPDOWN, 1);
		FlxG.camera.zoom = zoom;
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.collide(eSprite, walls);
	}

	function setFloorTiles()
	{
		floor.setTileProperties(1, FlxObject.NONE);
		floor.setTileProperties(2, FlxObject.NONE);
	}

	function setWallTiles()
	{
		walls.setTileProperties(12, FlxObject.ANY, null, null, 27);
	}

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			eSprite.setPosition(entity.x, entity.y);
		}
	}
}
