local nightColor = '000000';--'FF878787';
local sunsetColor = 'D48ECD';
local spotLightScaler = 1.3;
local time = 70;
--to my future self its the --doTweenColor function that fucks up the colors

function onCreate()
    local skyType = "sky"
    --'sky_night' : stageName == 'bambiFarmSunset' ? 'sky_sunset'
    if string.lower(songName) == "indignancy" or string.lower(songName) == "splitathon" or string.lower(songName) == "mealie" or string.lower(songName) == "shredder" then
        setDataFromSave("UntitledVsDavePortSettings", "stageName", "bambifarmnight")
        skyType = "sky_night";
    end
    nightColor = getColorFromHex('0xFF878787');

    makeLuaSprite('SKY', 'backgrounds/shared/'..skyType, -600, -200)
    setScrollFactor('SKY', 0.6, 0.6)
    updateHitbox('SKY')
    if string.lower(songName) == 'maze' then
        doTweenAlpha('fart', 'SKY', 0, time)
    end
    addLuaSprite('SKY', false)

    makeLuaSprite('SUNSETBG', 'backgrounds/shared/sky_sunset', -600, -200)
    setScrollFactor('SUNSETBG', 0.6, 0.6)
    setProperty('SUNSETBG.alpha', 0)
    updateHitbox('SUNSETBG')
    if string.lower(songName) == 'maze' then
        doTweenAlpha('sunSetting', 'SUNSETBG', 1, time)
    end
    addLuaSprite('SUNSETBG', false)

    makeLuaSprite('NIGHTBG', 'backgrounds/shared/sky_night', -600, -200)
    setScrollFactor('NIGHTBG', 0.6, 0.6)
    setProperty('NIGHTBG.alpha', 0)
    addLuaSprite('NIGHTBG', false)

    makeLuaSprite('flatgrass', 'backgrounds/farm/gm_flatgrass', 350, 75)
    setGraphicSize('flatgrass', getProperty('flatgrass.width') * 0.34)
    setScrollFactor('flatgrass', 0.65, 0.65)
    if not lowQuality then
        addLuaSprite('flatgrass', false)
    end

    makeLuaSprite('hills', 'backgrounds/farm/orangey hills', -173, 100)
    setScrollFactor('hills', 0.65, 0.65)
    if not lowQuality then
        addLuaSprite('hills', false)
    end

    makeLuaSprite('farmHouse', 'backgrounds/farm/funfarmhouse', 350, 75)
    setGraphicSize('farmHouse', getProperty('farmHouse.width') * 0.9)
    setScrollFactor('farmHouse', 0.7, 0.7)
    addLuaSprite('farmHouse', false)

    makeLuaSprite('grassLand', 'backgrounds/farm/grass lands', -600, 500)
    addLuaSprite('grassLand', false)
    
    makeLuaSprite('cornFence', 'backgrounds/farm/cornFence', -400, 200)
    if not lowQuality then
        addLuaSprite('cornFence', false)
    end

    makeLuaSprite('cornFence2', 'backgrounds/farm/cornFence2', 1100, 200)
    if not lowQuality then
        addLuaSprite('cornFence2', false)
    end

    makeLuaSprite('picnic', 'backgrounds/farm/picnic_towel_thing', 1050, 650)
    if not lowQuality and string.lower(songName) == "splitathon" then
        addLuaSprite('picnic', false)
    end

    local daBag = 'backgrounds/farm/cornbag';
    local random = getRandomInt(0, 100);
    if random == 0 then
        daBag = 'backgrounds/farm/popeye';
    end
    makeLuaSprite('cornBag', daBag, 1200, 550)
    if not lowQuality then
        addLuaSprite('cornBag', false)
    end

    makeLuaSprite('sign', 'backgrounds/farm/sign', 0, 350)
    if not lowQuality then
        addLuaSprite('sign', false)
    end
    if string.lower(songName) == 'maze' then
        makeLuaSprite('magentaBGScreen', '', 0, 0)
        makeGraphic('magentaBGScreen', '1280', '720', sunsetColor)
        scaleObject('magentaBGScreen', 5, 5)
        screenCenter('magentaBGScreen', 'x')
        screenCenter('magentaBGScreen', 'y')
        setProperty('magentaBGScreen.alpha', 0)
        updateHitbox('magentaBGScreen')
        addLuaSprite('magentaBGScreen', true)
    
        makeLuaSprite('blackBGScreen', '', 0, 0)
        makeGraphic('blackBGScreen', '1280', '720', nightColor)
        scaleObject('blackBGScreen', 5, 5)
        screenCenter('blackBGScreen', 'x')
        screenCenter('blackBGScreen', 'y')
        setProperty('blackBGScreen.alpha', 0)
        updateHitbox('blackBGScreen')
        addLuaSprite('blackBGScreen', true)
    end

    setDataFromSave("UntitledVsDavePortSettings", "backgroundSprites", {"SKY", "flatgrass", "hills", "farmHouse", "grassLand", "cornFence", "cornFence2", "picnic", "cornBag", "sign"});
	callOnLuas("setBackgroundColor", {true})
end

local amount = 0.35;
function onUpdate()
    setProperty('magentaBGScreen.alpha', getProperty('SUNSETBG.alpha') -0.65)
    setProperty('blackBGScreen.alpha', getProperty('NIGHTBG.alpha') -amount)

    if getProperty('spotLight.alpha') == 1 then
        amount = 0.25;
    else
        amount = 0.5;
    end
end

function onTweenCompleted(tag)
	if tag == 'sunSetting' then
        doTweenAlpha('sunSettingDown', 'SUNSETBG', 0, time)
        doTweenAlpha('moonRising', 'NIGHTBG', 1, time)
	end
end

function rgbToHex(r, g, b) --https://github.com/ShadowMario/FNF-PsychEngine/issues/9907
    --%02x: 0 means replace " "s with "0"s, 2 is width, x means hex
	return string.format("%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b))
end

function sectionStartTime(section)
	local daPos = 0;
    for i = 0, section do
        daPos = daPos + 4 * (1000 * 60 / bpm);
    end
	return daPos;
end