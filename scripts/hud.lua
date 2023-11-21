local font = "comic.ttf"

function onCreatePost()
	addHaxeLibrary("Std")
	addHaxeLibrary("Math")
    addHaxeLibrary('FlxMath', 'flixel.math')
	addHaxeLibrary('FlxTween', 'flixel.tweens')

	makeLuaSprite("healthBarDave", "ui/healthBar", 0, 0)
	setObjectCamera("healthBarDave", 'hud')
	addLuaSprite("healthBarDave", false)
	setObjectOrder("healthBarDave", getObjectOrder("healthBar"))
	setProperty("healthBarBG.visible", false)

	makeLuaSprite("timeBarDave", "ui/timerBar", 0, 0)
	setObjectCamera("timeBarDave", 'hud')
	addLuaSprite("timeBarDave", false)
	setObjectOrder("timeBarDave", getObjectOrder("timeBar"))
	screenCenter("timeBarDave", 'x')
	setProperty("timeBarDave.alpha", 0)

	makeLuaSprite("iconP12", "icons/missing", 0, 0)
	makeLuaSprite("iconP22", "icons/missing", 0, 0)
	--setProperty("timeBarBG.color", getColorFromHex("808080"))
	setProperty("timeBar.color", getColorFromHex("90ee90"))

	local creditsText = false;
	local yPOS = getProperty("healthBar.y") + 50
	if creditsText then yPOS = getProperty("healthBar.y") + 30 end

	makeLuaText("kadeEngineWatermark", songName, 0, 4, yPOS)
	setScrollFactor("kadeEngineWatermark", 0.0, 0.0)
	setTextSize("kadeEngineWatermark", 16)
	setTextBorder("kadeEngineWatermark", 1.25, "000000")
	addLuaText("kadeEngineWatermark")

	setTextFont("kadeEngineWatermark", font)
	setTextFont("scoreTxt", font)
	setTextFont("timeTxt", font)
	setProperty("timeTxt.y", getProperty("timeTxt.y") - 10)
	setProperty("scoreTxt.y", getProperty("scoreTxt.y") + 15)
end

function onSongStart()
	doTweenAlpha("timeBarDave", "timeBarDave", 1, 0.5 / playbackRate, "circOut")
end

function onUpdate(elapsed)
	setProperty("healthBarDave.x", getProperty("healthBar.x") - 4)
	setProperty("healthBarDave.y", getProperty("healthBar.y") - 4)
	--[[screenCenter("timeBar", 'x')
	setObjectCamera("timeBar", getObjectOrder("timeBarBG") - 1)
	setProperty("timeBar.y", getProperty("timeBar.y") - 1)--]]
	scaleObject("timeBarBG", 1.48, 0.68, true)
	scaleObject("timeBar", 1.48, 0.68, true)
	setProperty("timeBar.x", getProperty("timeBarDave.x") + 8.9)
	setProperty("timeBarDave.y", getProperty("timeBar.y") - 6.35)
	runHaxeCode([[
		var thingy = 0.88;

		game.getLuaObject("iconP12", false).setGraphicSize(Std.int(FlxMath.lerp(150, game.getLuaObject("iconP12", false).width, thingy)),Std.int(FlxMath.lerp(150, game.getLuaObject("iconP12", false).height, thingy)));
		game.getLuaObject("iconP12", false).updateHitbox();

		game.getLuaObject("iconP22", false).setGraphicSize(Std.int(FlxMath.lerp(150, game.getLuaObject("iconP22", false).width, thingy)),Std.int(FlxMath.lerp(150, game.getLuaObject("iconP22", false).height, thingy)));
		game.getLuaObject("iconP22", false).updateHitbox();

		game.iconP1.y = Std.int(FlxMath.lerp(game.healthBar.y - 70, game.iconP1.y, thingy));
		game.iconP2.y = Std.int(FlxMath.lerp(game.healthBar.y - 70, game.iconP2.y, thingy));

		var iconOffset = 26;
		game.getLuaObject("iconP12", false).x = game.healthBar.x + (game.healthBar.width * (FlxMath.remapToRange(game.healthBar.percent, 0, 100, 100, 0) * 0.01)) + (150 * game.getLuaObject("iconP12", false).scale.x - 150) / 2 - iconOffset;
		game.getLuaObject("iconP22", false).x = game.healthBar.x + (game.healthBar.width * (FlxMath.remapToRange(game.healthBar.percent, 0, 100, 100, 0) * 0.01)) - (150 * game.getLuaObject("iconP22", false).scale.x) / 2 - iconOffset * 2;
		//FlxTween.tween(game.getLuaObject("iconP12", false), {x: game.healthBar.x + (game.healthBar.width * (FlxMath.remapToRange(game.healthBar.percent, 0, 100, 100, 0) * 0.01)) + (150 * game.getLuaObject("iconP12", false).scale.x - 150) / 2 - iconOffset}, (thingy / 2));
		//FlxTween.tween(game.getLuaObject("iconP22", false), {x: game.healthBar.x + (game.healthBar.width * (FlxMath.remapToRange(game.healthBar.percent, 0, 100, 100, 0) * 0.01)) - (150 * game.getLuaObject("iconP22", false).scale.x) / 2 - iconOffset * 2}, (thingy / 2));
	]])
	updateHitbox('iconP12')
	updateHitbox('iconP22')
