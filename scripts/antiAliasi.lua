function onCreate()
	addHaxeLibrary("FlxColor", 'flixel.util')
	codeing()
end

function onCreatePost()
	codeing()
end

function onUpdatePost(elapsed)
	codeingTwi()
end

function codeing()
	if stringStartsWith(version, '0.6') then
		runHaxeCode([[
			for (integer in game.modchartSprites.keys()) {
				game.modchartSprites[integer].antialiasing = ClientPrefs.globalAntialiasing;
				game.modchartSprites[integer].color = FlxColor.WHITE;
				game.callOnLuas("onObjectCount", [integer]);
			}
		]])
    else
		runHaxeCode([[
			for (integer in game.modchartSprites.keys()) {
				game.modchartSprites[integer].antialiasing = backend.ClientPrefs.data.antialiasing;
				game.callOnLuas("onObjectCount", [integer]);
			}
		]])
    end
end

function codeingTwi()
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