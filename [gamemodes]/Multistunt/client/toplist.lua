local Guivar = 0
local Fenster = {}
local Label = {}
local Bild

local times = {}
local names = {}
local stunt

addEvent("onToplistRefresh", true)

for i = 1, 10, 1 do
	times[i] = "-"
	names[i] = "-"
end
	
function createToplistGui()
	if(Guivar == 1) then return end
	Guivar = 1
	
	local strings = {}
	
	for i = 1, #times, 1 do
		if(times[i]) then
			if(times[i] == "-") then
				strings[i] = "-"
			else
				strings[i] = msToTimeStr(times[i])
			end
		end
	end

	Fenster[1] = guiCreateWindow(777,438,373,305,"Toplist for the Stunt "..stunt,false)
	Label[1] = guiCreateLabel(7,19,364,286,"1. "..names[1]..", Time: "..strings[1].."\n\n2. "..names[2]..", Time: "..strings[2].."\n\n3. "..names[3]..", Time: "..strings[3].."\n\n4. "..names[4]..", Time: "..strings[4].."\n\n5. "..names[5]..", Time: "..strings[5].."\n\n6. "..names[6]..", Time: "..strings[6].."\n\n7. "..names[7]..", Time: "..strings[7].."\n\n8. "..names[8]..", Time: "..strings[8].."\n\n9. "..names[9]..", Time: "..strings[9].."\n\n10. "..names[10]..", Time: "..strings[10],false,Fenster[1])
	guiLabelSetVerticalAlign(Label[1],"center")
	guiLabelSetHorizontalAlign(Label[1],"center",false)
	guiSetFont(Label[1],"default-bold-small")
	Bild = guiCreateStaticImage(95,85,179,134,"data/images/stuntfinish.png",false,Fenster[1])
	guiSetAlpha(Bild, 0.4)
	guiMoveToBack(Bild)
end
local function toggleToplist()
	if(isPedInVehicle(gMe) == false) then return end
	if(Guivar == 1) then
		destroyElement(Fenster[1])
		Guivar = 0
	else
		if not(stunt) then return end
		createToplistGui()
	end
end
bindKey("sub_mission", "down", toggleToplist)
bindKey("sub_mission", "up", toggleToplist)
addCommandHandler("toplist", toggleToplist)
addEventHandler("onToplistRefresh", getRootElement(), function(t1, t1name, t2, t2name, t3, t3name, t4, t4name, t5, t5name, t6, t6name, t7, t7name, t8, t8name, t9, t9name, t10, t10name, theStunt) -- Sinnlos, ich weiss, koennte man auch in ein String packen
	stunt = theStunt
	times[1] = t1
	times[2] = t2
	times[3] = t3
	times[4] = t4
	times[5] = t5
	times[6] = t6
	times[7] = t7
	times[8] = t8
	times[9] = t9
	times[10] = t10
	
	names[1] = t1name
	names[2] = t2name
	names[3] = t3name
	names[4] = t4name
	names[5] = t5name
	names[6] = t6name
	names[7] = t7name
	names[8] = t8name
	names[9] = t9name
	names[10] = t10name
end)




