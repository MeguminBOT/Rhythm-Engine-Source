package;

import Section.SwagSection;
import haxe.Json;
import haxe.format.JsonParser;
import lime.utils.Assets;

#if sys
import sys.io.File;
import sys.FileSystem;
#end

using StringTools;

typedef SwagSong =
{
	var song:String;
	var notes:Array<SwagSection>;
	var events:Array<Dynamic>;
	var bpm:Float;
	var needsVoices:Bool;
	var speed:Float;

	var player1:String;
	var player2:String;
	var gfVersion:String;
	var stage:String;

	var uiSkin:String;
	var arrowSkin:String;
	var splashSkin:String;

	//Fatass Data
	var artist:String;
	var mod:String;
	var isRemix:String;
	var charter:String;
	var hasCustomNotes:String;
	var hasCustomMechanics:String;
	var hasFlashingLights:String;
	var extraComment:String;
}

class Song
{
	public var song:String;
	public var notes:Array<SwagSection>;
	public var events:Array<Dynamic>;
	public var bpm:Float;
	public var needsVoices:Bool = true;
	public var arrowSkin:String;
	public var splashSkin:String;
	public var speed:Float = 1;
	public var stage:String;
	public var player1:String = 'bf';
	public var player2:String = 'dad';
	public var gfVersion:String = 'gf';

	//Fatass Data
	public var artist:String = '';
	public var mod:String = '';
	public var isRemix:String = '';
	public var charter:String = '';
	public var hasCustomNotes:String = '';
	public var hasCustomMechanics:String = '';
	public var hasFlashingLights:String = '';
	public var extraComment:String = '';

	private static function onLoadJson(songJson:Dynamic) // Convert old charts to newest format
	{
		if(songJson.gfVersion == null)
		{
			songJson.gfVersion = songJson.player3;
			songJson.player3 = null;
		}

		if(songJson.events == null)
		{
			songJson.events = [];
			for (secNum in 0...songJson.notes.length)
			{
				var sec:SwagSection = songJson.notes[secNum];

				var i:Int = 0;
				var notes:Array<Dynamic> = sec.sectionNotes;
				var len:Int = notes.length;
				while(i < len)
				{
					var note:Array<Dynamic> = notes[i];
					if(note[1] < 0)
					{
						songJson.events.push([note[0], [[note[2], note[3], note[4]]]]);
						notes.remove(note);
						len = notes.length;
					}
					else i++;
				}
			}
		}
	}

	public function new(song, notes, bpm)
	{
		this.song = song;
		this.notes = notes;
		this.bpm = bpm;
	}

	public static function loadFromJson(jsonInput:String, ?folder:String):SwagSong
	{
		var rawJson = null;
		try {
			var formattedFolder:String = Paths.formatToSongPath(folder);
			var formattedSong:String = Paths.formatToSongPath(jsonInput);
			#if MODS_ALLOWED
			var moddyFile:String = Paths.modsJson(formattedFolder + '/' + formattedSong);
			if(FileSystem.exists(moddyFile)) {
				rawJson = File.getContent(moddyFile).trim();
			}
			#end

			if(rawJson == null) {
				#if sys
				rawJson = File.getContent(Paths.json(formattedFolder + '/' + formattedSong)).trim();
				#else
				rawJson = Assets.getText(Paths.json(formattedFolder + '/' + formattedSong)).trim();
				#end
			}

			while (!rawJson.endsWith("}"))
			{
				rawJson = rawJson.substr(0, rawJson.length - 1);
				// LOL GOING THROUGH THE BULLSHIT TO CLEAN IDK WHATS STRANGE
			}

			// FIX THE CASTING ON WINDOWS/NATIVE
			// Windows???
			// trace(songData);

			// trace('LOADED FROM JSON: ' + songData.notes);
			/* 
				for (i in 0...songData.notes.length)
				{
					trace('LOADED FROM JSON: ' + songData.notes[i].sectionNotes);
					// songData.notes[i].sectionNotes = songData.notes[i].sectionNotes
				}

					daNotes = songData.notes;
					daSong = songData.song;
					daBpm = songData.bpm; */

			var songJson:Dynamic = parseJSONshit(rawJson);
			if(jsonInput != 'events') StageData.loadDirectory(songJson);
			onLoadJson(songJson);
			return songJson;
		} catch (e:Dynamic) {
			trace('Error loading JSON file: ' + e);
			// Fallback to a default SwagSong object or handle the error appropriately.
			return getDefaultSwagSong();
		}
	}

	public static function parseJSONshit(rawJson:String):SwagSong
	{
		return cast Json.parse(rawJson).song;
	}
	private static function getDefaultSwagSong():SwagSong
	{
		return 
		{
			song: "",
			notes: [],
			events: [],
			bpm: 0,
			needsVoices: true,
			speed: 0,
			player1: "bf",
			player2: "dad",
			gfVersion: "gf",
			stage: "",
			uiSkin: "",
			arrowSkin: "",
			splashSkin: "",
			validScore: false,
			artist: "",
			isRemix: "",
			mod: "",
			charter: "",
			hasCustomNotes: "",
			hasCustomMechanics: "",
			hasFlashingLights: "",
			extraComment: "ERROR: JSON NOT FOUND"
    	};
	}
}
