local dialogue = {};

function onCreate()
	addHaxeLibrary('FlxTimer', 'flixel.util')
	addHaxeLibrary('FlxTween', 'flixel.tweens')
	addHaxeLibrary("StringTools")
	addHaxeLibrary("FunkinLua")
end

function getLanguageText(stringName, getFromLanguageManager)
	if getFromLanguageManager == false then return stringName; end
	local lang = getDataFromSave("UntitledVsDavePortSettings", "lang");
	dialogue = getDataFromSave("UntitledVsDavePortSettings", "textInLanguages")
	if lang == nil then lang = "en-US" end
	if dialogue[string.lower(lang)][stringName] ~= nil then return dialogue[string.lower(lang)][stringName]; end
	return "nil";
end

function createDialogue(textString, typeSpeed, startTime, textSize, getFromLanguageManager)
	local textValue = ""..textString;
	local getFromLanguageMan = getFromLanguageManager;
	if getFromLanguageMan == nil then getFromLanguageMan = true; end
	textValue = getLanguageText(textString, getFromLanguageMan)

	if typeSpeed == nil then typeSpeed = 0.02; end
	if startTime == nil then startTime = 1; end
	if textSize == nil then textSize = 36; end

	runHaxeCode([[
		var dialogueTxt = new ModchartText(400, 55, "", 0);
		game.add(dialogueTxt);
		game.modchartTexts.set("dialogueTxt", dialogueTxt)
	]])
	--makeLuaText("dialogueTxt", "", 36, 400, 55)
	setTextFont("dialogueTxt", "comic.ttf")
	setProperty("dialogueTxt.y", (screenHeight / 2) - 200)
	setTextColor('dialogueTxt', 'FFFFFF')
	setTextSize("dialogueTxt", textSize)
	setTextBorder("dialogueTxt", 2, "000000")
	setProperty("dialogueTxt.antialiasing", true)
	runHaxeCode([[
		var txt = game.modchartTexts.get('dialogueTxt');
		game.modchartTexts.set("dialogueTxt", null);
		var textToAdd = "]]..textValue..[[";
		var maxTxt = ]]..#textValue..[[;
		var timeForEach = ]]..typeSpeed..[[;
		var showTime = ]]..startTime..[[;
		txt.alpha = 0.99999;

		for (i in 0...maxTxt) {
			new FlxTimer().start(timeForEach * i, function(tmr) {
				//if (i == 0) FlxTween.tween(txt, {alpha: 1}, 0.5);
				txt.text += textToAdd.charAt(i);
				txt.updateHitbox();
				txt.screenCenter();
				txt.y = (FlxG.height / 2) - 200;
			});
		
			new FlxTimer().start(showTime, function(tmr) {
				FlxTween.tween(txt, {alpha: 0}, 0.5, {onComplete: function(twn)
					{
						txt.destroy();
					}
				});
			});
		}
	]])
end