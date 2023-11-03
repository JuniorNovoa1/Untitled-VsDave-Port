local skyType = 'sky';
local assetType = '';

function onCreate()
	--[[var variantColor = getBackgroundColor(stageName);
	if (stageName != 'daveHouse_night')
	{
		stageHills.color = variantColor;
		grassbg.color = variantColor;
		gate.color = variantColor;
		stageFront.color = variantColor;
	}--]]

	makeLuaSprite('bg', 'backgrounds/shared/'..skyType, -600, -300);
	setScrollFactor("bg", 0.6, 0.6)
	addLuaSprite("bg", false)

	makeLuaSprite('stageHills', 'backgrounds/dave-house/'..assetType.."hills", -834, -159);
	setScrollFactor("stageHills", 0.7, 0.7)
	addLuaSprite("stageHills", false)
	
	makeLuaSprite('grassbg', 'backgrounds/dave-house/'..assetType.."grass bg", -832, 505);
	setScrollFactor("grassbg", 0.7, 0.7)
	addLuaSprite("grassbg", false)

	makeLuaSprite('gate', 'backgrounds/dave-house/'..assetType.."gate", -755, 250);
	addLuaSprite("gate", false)

	makeLuaSprite('stageFront', 'backgrounds/dave-house/'..assetType.."grass", -832, 505);
	addLuaSprite("stageFront", false)

	if string.lower(songName) == 'insanity' then
		initLuaShader("glitchEffect")
		makeLuaSprite("blackBG", "", -600, -200)
		makeGraphic("blackBG", 2564, 2564, '000000')
		setProperty("blackBG.visible", false)
		addLuaSprite("blackBG", false)

		makeLuaSprite('bg2', 'backgrounds/void/redsky_insanity', -600, -200);
		setScrollFactor("bg2", 1, 1)
		setProperty("bg2.visible", false)
		setProperty("bg2.alpha", 0.7)
		addLuaSprite("bg2", false)
		setSpriteShader("bg2", "glitchEffect")
		setShaderFloat('bg2', 'uWaveAmplitude', 0.1)
		setShaderFloat('bg2', 'uFrequency', 5)
		setShaderFloat('bg2', 'uSpeed', 2)
	end
end

local elapsedTime = 0.0;
function onUpdate(elapsed)
	elapsedTime = elapsedTime + elapsed;
	if string.lower(songName) == 'insanity' then
		setShaderFloat('bg2', 'uTime', elapsedTime)
	end
end