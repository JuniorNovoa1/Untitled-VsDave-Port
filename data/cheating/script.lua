local elapsedtime = 0.0;
function onUpdate(elapsed)
	elapsedtime = elapsedtime + elapsed;
	for i = 0, getProperty("playerStrums.length") do
		if i % 2 == 0 then 
			setPropertyFromGroup("playerStrums", i, "x", getPropertyFromGroup("playerStrums", i, "x") + ((math.sin(elapsedtime) * 1))) 
		else
			setPropertyFromGroup("playerStrums", i, "x", getPropertyFromGroup("playerStrums", i, "x") + ((math.sin(elapsedtime) * -1)))
		end
		setPropertyFromGroup("playerStrums", i, "x", getPropertyFromGroup("playerStrums", i, "x") - ((math.sin(elapsedtime) * 1.5)))
	end
end
function onUpdatePost(elapsed)
	if keyboardJustPressed("SEVEN") then
        loadSong("Unfairness")
		if string.match(getTextFromFile(currentModDirectory.."/weeks/EverySongExpunged.json"), "unfairness") then return; end
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
		if i % 2 == 0 then 
			setPropertyFromGroup("opponentStrums", i, "x", getPropertyFromGroup("opponentStrums", i, "x") - ((math.sin(elapsedtime) * 1))) 
		else
			setPropertyFromGroup("opponentStrums", i, "x", getPropertyFromGroup("opponentStrums", i, "x") - ((math.sin(elapsedtime) * -1)))
		end
		setPropertyFromGroup("opponentStrums", i, "x", getPropertyFromGroup("opponentStrums", i, "x") + ((math.sin(elapsedtime) * 1.5)))
	end
end

function onStepHit()
	if curStep == 512 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
		makeLuaSprite("black", "", 0, 0)
		makeGraphic("black", screenWidth * 2, screenHeight * 2, '000000')
		setProperty("black.alpha", 0)
		screenCenter("black")
		addLuaSprite("black", true)
		doTweenAlpha("black", "black", 0.6, 1 / playbackRate, "")
		callOnLuas("makeInvisibleNotes", {true})
		callOnLuas("createDialogue", {"cheating_sub1", 0.02, 0.6})
	end
	if curStep == 537 then callOnLuas("createDialogue", {"cheating_sub2", 0.02, 0.6}) end
	if curStep == 552 then callOnLuas("createDialogue", {"cheating_sub3", 0.02, 0.6}) end
	if curStep == 570 then callOnLuas("createDialogue", {"cheating_sub4", 0.02, 1}) end
	if curStep == 595 then callOnLuas("createDialogue", {"cheating_sub5", 0.02, 0.6}) end
	if curStep == 607 then callOnLuas("createDialogue", {"cheating_sub6", 0.02, 0.6}) end
	if curStep == 619 then callOnLuas("createDialogue", {"cheating_sub7", 0.02, 1}) end
	if curStep == 640 then callOnLuas("createDialogue", {"cheating_sub8", 0.02, 0.6}) end
	if curStep == 649 then callOnLuas("createDialogue", {"cheating_sub9", 0.02, 0.6}) end
	if curStep == 654 then callOnLuas("createDialogue", {"cheating_sub10", 0.02, 0.6}) end
	if curStep == 666 then callOnLuas("createDialogue", {"cheating_sub11", 0.02, 0.6}) end
	if curStep == 675 then callOnLuas("createDialogue", {"cheating_sub12", 0.02, 0.6}) end
	if curStep == 685 then callOnLuas("createDialogue", {"cheating_sub13", 0.02, 0.6}) end
	if curStep == 695 then callOnLuas("createDialogue", {"cheating_sub14", 0.02, 0.6}) end
	if curStep == 712 then callOnLuas("createDialogue", {"cheating_sub15", 0.02, 0.6}) end
	if curStep == 715 then callOnLuas("createDialogue", {"cheating_sub16", 0.02, 0.6}) end
	if curStep == 722 then callOnLuas("createDialogue", {"cheating_sub17", 0.02, 0.6}) end
	if curStep == 745 then callOnLuas("createDialogue", {"cheating_sub18", 0.02, 0.3}) end
	if curStep == 749 then callOnLuas("createDialogue", {"cheating_sub19", 0.02, 0.3}) end
	if curStep == 756 then callOnLuas("createDialogue", {"cheating_sub20", 0.02, 0.6}) end
	if curStep == 768 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.2)
		doTweenAlpha("black", "black", 0, 1 / playbackRate, "")
		callOnLuas("makeInvisibleNotes", {false})
	end
	if curStep == 1280 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") + 0.2)
		doTweenAlpha("black", "black", 0.6, 1 / playbackRate, "")
	end
	if curStep == 1301 then callOnLuas("createDialogue", {"cheating_sub21", 0.02, 0.6}) end
	if curStep == 1316 then callOnLuas("createDialogue", {"cheating_sub22", 0.02, 0.6}) end
	if curStep == 1344 then callOnLuas("createDialogue", {"cheating_sub23", 0.02, 0.6}) end
	if curStep == 1374 then callOnLuas("createDialogue", {"cheating_sub24", 0.02, 1}) end
	if curStep == 1394 then callOnLuas("createDialogue", {"cheating_sub25", 0.02, 0.5}) end
	if curStep == 1403 then callOnLuas("createDialogue", {"cheating_sub26", 0.02, 1}) end
	if curStep == 1429 then callOnLuas("createDialogue", {"cheating_sub27", 0.02, 0.6}) end
	if curStep == 1475 then callOnLuas("createDialogue", {"cheating_sub28", 0.02, 1.5}) end
	if curStep == 1504 then callOnLuas("createDialogue", {"cheating_sub29", 0.02, 1}) end
	if curStep == 1528 then callOnLuas("createDialogue", {"cheating_sub30", 0.02, 0.6}) end
	if curStep == 768 then
		setProperty("defaultCamZoom", getProperty("defaultCamZoom") - 0.2)
		doTweenAlpha("black", "black", 0, 1 / playbackRate, "")
	end
end