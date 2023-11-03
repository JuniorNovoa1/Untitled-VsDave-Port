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
	doTweenAlpha("timeBarDave", "timeBarDave", 1, 0.5, "circOut")
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

function onBeatHit()
	local funny = math.max(math.min(getProperty('health'),1.9),0.1)

	--[[if not inFiveNights then
		setGraphicSize('iconP12', math.floor(getProperty('iconP12.width') + (50 * (funny + 0.1))), -math.floor(getProperty('iconP12.height') - (25 * funny)))
		setGraphicSize('iconP22', math.floor(getProperty('iconP22.width') + (50 * ((2 - funny) + 0.1))), -math.floor(getProperty('iconP22.height') - (25 * ((2 - funny) + 1))))
	else
		setGraphicSize('iconP22', math.floor(getProperty('iconP22.width') + (50 * funny)), math.floor(getProperty('iconP22.height') - (25 * funny)))
		setGraphicSize('iconP12', math.floor(getProperty('iconP12.width') + (50 * ((2 - funny) + 0.1))), math.floor(getProperty('iconP12.height') - (25 * ((2 - funny) + 1))))
	end--]]

	runHaxeCode([[
		var funny = Math.max(Math.min(game.healthBar.value, 1.9), 0.1);
		game.getLuaObject("iconP12", false).setGraphicSize(Std.int(game.getLuaObject("iconP12", false).width + (50 * (funny + 0.1))),Std.int(game.getLuaObject("iconP12", false).height - (25 * funny)));
		game.getLuaObject("iconP22", false).setGraphicSize(Std.int(game.getLuaObject("iconP22", false).width + (50 * ((2 - funny) + 0.1))),Std.int(game.getLuaObject("iconP22", false).height - (25 * ((2 - funny) + 0.1))));
	]])
	local mult = 30;
	setProperty("iconP12.x", getProperty("iconP12.x") + (funny * mult))
	setProperty("iconP22.x", getProperty("iconP22.x") - (mult * (2 - funny) + 0.1))
	setProperty("iconP1.y", getProperty("iconP1.y") - (funny * mult))
	setProperty("iconP2.y", getProperty("iconP2.y") - (mult * (2 - funny) + 0.1))

	updateHitbox('iconP12')
	updateHitbox('iconP22')
	updateHitbox('iconP1')
	updateHitbox('iconP2')
end