function makeInvisibleNotes(invis)
	if invis then
		for i = 0, getProperty("strumLineNotes.length") do
			cancelTween("note"..i)
			noteTweenAlpha("note"..i, i, 0, 1, "")
		end
	else
		for i = 0, getProperty("strumLineNotes.length") do
			cancelTween("note"..i)
			noteTweenAlpha("note"..i, i, 1, 1, "")
		end
	end
end