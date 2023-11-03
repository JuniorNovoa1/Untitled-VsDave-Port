local dialogue = {};

function onCreate()
	addHaxeLibrary('FlxTimer', 'flixel.util')
	addHaxeLibrary("FlxText", "flixel.text")
	addHaxeLibrary('FlxTween', 'flixel.tweens')
	addHaxeLibrary("StringTools")
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
		var dialogueTxt = new FlxText(400, 55, 0, "", 36);
		dialogueTxt.camera = game.camHUD;
		game.add(dialogueTxt);
		game.modchartTexts.set("dialogueTxt", dialogueTxt)
	]])
	setTextFont("dialogueTxt", "comic.ttf")
	setProperty("dialogueTxt.y", (screenHeight / 2) - 200)

	setTextColor('dialogueTxt', 'FFFFFF')
	setTextSize("dialogueTxt", textSize)
	setTextBorder("dialogueTxt", textSize / 2, "000000")
	--setProperty("dialogueTxt.alpha", 0)

	--local timeForEach = (""..value2[1]):match("%d+%.?%d*");
	--local showTime = (""..value2[2]):match("%d+%.?%d*");
	--"]]..textValue:sub(iTEXT, iTEXT)..[["
	runHaxeCode([[
		var txt = game.modchartTexts.get('dialogueTxt');
		game.modchartTexts.set("dialogueTxt", null);
		var textToAdd = "]]..textValue..[[";
		var maxTxt = ]]..#textValue..[[;
		var timeForEach = ]]..typeSpeed..[[;
		var showTime = ]]..startTime..[[;

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