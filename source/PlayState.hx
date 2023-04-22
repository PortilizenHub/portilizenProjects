package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.FlxObject;

class PlayState extends FlxState {
	var projects:Array<String> = [];
	var projectsINFO:Array<String> = [];
	var projGRP:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	var noProj:FlxText = new FlxText(0, 0, 0, "There are no Projects\nas of right now!", 32);
	var projDes:FlxText = new FlxText(20, 20, 0, "There are no Projects\nas of right now!", 32);

	var selected:Int = 0;

	var camFollow:FlxObject;

	override public function create() {
		FlxG.sound.play('assets/music/indieSettin.wav', 1, true);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		addProject('identity', 'fnf vs impostor v4\nwith lyrics\nidentity crisis\n\n\nQ2 2023');

		for (i in 0...projects.length) {

			var sizeDivider:Int = 4;

			var proj:FlxSprite = new FlxSprite(0, 180 * i, 'assets/images/'+projects[i]+'.png');
			proj.screenCenter(X);
			proj.ID = i;
			proj.setGraphicSize(Std.parseInt(Std.string(proj.width / sizeDivider)), Std.parseInt(Std.string(proj.height / sizeDivider)));
			projGRP.add(proj);
		}

		FlxG.camera.follow(camFollow, null, 0.06);

		if (projects.length < 1){
			noProj.screenCenter();
			noProj.scrollFactor.set(0, 0);
			add(noProj);
			projDes.text = 'project what?';
		}

		projDes.scrollFactor.set(0, 0);
		add(projDes);

		add(projGRP);

		super.create();
	}

	override public function update(elapsed:Float) {
		if (FlxG.keys.justReleased.UP) {
			FlxG.sound.play('assets/sounds/scrollMenu.wav', 0.4);
			selected -= 1;
		}
		if (FlxG.keys.justReleased.DOWN) {
			FlxG.sound.play('assets/sounds/scrollMenu.wav', 0.4);
			selected += 1;
		}

		if (selected > projects.length - 1)
			selected = projects.length - 1;

		if (selected < 0)
			selected = 0;
		
		if (projects.length > 0)
		{
			projDes.text = projectsINFO[selected];
		}

		projGRP.forEach(function(proj:FlxSprite) {
			proj.alpha = 0.5;

			if (selected == proj.ID) {
				proj.alpha = 1;
				camFollow.setPosition(proj.getGraphicMidpoint().x, proj.getGraphicMidpoint().y);
			}
		});

		super.update(elapsed);
	}

	public function addProject(name:String, description:String)
	{
		projects.push(name);
		projectsINFO.push(description);
	}

	public function changeProjectPos(amount:Dynamic)
	{
			projGRP.forEach(function(proj:FlxSprite) {
				proj.y += amount;
			});
	}
}
