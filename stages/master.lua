function onCreate()
	makeLuaSprite("space", "backgrounds/shared/sky_space", -1724, -971)
	setGraphicSize("space", math.floor(getProperty("space.width") * 10))
	setProperty("space.antialiasing", false)
	setScrollFactor("space", 1.2, 1.2)
	addLuaSprite("space", false)

	makeLuaSprite("land", 'backgrounds/dave-house/land', 675, 555)
	setScrollFactor("land", 0.9, 0.9)
	addLuaSprite("land", false)
end