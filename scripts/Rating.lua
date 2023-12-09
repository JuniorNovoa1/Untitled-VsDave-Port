local ratingFolder = 'ui/';

function onCreatePost()
    setProperty('showComboNum', false)
    setProperty("showRating", false)
    setProperty('showCombo', false)
    
    addHaxeLibrary("Std")
    addHaxeLibrary("FlxText", 'flixel.text')

    --Source Code stuff
    if stringStartsWith(version, '0.6') then
        addHaxeLibrary("Rating", 'Conductor')
        addHaxeLibrary("Note")
    else
        addHaxeLibrary("Rating", 'backend.Conductor')
        addHaxeLibrary("Note", 'objects')
    end

    --caching ratings!!
    for i = 0, getProperty('ratingsData.length') do
        precacheImage(ratingFolder..getPropertyFromGroup("ratingsData", i, 'image'))
        precacheImage(ratingFolder..'3d/'..getPropertyFromGroup("ratingsData", i, 'image'))
    end
    for i = 0, 9 do
        precacheImage(ratingFolder..'num'..i)
        precacheImage(ratingFolder..'3d/num'..i)
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if isSustainNote then
		return;
	end

    local ratingOffset = 0;
    if stringStartsWith(version, '0.7') then
	    ratingOffset = getPropertyFromClass("backend.ClientPrefs", "data.ratingOffset")
	else
        ratingOffset = getPropertyFromClass("ClientPrefs", "ratingOffset")
    end

    runHaxeCode([[
        var membersIndex = ]]..membersIndex..[[;
        var note = game.notes.members[membersIndex];
        var ratingFolder = "]]..ratingFolder..[[";
        var targetAlpha = 1;

        var texture = note.texture;
        //importing shit from lua!!!

        var noteDiff = note.strumTime - Conductor.songPosition + ]]..ratingOffset..[[;
		var daRating = Conductor.judgeNote(note, noteDiff / game.playbackRate);

        var pathFirst = "";
        var pathSecond = "";
        if (texture == 'notes/NOTE_assets_3D') {
            pathFirst = "3D/";
            pathSecond = "";
        }
        
        var daX = 0;
        var daY = 0;
        var autoPos = true;

        var coolText = new FlxText(daX, daY, 0, "", 32);
		if (autoPos)
		{
			coolText.screenCenter();
			coolText.x = FlxG.width * 0.55;
            //coolText.y += 150;
		}

        var rating = new FlxSprite(coolText.x - 40, coolText.y -60).loadGraphic(Paths.image(ratingFolder + pathFirst + daRating.image + pathSecond));
        rating.acceleration.y = 550;
        rating.velocity.y -= FlxG.random.int(140, 175);
        rating.velocity.x -= FlxG.random.int(0, 10);
		rating.alpha = targetAlpha;
        rating.setGraphicSize(Std.int(rating.width * 0.7), Std.int(rating.height * 0.7));
		game.add(rating);

        var comboSpr = new FlxSprite(coolText.x, coolText.y).loadGraphic(Paths.image(ratingFolder + pathFirst + 'combo' + pathSecond));
        comboSpr.acceleration.y = 600;
        comboSpr.velocity.y -= 150;
        comboSpr.velocity.x += FlxG.random.int(1, 10);
		comboSpr.alpha = targetAlpha;
        comboSpr.setGraphicSize(Std.int(comboSpr.width * 0.7), Std.int(comboSpr.height * 0.7));
        if (game.combo >= 10) {
            game.add(comboSpr);
        }
        FlxTween.tween(rating, {alpha: 0}, 0.2 / game.playbackRate, {
			startDelay: Conductor.crochet * 0.001 / game.playbackRate,
            onComplete: function(twn)
            {
                rating.destroy();
            }
		});
        FlxTween.tween(comboSpr, {alpha: 0}, 0.2 / game.playbackRate, {
			startDelay: Conductor.crochet * 0.001 / game.playbackRate,
            onComplete: function(twn)
            {
                comboSpr.destroy();
            }
		});

        var daLoop = 0;
        var seperatedScore = [];

        if (game.combo >= 1000)
            seperatedScore.push(]]..math.floor(getProperty("combo") / 1000)..[[ % 10);
        seperatedScore.push(]]..math.floor(getProperty("combo") / 100)..[[ % 10);
        seperatedScore.push(]]..math.floor(getProperty("combo") / 10)..[[ % 10);
        seperatedScore.push(game.combo % 10);

        for (i in seperatedScore) {
            var numScore = new FlxSprite(coolText.x, coolText.y + 80).loadGraphic(Paths.image(ratingFolder + pathFirst + 'num' + i + pathSecond));
            numScore.x += (43 * daLoop) - 90;
            numScore.acceleration.y = FlxG.random.int(200, 300);
            numScore.velocity.y -= FlxG.random.int(140, 160);
            numScore.velocity.x = FlxG.random.float(-5, 5);
            numScore.alpha = targetAlpha;
            numScore.setGraphicSize(Std.int(numScore.width * 0.5), Std.int(numScore.height * 0.5));
            if (game.combo >= 10 || game.combo == 0) {
                game.add(numScore);
            }
            FlxTween.tween(numScore, {alpha: 0}, 0.2 / game.playbackRate, {
                startDelay: Conductor.crochet * 0.002,
                onComplete: function(twn)
                {
                    numScore.destroy();
                }
            });
			daLoop++;
        }
    ]])
end