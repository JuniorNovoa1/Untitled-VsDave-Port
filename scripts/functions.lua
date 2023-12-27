local setCharacterColores = false;
function onCreatePost()
	addHaxeLibrary("Process", 'sys.io')
	addHaxeLibrary("File", 'sys.io')
	addHaxeLibrary("Bytes", 'haxe.io')
	addHaxeLibrary("Sys")
	precacheSound("macOSNotif")
	if setCharacterColores then
		setProperty("boyfriend.color", getColorFromHex(getBackgroundColor(getDataFromSave("UntitledVsDavePortSettings", "stageName"))))
		setProperty("dad.color", getColorFromHex(getBackgroundColor(getDataFromSave("UntitledVsDavePortSettings", "stageName"))))
		setProperty("gf.color", getColorFromHex(getBackgroundColor(getDataFromSave("UntitledVsDavePortSettings", "stageName"))))
	end
	--sendNotification()
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

function sendNotification(appName, title, description, soundEnabled, customSound) --scuffed ass code but it works
	createdScript = true;
	if appName == "" or appName == nil then appName = "Psych Engine"; end
	if title == "" or title == nil then title = "Title"; end
	if description == "" or description == nil then description = "Description"; end
	if soundEnabled == nil then soundEnabled = true; end
	if buildTarget == "windows" then --find less laggy solution
		makeLuaText("stupidtextthatsneeded", "", 0, 0.0, 0.0)
        runHaxeCode([[game.getLuaObject("stupidtextthatsneeded", true).text += Sys.getCwd();]])
        saveFile(getTextString("stupidtextthatsneeded").."mods/"..currentModDirectory.."/platform/windows/windowsNotif.ps1", [[
            [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

            $objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon

            $objNotifyIcon.Icon = [System.Drawing.SystemIcons]::Information
            $objNotifyIcon.BalloonTipIcon = "Info" 
            $objNotifyIcon.BalloonTipText = "]]..description..[[" 
            $objNotifyIcon.BalloonTipTitle = "]]..title..[["
            $objNotifyIcon.Visible = $True
            $objNotifyIcon.ShowBalloonTip(10000)
            [System.Environment]::Exit(0)
            Start-Sleep 500
        ]], true)
        runHaxeCode([[game.getLuaObject("stupidtextthatsneeded", true).text += "mods/" + "]]..currentModDirectory..[[" + "/platform/windows/windowsNotif.ps1";]])
        -- Execute the PowerShell script
        os.execute("powershell -ExecutionPolicy Bypass "..getTextString("stupidtextthatsneeded"))
	end
	if buildTarget == "mac" then
		if customSound == "" or customSound == nil then customSound = "macOSNotif"; end
		os.execute([[osascript -e 'display notification "]]..description..[[" with title "]]..appName..[[" subtitle "]]..title..[["']])
		if soundEnabled then playSound(customSound, 1) end
	end
	if buildTarget == "linux" then
		os.execute([[notify-send "]]..title..[[" "]]..description..[["]]) --pre installed in most linux devices
	end
end

function onDestroy()
	if createdScript then deleteFile(getTextString("stupidtextthatsneeded"), true) end
end