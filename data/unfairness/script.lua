local oldGhostTappingSetting = false;
function onCreate()
	if stringStartsWith(version, "0.7") then oldGhostTappingSetting = getPropertyFromClass("backend.ClientPrefs", "data.ghostTapping") else oldGhostTappingSetting = getPropertyFromClass("ClientPrefs", "ghostTapping") end
	if stringStartsWith(version, "0.7") then setPropertyFromClass("backend.ClientPrefs", "data.ghostTapping", false) else setPropertyFromClass("ClientPrefs", "ghostTapping", false) end
end

function onDestroy()
	if stringStartsWith(version, "0.7") then setPropertyFromClass("backend.ClientPrefs", "data.ghostTapping", oldGhostTappingSetting) else setPropertyFromClass("ClientPrefs", "ghostTapping", oldGhostTappingSetting) end
end

local elapsedtime = 0.0;
function onUpdate(elapsed)
	elapsedtime = elapsedtime + elapsed;
	for i = 0, getProperty("playerStrums.length") do
		setPropertyFromGroup("playerStrums", i, "x", ((screenWidth / 2) - (getPropertyFromGroup("playerStrums", i, "width") / 2)) + (math.sin((elapsedtime + (i))) * 300))
		setPropertyFromGroup("playerStrums", i, "y", ((screenHeight / 2) - (getPropertyFromGroup("playerStrums", i, "height") / 2)) + (math.cos((elapsedtime + (i))) * 300))
	end
end
function onUpdatePost(elapsed)
	if keyboardJustPressed("SEVEN") then
        loadSong("Exploitation")
        saveFile(currentModDirectory.."/weeks/EverySongExpunged.json", [[{
        "songs": [
        [
            "cheating",
            "bambi-3d",
            [
                13,
                151,
                21
			]
		],
		[
			"unfairness",
			"bambi-unfair",
			[
				178, 
				7, 
				7
			]
		],
		[
			"exploitation",
			"expunged",
			[
				82, 
				15, 
				15
			]
        ]
        ],
        "hideFreeplay": false,
        "weekBackground": "house",
        "weekCharacters": [
            "dave",
            "bf",
            "gf"
        ],
        "storyName": "Expunged",
        "weekName": "Expunged",
        "difficulties": "normal",
        "freeplayColor": [
            146,
            113,
            253
        ],
        "hideStoryMode": true,
        "weekBefore": "EverySongJokeBambi",
        "startUnlocked": true
        }]], false)
    end
	for i = 0, getProperty("opponentStrums.length") do
		setPropertyFromGroup("opponentStrums", i, "x", ((screenWidth / 2) - (getPropertyFromGroup("opponentStrums", i, "width") / 2)) + (math.sin((elapsedtime + (i)) * 2) * 300))
		setPropertyFromGroup("opponentStrums", i, "y", ((screenHeight / 2) - (getPropertyFromGroup("opponentStrums", i, "height") / 2)) + (math.cos((elapsedtime + (i)) * 2) * 300))
	end
end

function onStepHit()
	if curStep == 256 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
		makeLuaSprite("black", "", 0, 0)
		makeGraphic("black", screenWidth * 2, screenHeight * 2, '000000')
		setProperty("black.alpha", 0)
		screenCenter("black")
		addLuaSprite("black", true)
		doTweenAlpha("black", "black", 0.6, 1 / playbackRate, "")
		callOnLuas("makeInvisibleNotes", {true})
	end
	if curStep == 261 then callOnLuas("createDialogue", {"unfairness_sub1", 0.02, 0.6}) end
	if curStep == 284 then callOnLuas("createDialogue", {"unfairness_sub2", 0.02, 0.6}) end
	if curStep == 321 then callOnLuas("createDialogue", {"unfairness_sub3", 0.02, 0.6}) end
	if curStep == 353 then callOnLuas("createDialogue", {"unfairness_sub4", 0.02, 1.5}) end
	if curStep == 414 then callOnLuas("createDialogue", {"unfairness_sub5", 0.02, 0.6}) end
	if curStep == 439 then callOnLuas("createDialogue", {"unfairness_sub6", 0.02, 1}) end
	if curStep == 468 then callOnLuas("createDialogue", {"unfairness_sub7", 0.02, 1}) end
	if curStep == 512 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.2)
		doTweenAlpha("black", "black", 0, 1 / playbackRate, "")
		callOnLuas("makeInvisibleNotes", {false})
	end
	if curStep == 2560 then
		for i = 0, getProperty("opponentStrums.length") do
			noteTweenAlpha("strum"..i, i - 1, 0, 6 / playbackRate, "")
		end
	end
	if curStep == 2688 then
		for i = 0, getProperty("playerStrums.length") do
			noteTweenAlpha("strumP"..i, 4 + i, 0, 6 / playbackRate, "")
		end
	end
	if curStep == 3072 then
		cameraFlash("game", "FFFFFF", 1 / playbackRate)
		setProperty("dad.visible", false)
		setProperty("iconP2.visible", false)
	end
end