end
function onUpdatePost(elapsed)
	local translatedScore = getDataFromSave("UntitledVsDavePortSettings", "textInLanguages")
	setTextString("scoreTxt", tostring(translatedScore[string.lower(getDataFromSave("UntitledVsDavePortSettings", "lang"))]["play_score"])..tostring(score).." | "..tostring(translatedScore[string.lower(getDataFromSave("UntitledVsDavePortSettings", "lang"))]["play_miss"])..tostring(misses).." | "..tostring(translatedScore[string.lower(getDataFromSave("UntitledVsDavePortSettings", "lang"))]["play_accuracy"])..tostring(math.floor(getProperty('ratingPercent') * 100, 2)).."%")
	setProperty("iconP1.scale.x", getProperty("iconP12.scale.x"))
	setProperty("iconP1.scale.y", getProperty("iconP12.scale.y"))
	setProperty("iconP2.scale.x", getProperty("iconP22.scale.x"))
	setProperty("iconP2.scale.y", getProperty("iconP22.scale.y"))
	setProperty("iconP1.x", getProperty("iconP12.x"))
	setProperty("iconP2.x", getProperty("iconP22.x"))
	updateHitbox('iconP1')
	updateHitbox('iconP2')
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
	runHaxeCode([[
		game.scoreTxtTween.cancel();
		game.scoreTxt.scale.x = 1;
		game.scoreTxt.scale.y = 1;
	]])
end

local inFiveNights = false;
local introSoundPath = {"default", ""}  --default, pixel, dave, bambi, ex, endfile name

