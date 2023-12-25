function onUpdatePost(elapsed)
	if stringStartsWith(version, '0.6') then
		runHaxeCode([[
			for (integer in game.modchartSprites.keys()) {
				game.modchartSprites[integer].antialiasing = ClientPrefs.globalAntialiasing;
			}
		]])
    else
		runHaxeCode([[
			for (integer in game.modchartSprites.keys()) {
				game.modchartSprites[integer].antialiasing = backend.ClientPrefs.data.antialiasing;
			}
		]])
    end
end