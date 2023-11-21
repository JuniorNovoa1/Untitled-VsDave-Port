function onCreate()
    local skyType = "sky"
    --'sky_night' : stageName == 'bambiFarmSunset' ? 'sky_sunset'
    if string.lower(songName) == "indignancy" or string.lower(songName) == "splitathon" or string.lower(songName) == "mealie" or string.lower(songName) == "shredder" then
        setDataFromSave("UntitledVsDavePortSettings", "stageName", "bambifarmnight")
        skyType = "sky_night";
    end

    makeLuaSprite('sky', 'backgrounds/shared/'..skyType, -600, -200)
    setScrollFactor('sky', 0.6, 0.6)
    updateHitbox('sky')
    addLuaSprite('sky', false)

    if string.lower(songName) == "maze" then
        makeLuaSprite('sunsetBG', 'backgrounds/shared/sky_sunset', -600, -200)
        setScrollFactor('sunsetBG', 0.6, 0.6)
        setProperty('sunsetBG.alpha', 0)
        updateHitbox('sunsetBG')
        addLuaSprite('sunsetBG', false)
    
        makeLuaSprite('nightBG', 'backgrounds/shared/sky_night', -600, -200)
        setScrollFactor('nightBG', 0.6, 0.6)
        setProperty('nightBG.alpha', 0)
        addLuaSprite('nightBG', false)
    end

    makeLuaSprite('flatgrass', 'backgrounds/farm/gm_flatgrass', 350, 75)
    setGraphicSize('flatgrass', getProperty('flatgrass.width') * 0.34)
    setScrollFactor('flatgrass', 0.65, 0.65)
    if not lowQuality then
        addLuaSprite('flatgrass', false)
    end

    makeLuaSprite('hills', 'backgrounds/farm/orangey hills', -173, 100)
    setScrollFactor('hills', 0.65, 0.65)
    if not lowQuality then addLuaSprite('hills', false) end

    makeLuaSprite('farmHouse', 'backgrounds/farm/funfarmhouse', 350, 75)
    setGraphicSize('farmHouse', getProperty('farmHouse.width') * 0.9)
    setScrollFactor('farmHouse', 0.7, 0.7)
    if not lowQuality then addLuaSprite('farmHouse', false) end

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

    setDataFromSave("UntitledVsDavePortSettings", "backgroundSprites", {"sky", "sunsetBG", "nightBG", "flatgrass", "hills", "farmHouse", "grassLand", "cornFence", "cornFence2", "picnic", "cornBag", "sign"});
	callOnLuas("setBackgroundColor", {true})
end