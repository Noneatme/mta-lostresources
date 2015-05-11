-- Barrel Gamemode by MuLTi --


local Label
local gMe = getLocalPlayer()
local countdown = false
local timetimer
local timevar = 0
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), function()

	Label = guiCreateLabel(0.3859,0,0.2125,0.0593,"Zeit: 0 Sekunden",true)
	guiLabelSetVerticalAlign(Label,"center")
	guiLabelSetHorizontalAlign(Label,"center",false)
	triggerServerEvent("onMinutenZeitNeed", gMe)
	guiSetFont(Label, "default-bold-small")
end)

addEvent("onBarrelSpawn", true)
addEventHandler("onBarrelSpawn", getRootElement(),
function(time)
	if(countdown == true) then
		killTimer(timetimer)
	end
	countdown = true
	timevar = math.ceil((time/60/1000)*60)
	timetimer = setTimer(function() 
		if(timevar < 0) then guiSetText(Label, "Zeit: 0 Sekunden") return end
		timevar = timevar-1
		guiSetText(Label, "Zeit: "..timevar.." Sekunden")
	end, 1000, time/60)
end)

addEventHandler("onClientPlayerDamage", getLocalPlayer(),
function()
	if(getElementData(gMe, "done") ~= true) then
		triggerServerEvent("onBarrelVersage", gMe)
	end
end)