function onCountdownTick(swagCounter)
	if string.lower(songName) == 'house' or string.lower(songName) == 'insanity' or string.lower(songName) == 'polygonized' or string.lower(songName) == 'bonus-song' or string.lower(songName) == 'interdimensional' or string.lower(songName) == 'five-nights' or string.lower(songName) == 'memory' or string.lower(songName) == 'vs-dave-rap' or string.lower(songName) == 'vs-dave-rap-two' then
		introSoundPath = {"dave", "_dave"}
	end
	if string.lower(songName) == 'blocked' or string.lower(songName) == 'cheating' or string.lower(songName) == 'corn-theft' or string.lower(songName) == 'glitch' or string.lower(songName) == 'maze' or string.lower(songName) == 'mealie' or string.lower(songName) == 'secret' or string.lower(songName) == 'shredder' or string.lower(songName) == 'supernovae' or string.lower(songName) == 'unfairness' then
		introSoundPath = {"bambi", "_bambi"}
	end
	if string.lower(songName) == "exploitation" then
		introSoundPath[1] = "ex";
	end
	if string.lower(songName) == "overdrive" then
		introSoundPath[1] = "dave";
	end
	if swagCounter == 0 then playSound("introSounds/"..introSoundPath[1].."/intro3"..introSoundPath[2], 1) end
	if swagCounter == 1 then playSound("introSounds/"..introSoundPath[1].."/intro2"..introSoundPath[2], 1) end
	if swagCounter == 2 then playSound("introSounds/"..introSoundPath[1].."/intro1"..introSoundPath[2], 1) end
	if swagCounter == 3 then playSound("introSounds/"..introSoundPath[1].."/introGo"..introSoundPath[2], 1) end
	if swagCounter == 4 then
		if getDataFromSave("UntitledVsDavePortSettings", "hasShapeNotes") == true then
			local warningThinmg = "shapeNoteWarning";
			if inFiveNights then warningThinmg = "doorWarning"; end
			makeLuaSprite("shapeNoteWarning", "ui/"..warningThinmg, 0, screenHeight * 2)
			setObjectCamera("shapeNoteWarning", 'hud')
			setProperty("shapeNoteWarning.antialiasing", false)
			setProperty("shapeNoteWarning.alpha", 0)
			addLuaSprite("shapeNoteWarning", false)
	
			doTweenAlpha("shapeNoteWarning1", "shapeNoteWarning", 1, 1 / playbackRate, "")
			doTweenY("shapeNoteWarning2", "shapeNoteWarning", 450, 1 / playbackRate, "backOut")
			runTimer("shapeNoteWarning", 3, 1)
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == "shapeNoteWarning" then
		doTweenAlpha("shapeNoteWarning11", "shapeNoteWarning", 0, 1 / playbackRate, "")
		doTweenY("shapeNoteWarning22", "shapeNoteWarning", screenHeight * 2, 1 / playbackRate, "backIn")
	end
end

function onTweenCompleted(tag)
	if tag == "shapeNoteWarning22" then
		removeLuaSprite("shapeNoteWarning", true)
	end
end

function onBeatHit()
	local funny = math.max(math.min(getProperty('health'),1.9),0.1)

	if not inFiveNights then
		runHaxeCode([[
		var funny = Math.max(Math.min(game.healthBar.value, 1.9), 0.1);
		game.getLuaObject("iconP12", false).setGraphicSize(Std.int(game.getLuaObject("iconP12", false).width + (50 * (funny + 0.1))),Std.int(game.getLuaObject("iconP12", false).height - (25 * funny)));
		game.getLuaObject("iconP22", false).setGraphicSize(Std.int(game.getLuaObject("iconP22", false).width + (50 * ((2 - funny) + 0.1))),Std.int(game.getLuaObject("iconP22", false).height - (25 * ((2 - funny) + 0.1))));
	]])
	else
		setGraphicSize('iconP22', math.floor(getProperty('iconP22.width') + (50 * funny)), math.floor(getProperty('iconP22.height') - (25 * funny)))
		setGraphicSize('iconP12', math.floor(getProperty('iconP12.width') + (50 * ((2 - funny) + 0.1))), math.floor(getProperty('iconP12.height') - (25 * ((2 - funny) + 1))))
	end
	
	local mult = 30;
	local multWHYY = 17.5;
	setProperty("iconP12.x", getProperty("iconP12.x") + (funny * mult))
	setProperty("iconP22.x", getProperty("iconP22.x") - (mult * (2 - funny) + 0.1))
	setProperty("iconP1.y", getProperty("iconP1.y") - (funny * multWHYY))
	setProperty("iconP2.y", getProperty("iconP2.y") - (multWHYY * (2 - funny) + 0.1))

	updateHitbox('iconP12')
	updateHitbox('iconP22')
	updateHitbox('iconP1')
	updateHitbox('iconP2')
end