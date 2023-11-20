function onCreatePost() --sick ahh code
    deleteFile(currentModDirectory.."/weeks/???.json", false)
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
            "bambi-joke",
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