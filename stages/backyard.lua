local skyType = 'sky';
local assetType = '';

function onCreate()
	makeLuaSprite('festivalSky', 'backgrounds/shared/sky_festival', -600, -400);
	setScrollFactor("festivalSky", 0.6, 0.6)
	addLuaSprite("festivalSky", false)
	
	if string.lower(songName) == "rano" then
		makeLuaSprite('sunriseBG', "backgrounds/shared/sky_sunrise", -600, -400);
		setProperty("sunriseBG.alpha", 0)
		setScrollFactor("sunriseBG", 0.6, 0.6)
		addLuaSprite("sunriseBG", false)

		makeLuaSprite('skyBG', "backgrounds/shared/sky", -600, -400);
		setProperty("skyBG.alpha", 0)
		setScrollFactor("skyBG", 0.6, 0.6)
		addLuaSprite("skyBG", false)
	end

	makeLuaSprite('hills', 'backgrounds/backyard/hills', -1330, -432);
	setScrollFactor("hills", 0.75, 0.75)
	addLuaSprite("hills", false)
	
	makeLuaSprite('grass', 'backgrounds/backyard/supergrass', -800, 150);
	setScrollFactor("grass", 1, 1)
	addLuaSprite("grass", false)

	makeLuaSprite('gates', 'backgrounds/backyard/gates', 564, -33);
	setScrollFactor("gates", 1, 1)
	addLuaSprite("gates", false)

	makeLuaSprite('bear', "backgrounds/backyard/bearDude", -1035, -710);
	setScrollFactor("bear", 0.95, 0.95)
	addLuaSprite("bear", false)

	makeLuaSprite('house', "backgrounds/backyard/house", -1025, -323);
	setScrollFactor("house", 0.95, 0.95)
	addLuaSprite("house", false)
	
	makeLuaSprite('grill', "backgrounds/backyard/grill", -489, 452);
	setScrollFactor("grill", 0.95, 0.95)
	addLuaSprite("grill", false)

	setDataFromSave("UntitledVsDavePortSettings", "stageName", "backyard")
	setDataFromSave("UntitledVsDavePortSettings", "backgroundSprites", {"festivalSky", "sunriseBG", "skyBG", "hills", "grass", "gates", "bear", "house", "grill"});
	callOnLuas("setBackgroundColor", {true})
end

local elapsedTime = 0.0;
function onUpdate(elapsed)
	elapsedTime = elapsedTime + elapsed;
	if string.lower(songName) == 'insanity' then
		setShaderFloat('bg2', 'uTime', elapsedTime)
	end
end