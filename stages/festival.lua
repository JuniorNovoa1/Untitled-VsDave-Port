function onCreate()
	local isGreetingsCutscene = false;
	--[[precacheImage("festival/bambi_shredder")
	for asset in {'bambi_spot', 'boyfriend_spot', 'ch_highway'} do
		precacheImage('festival/shredder/'..asset);
	end--]]

	mainChars = {};
	if string.lower(songName) == 'shredder' then
		mainChars = {
			{'dave', 'idle', 0.8, 175, 100},
			{'tristan', 'bop', 0.4, 800, 325}
		};
	end
	if string.lower(songName) == 'greetings' then
		if isGreetingsCutscene then
			mainChars = {
				{'bambi', 'bambi idle', 0.9, 400, 350},
				{'tristan', 'bop', 0.4, 800, 325}
			};
		else
			mainChars = {
				{'dave', 'idle', 0.8, 175, 100},
				{'bambi', 'bambi idle', 0.9, 700, 350},
			};
		end
	end
	if string.lower(songName) == 'interdimensional' then
		mainChars = {
			{'bambi', 'bambi idle', 0.9, 400, 350},
			{'tristan', 'bop', 0.4, 800, 325}
		}
	end

	makeLuaSprite("bg", "backgrounds/shared/sky_festival", -600, -230)
	setScrollFactor("bg", 0.6, 0.6)
	addLuaSprite("bg", false)

	makeLuaSprite("flatGrass", "backgrounds/festival/gm_flatgrass", 800, -100)
	setScrollFactor("flatGrass", 0.7, 0.7)
	addLuaSprite("flatGrass", false)

	makeLuaSprite("farmHouse", "backgrounds/festival/farmHouse", -300, -150)
	setScrollFactor("farmHouse", 0.7, 0.7)
	addLuaSprite("farmHouse", false)

	makeLuaSprite("hills", "backgrounds/festival/hills", -1000, -100)
	setScrollFactor("hills", 0.7, 0.7)
	addLuaSprite("hills", false)

	makeAnimatedLuaSprite("corn", "backgrounds/festival/corn", -1000, 120)
	addAnimationByPrefix("corn", "corn", "idle", 5, true)
	setScrollFactor("corn", 0.85, 0.85, true)
	playAnim("corn", "corn")
	addLuaSprite("corn", false)

	makeAnimatedLuaSprite("cornGlow", "backgrounds/festival/cornGlow", -1000, 120)
	addAnimationByPrefix("cornGlow", "cornGlow", "idle", 5, true)
	setScrollFactor("cornGlow", 0.85, 0.85, true)
	setBlendMode("cornGlow", 'ADD')
	playAnim("cornGlow", "cornGlow")
	addLuaSprite("cornGlow", false)
	
	makeLuaSprite("backGrass", "backgrounds/festival/backGrass", -1000, 475)
	setScrollFactor("backGrass", 0.85, 0.85)
	addLuaSprite("backGrass", false)

	makeAnimatedLuaSprite("crowd", "backgrounds/festival/crowd", -500, -150)
	addAnimationByPrefix("crowd", "idle", "crowdDance", 24, true)
	setScrollFactor("crowd", 0.85, 0.85)
	playAnim("crowd", "idle")
	addLuaSprite("crowd", false)

	for i = 1, #mainChars do
		makeAnimatedLuaSprite(mainChars[i][1], "backgrounds/festival/mainCrowd/"..mainChars[i][1], mainChars[i][4], mainChars[i][5])
		addAnimationByPrefix(mainChars[i][1], "idle", mainChars[i][2], 24, true)
		setScrollFactor(mainChars[i][1], 0.85, 0.85, true)
		setGraphicSize(mainChars[i][1], math.floor(getProperty(mainChars[i][1]..".width") * mainChars[i][3]))
		updateHitbox(mainChars[i][1])
		playAnim(mainChars[i][1], "idle")
		addLuaSprite(mainChars[i][1], false)
	end
	
	makeLuaSprite("frontGrass", "backgrounds/festival/frontGrass", -1300, 600)
	setScrollFactor("frontGrass", 1, 1)
	addLuaSprite("frontGrass", false)

	makeAnimatedLuaSprite("stageGlow", "backgrounds/festival/generalGlow", -450, 300)
	addAnimationByPrefix("stageGlow", "glow", "idle", 5, true)
	setScrollFactor("stageGlow", 0, 0)
	setBlendMode("stageGlow", 'ADD')
	playAnim("stageGlow", "glow")
	addLuaSprite("stageGlow", false)
end