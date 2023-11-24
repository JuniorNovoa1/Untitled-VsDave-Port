function onCreate() --sick ahh code
    if checkFileExists(currentModDirectory.."/.git") then return; end --got sick of this shit deleting on my end
    if not checkFileExists(currentModDirectory.."/weeks/questionmarkweek.json") then return; end
    deleteFile(currentModDirectory.."/weeks/questionmarkweek.json")
    saveFile(currentModDirectory.."/weeks/EverySongJokeBambi.json", 
    [[{
        "songs": [
        [
            "supernovae",
            "bambi-joke",
            [
                12,
                181,
                0
            ]
        ],
        [
            "glitch",
            "bambi-joke",
            [
                12,
                181,
                0
            ]
        ],
        [
            "master",
            "bambi-joke-mad",
            [
                12,
                181,
                0
            ]
        ]
        ],
        "hideFreeplay": false,
        "weekBackground": "house",
        "weekCharacters": [
            "bambiJoke",
            "bf",
            "gf"
        ],
        "storyName": "Bambi's Master Week!",
        "weekName": "Bambi's Master Week!",
        "difficulties": "normal",
        "freeplayColor": [
            146,
            113,
            253
        ],
        "hideStoryMode": false,
        "weekBefore": "???",
        "startUnlocked": true
    }]], false)
end

function onStepHit()
    if curStep == 60 then
		playAnim("dad", "hey", true)
	end
    if curStep == 64 then
		setProperty("defaultCamZoom", 1)
	end
    if curStep == 192 then
		setProperty("defaultCamZoom", 0.9)
	end
    if curStep == 320 or curStep == 768 then
		setProperty("defaultCamZoom", 1.1)
	end
    if curStep == 444 then
		setProperty("defaultCamZoom", 0.6)
	end
	if curStep == 448 or curStep == 960 or curStep == 1344 then
		setProperty("defaultCamZoom", 0.8)
	end
    if curStep == 896 or curStep == 1152 then
		setProperty("defaultCamZoom", 1.2)
	end
    if curStep == 1024 then
		setProperty("defaultCamZoom", 1)
        doTweenX("dadLinearX", "dad", 25, 15 / playbackRate, "")
		doTweenY("dadLinearY", "dad", 50, 15 / playbackRate, "")
        --eyesores
	end
    if curStep == 1280 then
		setProperty("defaultCamZoom", 1)
        doTweenX("dadLinearX", "dad", 50, 0.6 / playbackRate, "")
		doTweenY("dadLinearY", "dad", 280, 0.6 / playbackRate, "")
        --eyesores off
	end
end

function onUpdatePost(elapsed) 
    if keyboardJustPressed("SEVEN") then 
        loadSong("Cheating")
        if checkFileExists(currentModDirectory.."/weeks/EverySongExpunged.json") then return; end
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
end