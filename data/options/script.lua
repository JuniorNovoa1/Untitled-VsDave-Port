local options = {"Language", "Compatible mode", "Eyesores", "Screenshake", "Character Select", "Self Awareness", "Anti PsychEngine"}
local textOptionsArrayDefault = {};
local textOptionsArray = {};
local curSelectedOption = 1;
local curSelectedOptionUpDown = 1;

local selectAbleOptions = {--1. option name. 2. options
	["language"] = {"en-US", "es-US", "pt-br"},
	["compatible mode"] = {"true", "false"},
	["eyesores"] = {"true", "false"},
	["screenshake"] = {"true", "false"},
	["character select"] = {"true", "false"},
	["self awareness"] = {"true", "false"},
	["anti psychengine"] = {"true", "false"}
}
local optionDescriptions = {--1. option name. 2. options
	["language"] = "What language to be used in songs",
	["compatible mode"] = "If enabled, prevents crashes on some devices."
}

function onCreate()
	local textOptionsDefault = getTextFromFile("defaultOptions.txt", false)
	local textOptions = getTextFromFile("defaultOptions.txt", false)
	local curCharacters = "";
	local curCharacters2 = "";
	for i = 1, #textOptionsDefault do
		if textOptionsDefault:sub(i, i) == "," then
			curCharacters2 = string.gsub(curCharacters2, "", "")
			textOptionsArrayDefault[#textOptionsArrayDefault + 1] = curCharacters2;
			curCharacters2 = "";
		else
			local currentCharacertsy = textOptionsDefault:sub(i, i);
			curCharacters2 = curCharacters2..currentCharacertsy;
		end
	end
	if checkFileExists(currentModDirectory.."/options.txt", false) then
		textOptions = getTextFromFile("options.txt", false)
		for i = 1, #textOptions do
			if textOptions:sub(i, i) == "," then
				curCharacters = string.gsub(curCharacters, "", "")
				textOptionsArray[#textOptionsArray + 1] = curCharacters;
				curCharacters = "";
			else
				local currentCharacertsy = textOptions:sub(i, i);
				curCharacters = curCharacters..currentCharacertsy;
			end
		end
	end
	for i = 1, #textOptionsArrayDefault do
		if textOptionsArray[i] == nil then textOptionsArray[i] = textOptionsArrayDefault[i] end
	end

	setProperty("skipCountdown", true)
end

function onSongStart()
	setProperty("canPause", false)
	makeLuaSprite("background", "menuBG", 0, 0)
	--makeGraphic("background", 1280, 720, '000000')
	setObjectCamera("background", 'other')
	screenCenter("background", 'xy')
	addLuaSprite("background", false)

	makeLuaSprite("background2", "", 0, 0)
	makeGraphic("background2", (1280 - (1280 / 8)), (720 - (720 / 8)), '000000')
	setObjectCamera("background2", 'other')
	screenCenter("background2", 'xy')
	setProperty("background2.alpha", 0.7)
	addLuaSprite("background2", false)

	makeLuaText("optionsLabel", "Options", 0, getProperty("background2.x") + 8, getProperty("background2.y"))
	setObjectCamera("optionsLabel", 'other')
	setTextSize("optionsLabel", 38)
	setTextAlignment("optionsLabel", 'left')
	setTextFont("optionsLabel", "comic.ttf")
	addLuaText("optionsLabel")
	for i = 1, #textOptionsArray do
		createOptionBox(textOptionsArray[i], i)
	end

	--[[makeAnimatedLuaSprite("optionsSide", "optionsSide", 0, 0)
	addAnimationByPrefix("optionsSide", "idle", "idle", 6, true)
	setObjectCamera("optionsSide", 'other')
	screenCenter("optionsSide", 'xy')
	addLuaSprite("optionsSide", false)

	makeLuaText("optionsDescription", "This option enables fortnite in the fort in the the", 268, 1000, getProperty("optionsSide.y"))
	setObjectCamera("optionsDescription", 'other')
	setTextSize("optionsDescription", 28)
	setTextAlignment("optionsDescription", 'left')
	setTextFont("optionsDescription", "comic.ttf")
	addLuaText("optionsDescription")-]]

	--[[makeLuaSprite("optionDescriptionBorder", "", 0, 0)
	makeGraphic("optionDescriptionBorder", 928, 228, '000000')
	setObjectCamera("optionDescriptionBorder", 'other')
	screenCenter("optionDescriptionBorder", 'xy')
	setProperty("optionDescriptionBorder.alpha", 0.5)
	addLuaSprite("optionDescriptionBorder", false)

	makeLuaText("optionsDescription", "This option enables fortnite in the fort in the the", 0, 0, 0)
	setObjectCamera("optionsDescription", 'other')
	setTextSize("optionsDescription", 36)
	setTextAlignment("optionsDescription", 'center')
	setTextFont("optionsDescription", "comic.ttf")
	updateHitbox("optionsDescription")
	screenCenter("optionsDescription", 'xy')
	setProperty("optionsDescription.y", getProperty("optionsDescription.y") + 100)
	addLuaText("optionsDescription")

	makeGraphic("optionDescriptionBorder", getTextWidth("optionsDescription") + 28, getProperty("optionsDescription.height"), '000000')
	setProperty("optionDescriptionBorder.y", getProperty("optionsDescription.y"))
	screenCenter("optionDescriptionBorder", 'x')--]]

	for i = 1, #selectAbleOptions[string.lower(options[curSelectedOptionUpDown])] do
		if string.lower(selectAbleOptions[string.lower(options[curSelectedOptionUpDown])][i]) == string.lower(textOptionsArray[curSelectedOptionUpDown]) then curSelectedOption = i; end
	end

	--[[for i = 1, #options do
		--local defaltttSeti = " ("..getDefaultSetting(i)..")";
		local optionVariablesLength = #selectAbleOptions[string.lower(options[i])];
		selectAbleOptions[string.lower(options[i])][optionVariablesLength + 1] = "default";
	end--]]
end

function createOptionBox(val, i)
	makeLuaText("optionBox"..i.."txt", options[i]..": < "..val.." >", 0, getProperty("background2.x") + 8, getProperty("background2.y") + 22 + (32 * i))
	setObjectCamera("optionBox"..i.."txt", 'other')
	setTextSize("optionBox"..i.."txt", 26)
	setTextAlignment("optionBox"..i.."txt", 'left')
	setTextFont("optionBox"..i.."txt", "comic.ttf")
	addLuaText("optionBox"..i.."txt")
	--makeGraphic("optionBox"..i, getProperty("optionBox"..i..".width"), getProperty("optionBox"..i..".height"), '000000')
end

function saveShit()
	textOptionsArray[curSelectedOptionUpDown] = selectAbleOptions[string.lower(options[curSelectedOptionUpDown])][curSelectedOption];
	setTextString("optionBox"..curSelectedOptionUpDown.."txt", options[curSelectedOptionUpDown]..": < "..textOptionsArray[curSelectedOptionUpDown].." >")
	local fileToSave = "";
	for i = 1, #textOptionsArray do
		fileToSave = fileToSave..textOptionsArray[i]..",";
	end
	saveFile(currentModDirectory.."/options.txt", fileToSave, false)
end

local hasExit = false;

function onUpdatePost()
	for i = 1, #textOptionsArray do
		setProperty("optionBox"..i.."txt.alpha", 0.7)
		setProperty("optionBox"..curSelectedOptionUpDown.."txt.alpha", 1)
	end

	--[[if keyJustPressed('accept') then
		playSound("confirmMenu")
	end--]]
	if keyJustPressed('up') then
		curSelectedOption = 1;
		curSelectedOptionUpDown = curSelectedOptionUpDown -1;
		if curSelectedOptionUpDown == 0 then curSelectedOptionUpDown = #options end
		for i = 1, #selectAbleOptions[string.lower(options[curSelectedOptionUpDown])] do
			if string.lower(selectAbleOptions[string.lower(options[curSelectedOptionUpDown])][i]) == string.lower(textOptionsArray[curSelectedOptionUpDown]) then curSelectedOption = i; end
		end
		playSound("scrollMenu")
	end
	if keyJustPressed('down') then
		curSelectedOption = 1;
		curSelectedOptionUpDown = curSelectedOptionUpDown +1;
		if curSelectedOptionUpDown > #options then curSelectedOptionUpDown = 1; end
		for i = 1, #selectAbleOptions[string.lower(options[curSelectedOptionUpDown])] do
			if string.lower(selectAbleOptions[string.lower(options[curSelectedOptionUpDown])][i]) == string.lower(textOptionsArray[curSelectedOptionUpDown]) then curSelectedOption = i; end
		end
		playSound("scrollMenu")
	end
	if keyJustPressed('left') then
		curSelectedOption = curSelectedOption -1;
		if curSelectedOption == 0 then curSelectedOption = #selectAbleOptions[string.lower(options[curSelectedOptionUpDown])] end
		playSound("scrollMenu")
		saveShit()
	end
	if keyJustPressed('right') then
		curSelectedOption = curSelectedOption +1;
		if curSelectedOption > #selectAbleOptions[string.lower(options[curSelectedOptionUpDown])] then curSelectedOption = 1; end
		playSound("scrollMenu")
		saveShit()
	end
	if keyJustPressed('back') and not hasExit then runHaxeCode([[game.endSong();]]) playSound("cancelMenu") hasExit = true; end

	if luaSoundExists("breakfast") ~= true then playSound("breakfast", 0, "breakfast") soundFadeIn("breakfast", getRandomFloat(2, 4), 0, 1) end

	runHaxeCode([[
		FlxG.sound.music.pause();
		vocals.pause();
		FlxG.sound.music.volume = 0;
		vocals.volume = 0;
	]])
end