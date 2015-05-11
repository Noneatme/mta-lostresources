local gewonnen = false
local gestartet = false
local abgekackt = false
local theFont = dxCreateFont("data/fonts/digital.ttf", 18, true)

addEventHandler("onClientRender", getRootElement(), function()
	local sx, sy = guiGetScreenSize()
	if(gestartet == true) then
		dxDrawText ( "Stunt started!", sx/2, sy/2-sy/5, sx/2, sy/2, tocolor(0, 255, 255), 1, theFont, "center")
	elseif(abgekackt == true) then
		dxDrawText ( "Stunt failed!", sx/2, sy/2-sy/5, sx/2, sy/2, tocolor(255, 0, 0), 1, theFont, "center")
	elseif(gewonnen == true) then
		dxDrawText ( "Stunt sucessfull!", sx/2, sy/2-sy/5, sx/2, sy/2, tocolor(0, 200, 0), 1, theFont, "center")
	end
end)
addEvent("onMultistuntStuntFinish", true)
addEventHandler("onMultistuntStuntFinish", getRootElement(), function()
	playSound("sounds/finish.mp3", false)
	gewonnen = true
	setTimer(function() gewonnen = false end, 2500, 1)
end)

addEvent("onMultistuntStuntFail", true)
addEventHandler("onMultistuntStuntFail", getRootElement(), function()
	playSound("sounds/fail.mp3", false)
	abgekackt = true
	setTimer(function() abgekackt = false end, 2500, 1)
end)

addEvent("onMultistuntStuntStart", true)
addEventHandler("onMultistuntStuntStart", getRootElement(), function()
	playSound("sounds/start.mp3", false)
	gestartet = true
	setTimer(function() gestartet = false end, 2000, 1)
end)


function msToTimeStr(ms)
	if not ms then
		return ''
	end
	local centiseconds = tostring(math.floor(math.fmod(ms, 1000)/10))
	if #centiseconds == 1 then
		centiseconds = '0' .. centiseconds
	end
	local s = math.floor(ms / 1000)
	local seconds = tostring(math.fmod(s, 60))
	if #seconds == 1 then
		seconds = '0' .. seconds
	end
	local minutes = tostring(math.floor(s / 60))
	return minutes .. ':' .. seconds .. ':' .. centiseconds
end