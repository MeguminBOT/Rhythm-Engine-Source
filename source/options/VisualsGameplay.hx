package options;

import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class VisualsGameplay extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Gameplay Visuals';
		description = 'Options that visually affects your gameplay';
		rpcTitle = 'Gameplay Visuals Settings Menu'; //for Discord Rich Presence

		var option:Option = new Option('Note Skin:',
			"Changes the look of the notes. Doesn't affect custom notes.",
			'noteSkin',
			'string',
			'Rhythm Engine',
			['Default', 
			'Rhythm Engine',
			'Rhythm Engine Circles',
			'Rhythm Engine Bars',
			'StepMania Classic']);
		addOption(option);

		var option:Option = new Option('Note Splashes',
			"If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Lane Transparency:',
			"Changes the transparency of the area behind the playfield\n0 = No background, 1 = Completely black.",
			'underlay',
			'float',
			0);
		option.displayFormat = '%v';
		option.scrollSpeed = 100;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.minValue = 0;
		option.maxValue = 1;
		addOption(option);

		var option:Option = new Option('Opponent Notes',
			'Show opponents notes.',
			'opponentStrums',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option('Strumline Y Offset',
			"Moves the Strumline up or down.\nNegative value = Up / Positive value = Down. \nAffects both player and opponent.",
			'strumlineOffsetY',
			'float',
			0);
		option.scrollSpeed = 10;
		option.changeValue = 0.1;
		option.minValue = -100;
		option.maxValue = 100;
		addOption(option);

		var option:Option = new Option('Strumline X Offset',
			"Moves the Strumline left or right.\nNegative value = Left / Positive value = Right.\nAffects both player and opponent.",
			'strumlineOffsetX',
			'float',
			0);
		option.scrollSpeed = 10;
		option.changeValue = 0.1;
		option.minValue = -100;
		option.maxValue = 100;
		addOption(option);

		super();
	}
}
