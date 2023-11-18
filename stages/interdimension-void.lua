local char = {'ball', 'bimpe', 'maldo', 'memes kids', 'muko', 'ruby man', 'tristan', 'bambi'}
local direction = {}
local angleChangeAmount = {}
local posOffset = {}
local leftPosCheck = {}
local rightPosCheck = {}
local randomSpeed = {}
--flyingCharProps = {}

function onCreate()
	initLuaShader("glitchEffect")
	changeInterdimensionBg("")
	for i = 1, #char do
		makeLuaSprite(char[i], "backgrounds/festival/scaredCrowd/"..char[i])
		setScrollFactor(char[i], 1, 1)
		addLuaSprite(char[i], false)
		local directionsRandom = {"left", "right"};
		direction[i] = directionsRandom[getRandomInt(1, 2)];
		angleChangeAmount[i] = getRandomInt(100, 200);
		posOffset[i] = 800;
		leftPosCheck[i] = (-getProperty(char[i]..".width") * (1 / getProperty("defaultCamZoom"))) - posOffset[i];
		rightPosCheck[i] = (screenWidth * (1 / getProperty("defaultCamZoom"))) + getProperty(char[i]..".width") + posOffset[i];
		randomSpeed[i] = getRandomInt(1, 6);
	end
	setDataFromSave("UntitledVsDavePortSettings", "flyingBgChars", char)
end

function changeInterdimensionBg(BGtype)
	removeLuaSprite("interdimensionBG", true)
	if luaSpriteExists("nimbiLand") then removeLuaSprite('nimbiLand', true) end
	if luaSpriteExists("nimbiSign") then removeLuaSprite('nimbiSign', true) end
	makeLuaSprite("interdimensionBG", "backgrounds/void/interdimensions/interdimensionVoid", -600, -200)
	setGraphicSize("interdimensionBG", math.ceil(getProperty("interdimensionBG.width") * 1.75))
	if BGtype == 'interdimension-void' then
		makeLuaSprite("interdimensionBG", "backgrounds/void/interdimensions/interdimensionVoid", -600, -200)
		setGraphicSize("interdimensionBG", math.ceil(getProperty("interdimensionBG.width") * 1.75))
	end
	if BGtype == 'spike-void' then
		makeLuaSprite("interdimensionBG", "backgrounds/void/interdimensions/spike", -200, 0)
		setGraphicSize("interdimensionBG", math.ceil(getProperty("interdimensionBG.width") * 3))
	end
	if BGtype == 'darkSpace' then
		makeLuaSprite("interdimensionBG", "backgrounds/void/interdimensions/darkSpace", -200, 0)
		setGraphicSize("interdimensionBG", math.ceil(getProperty("interdimensionBG.width") * 2.75))
	end
	if BGtype == 'hexagon-void' then
		makeLuaSprite("interdimensionBG", "backgrounds/void/interdimensions/hexagon", -200, 0)
		setGraphicSize("interdimensionBG", math.ceil(getProperty("interdimensionBG.width") * 3))
	end
	if BGtype == 'nimbi-void' then
		makeLuaSprite("interdimensionBG", "backgrounds/void/interdimensions/nimbi/nimbiVoid", -200, 0)
		setGraphicSize("interdimensionBG", math.ceil(getProperty("interdimensionBG.width") * 3))
		setObjectOrder("interdimensionBG", getObjectOrder(char[1]) -1)

		makeLuaSprite("nimbiLand", "backgrounds/void/interdimensions/nimbi/nimbi_land", 200, 100)
		setGraphicSize("nimbiLand", math.ceil(getProperty("nimbiLand.width") * 1.5))
		setScrollFactor("nimbiLand", 1, 1)
		addLuaSprite("nimbiLand", false)
		setObjectOrder("nimbiLand", getObjectOrder(char[1]) -1)
		makeLuaSprite("nimbiSign", "backgrounds/void/interdimensions/nimbi/sign", 800, -73)
		setGraphicSize("nimbiSign", math.ceil(getProperty("nimbiLand.width") * 0.2))
		setScrollFactor("nimbiSign", 1, 1)
		addLuaSprite("nimbiSign", false)
		setObjectOrder("nimbiLand", getObjectOrder(char[1]) -1)
		setProperty("nimbiLand.x", getProperty("nimbiLand.x") - 100) --offset (100)
		setProperty("nimbiLand.y", getProperty("nimbiLand.y") - 235) --offset (150)
		setProperty("nimbiSign.x", getProperty("nimbiSign.x") - 100) --offset (100)
		setProperty("nimbiSign.y", getProperty("nimbiSign.y") - 235) --offset (150)
	end
	if BGtype ~= "nimbi-void" then setObjectOrder("interdimensionBG", getObjectOrder(char[1]) -1) end
	setProperty("interdimensionBG.x", getProperty("interdimensionBG.x") - 375) --offset (100)
	setProperty("interdimensionBG.y", getProperty("interdimensionBG.y") - 200) --offset (150)
	setScrollFactor("interdimensionBG", 1, 1)
	addLuaSprite("interdimensionBG")
	setSpriteShader("interdimensionBG", "glitchEffect")
	setShaderFloat('interdimensionBG', 'uWaveAmplitude', 0.1)
	setShaderFloat('interdimensionBG', 'uFrequency', 5)
	setShaderFloat('interdimensionBG', 'uSpeed', 2)
end

local elapsedTime = 0.0;
function onUpdate(elapsed)
	elapsedTime = elapsedTime + elapsed;
	setShaderFloat('interdimensionBG', 'uTime', elapsedTime)
	local speed = 300;
	for i = 1, #char do
		local moveDir = -1;
		if direction[i] == "right" then moveDir = 1; end
		setProperty(char[i]..".x", getProperty(char[i]..".x") + (speed * elapsed * moveDir * randomSpeed[i]))
		setProperty(char[i]..".y", getProperty(char[i]..".y") + (math.sin(elapsedTime) * 5))
		setProperty(char[i]..".angle", getProperty(char[i]..".angle") + (angleChangeAmount[i] * elapsed))

		if direction[i] == "left" then
			if getProperty(char[i]..".x") < leftPosCheck[i] then
				switchDirection(i)
			end
		elseif direction[i] == "right" then
			if getProperty(char[i]..".x") > rightPosCheck[i] then
				switchDirection(i)
			end
		end
	end
end

function switchDirection(charID)
	setProperty(char[charID]..".y", (screenHeight / 2) - getProperty(char[charID]..".height") / 2)
	angleChangeAmount[charID] = getRandomInt(100, 200)
	if direction[charID] == "left" then direction[charID] = "right" else direction[charID] = "left" end
end