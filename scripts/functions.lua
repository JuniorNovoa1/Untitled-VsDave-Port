local setCharacterColores = false;
function onCreatePost()
	if setCharacterColores then
		setProperty("boyfriend.color", getColorFromHex(getBackgroundColor(getDataFromSave("UntitledVsDavePortSettings", "stageName"))))
		setProperty("dad.color", getColorFromHex(getBackgroundColor(getDataFromSave("UntitledVsDavePortSettings", "stageName"))))
		setProperty("gf.color", getColorFromHex(getBackgroundColor(getDataFromSave("UntitledVsDavePortSettings", "stageName"))))
	end
end

function makeInvisibleNotes(invis)
	if invis then
		for i = 0, 7 do
			cancelTween("note"..i)
			noteTweenAlpha("note"..i, i, 0, 1 / playbackRate, "")
		end
	else
		for i = 0, 7 do
			cancelTween("note"..i)
			noteTweenAlpha("note"..i, i, 1, 1 / playbackRate, "")
		end
	end
end

function setBackgroundColor(setCharacterColors)
	local backgrounds = getDataFromSave("UntitledVsDavePortSettings", "backgroundSprites");
	local stageNameder = getDataFromSave("UntitledVsDavePortSettings", "stageName")
	if stageNameder == "" then stageNameder = string.lower(curStage); end
	for i = 1, #backgrounds do
		setProperty(backgrounds[i]..".color", getColorFromHex(getBackgroundColor(stageNameder)))
	end
	setCharacterColores = setCharacterColors;
end

function getBackgroundColor(stage)
	local stageColor = "FFFFFF";
	stage = string.lower(stage)
	if stage == "bambifarmnight" or stage == "davehouse_night" or stage == "backyard" or stage == "bedroomnight" then stageColor = "0xFF878787" end
	if stage == "bambifarmsunset" or stage == "davehouse_sunset" then stageColor = "FF8FB2" end
	return stageColor;
end

function switchDad(newChar, positionX, positionY, reposition, updateColor)
	triggerEvent("Change Character", "dad", newChar)
	if positionX ~= 0 then positionX = positionX - getProperty("dad.positionArray[0]") setProperty("dad.x", positionX) end
	if positionY ~= 0 then positionY = positionY - getProperty("dad.positionArray[1]") setProperty("dad.y", positionY) end
end

local createdScript = false;

function sendNotification(title, description, soundEnabled) --scuffed ass code but it works
	addHaxeLibrary("Process", 'sys.io')
	addHaxeLibrary("File", 'sys.io')
	addHaxeLibrary("Bytes", 'haxe.io')
	addHaxeLibrary("Sys")
	createdScript = true;
	if title == "" or title == nil then title = "Title"; end
	if description == "" or description == nil then Title = "Description"; end
	if soundEnabled == nil then soundEnabled = true; end
	if buildTarget == "mac" then
		makeLuaText("stupidtextthatsneeded", "", 0, 0.0, 0.0)
		runHaxeCode([[game.getLuaObject("stupidtextthatsneeded", true).text += Sys.getCwd();]])
		saveFile(getTextString("stupidtextthatsneeded").."mods/"..currentModDirectory.."/macOSNotif.sh", [[osascript -e 'display notification "]]..description..[[" with title "]]..title..[["']], true)
		runHaxeCode([[
			game.getLuaObject("stupidtextthatsneeded", true).text += "mods/" + "]]..currentModDirectory..[[" + "/macOSNotif.sh";
			Sys.command("chmod +x " + game.getLuaObject("stupidtextthatsneeded", true).text);
			Sys.command(game.getLuaObject("stupidtextthatsneeded", true).text);
		]])
		if soundEnabled then playSound("macOSNotif", 1) end
	end
end

function onDestroy()
	if createdScript then deleteFile(getTextString("stupidtextthatsneeded"), true) end
end