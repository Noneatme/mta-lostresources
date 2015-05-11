local tresortuer = createObject(2634, 2144.1765136719, 1626.9592285156, 994.27239990234, 0, 0, 180)
local dim = 5
setElementInterior(tresortuer, 1)
setElementDimension(tresortuer, dim)

local doing = false

local barrels = {
	createObject(1222,2153.77124023,1623.12243652,994.38317871,0.00000000,0.00000000,0.00000000), --object(barrel3), (14),
	createObject(1222,2155.04418945,1618.16259766,995.15692139,0.00000000,0.00000000,0.00000000), --object(barrel3), (15),
	createObject(1222,2154.41943359,1617.46240234,995.15692139,0.00000000,0.00000000,0.00000000), --object(barrel3), (16),
	createObject(1222,2153.79736328,1618.64953613,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (17),
	createObject(1222,2151.76367188,1613.64257812,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (18),
	createObject(1222,2148.25390625,1608.07019043,995.40008545,0.00000000,0.00000000,0.00000000), --object(barrel3), (19),
	createObject(1222,2147.99389648,1609.18823242,995.40008545,0.00000000,0.00000000,0.00000000), --object(barrel3), (20),
	createObject(1222,2146.31274414,1609.05358887,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (21),
	createObject(1222,2147.87939453,1610.77575684,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (22),
	createObject(1222,2141.06420898,1625.57897949,995.29693604,0.00000000,0.00000000,0.00000000), --object(barrel3), (1),
	createObject(1222,2142.12011719,1624.64013672,995.29693604,0.00000000,0.00000000,0.00000000), --object(barrel3), (2),
	createObject(1222,2147.46215820,1624.57324219,995.29693604,0.00000000,0.00000000,0.00000000), --object(barrel3), (3),
	createObject(1222,2148.91308594,1623.70141602,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (4),
	createObject(1222,2147.71752930,1623.47448730,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (5),
	createObject(1222,2132.70410156,1613.04968262,995.29693604,0.00000000,0.00000000,0.00000000), --object(barrel3), (6),
	createObject(1222,2132.11596680,1614.04504395,995.29693604,0.00000000,0.00000000,0.00000000), --object(barrel3), (7),
	createObject(1222,2134.17236328,1614.76904297,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (8),
	createObject(1222,2136.33496094,1608.22631836,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (9),
	createObject(1222,2136.74145508,1609.32873535,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (10),
	createObject(1222,2137.03515625,1609.25463867,994.41314697,0.00000000,0.00000000,0.00000000), --object(barrel3), (11),
	createObject(1222,2131.03247070,1623.24780273,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (12),
	createObject(1222,2153.99218750,1623.33764648,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (13),
}

for index, object in pairs(barrels) do
	setElementInterior(object, 1)
	setElementDimension(object, dim)
end

local doingbankrob = {}
local erbeutet = {}


-- PEDS --

local ped = {}

local function refreshPeds()
	for index, p in pairs(ped) do
		if(isElement(p)) then
			destroyElement(p)
		end
	end
	ped[1] = createPed(164, 351.76852416992, 160.62651062012, 1025.7890625, 271.64801025391) -- Guard 1
	ped[2] = createPed(163, 351.79598999023, 163.98452758789, 1025.7890625, 273.21472167969) -- Guard 2
	ped[3] = createPed(164, 2148.1696777344, 1596.4381103516, 1003.9676513672, 357.48797607422) -- Guard 3 unten
	ped[4] = createPed(163, 2149.3093261719, 1603.3443603516, 1001.9676513672, 89.221527099609) -- Guard 4 uinten 2
	ped[5] = createPed(163, 2149.3081054688, 1603.0529785156, 997.77655029297, 91.664123535156)
	ped[6] = createPed(164, 2144.3195800781, 1606.1163330078, 993.568359375, 180.5398406982)
	setPedArmor(ped[6], 100)
	setElementInterior(ped[1], 3)
	setElementInterior(ped[2], 3)
	setElementInterior(ped[3], 1)
	setElementInterior(ped[4], 1)
	setElementInterior(ped[5], 1)
	setElementInterior(ped[6], 1)
	for i = 1, #ped, 1 do
		setElementDimension(ped[i], dim)
	end
	setTimer(function()
		giveWeapon(ped[1], 25, 500, true)
		giveWeapon(ped[2], 25, 500, true)
		giveWeapon(ped[3], 25, 500, true)
		giveWeapon(ped[4], 22, 500, true)
		giveWeapon(ped[5], 23, 500, true)
		giveWeapon(ped[6], 28, 500, true)
	end, 1000, 1)

	setElementData(ped[1], "bankguard", true)
	setElementData(ped[2], "bankguard", true)
	setElementData(ped[3], "bankguard", true)
	setElementData(ped[4], "bankguard", true)
	setElementData(ped[5], "bankguard", true)
	setElementData(ped[6], "bankguard", true)
end
refreshPeds()
local element = {}

element["marker1"] = createMarker(593.33087158203, -1250.1072998047, 17.321031188965, "cylinder", 1.0, 0, 255, 0, 150) -- vor der Bank
-- Draussen: 592.72894287109, -1248.5554199219, 18.159990310669
element["marker2"] = createMarker(367.3508605957, 162.38145446777, 1024.8890625, "cylinder", 1.0, 0, 255, 0, 150) -- Im vorderinterior --
setElementDimension(element["marker2"], dim)
setElementInterior(element["marker2"], 3)
-- Davor: 365.93826293945, 162.16618347168, 1025.7890625
element["marker3"] = createMarker(351.80215454102, 162.08778381348, 1024.8, "cylinder", 1.0, 0, 255, 0, 150) -- im Voderinterior zum Tresor
setElementDimension(element["marker3"], dim)
setElementInterior(element["marker3"], 3)
-- Davor: 352.91885375977, 162.17353820801, 1025.7890625
element["marker4"] = createMarker(2147.7160644531, 1603.7889404297, 1005.2677246094, "cylinder", 1.0, 0, 255, 0, 150) -- Im Tresorraum
setElementDimension(element["marker4"], dim)
setElementInterior(element["marker4"], 1)
-- Davor: 2147.6389160156, 1602.0682373047, 1006.1677246094
element["blip"] = createBlip(593.99407958984, -1248.0634765625, 18.177289962769, 52, 2, 0, 255, 0, 0, 0, 500)

addEventHandler("onMarkerHit", element["marker4"], function(hitElement)
	if(getElementType(hitElement) == "player") and (isPedInVehicle(hitElement) == false) then 
		setElementInterior(hitElement, 3)
		setElementDimension(hitElement, dim)
		setElementPosition(hitElement, 352.91885375977, 162.17353820801, 1025.7890625)
	end
end)

addEventHandler("onMarkerHit", element["marker3"], function(hitElement)
	if(getElementType(hitElement) == "player") and (isPedInVehicle(hitElement) == false) then 
		if(isPedDead(ped[1])) and (isPedDead(ped[2])) then
			setElementInterior(hitElement, 1)
			setElementDimension(hitElement, dim)
			setElementPosition(hitElement, 2147.6389160156, 1602.0682373047, 1006.1677246094)
			triggerClientEvent(hitElement, "onClientBankrobAttackPed", hitElement, ped[3])
			triggerClientEvent(hitElement, "onClientBankrobAttackPed", hitElement, ped[4])
			triggerClientEvent(hitElement, "onClientBankrobAttackPed", hitElement, ped[5])
			triggerClientEvent(hitElement, "onClientBankrobAttackPed", hitElement, ped[6])
		else
			outputChatBox("Du musst erst die Guards toeten, bevor du den Tresorraum betreten kannst.", hitElement, 0, 255, 255)
		end
	end
end)

addEventHandler("onMarkerHit", element["marker1"], function(hitElement)
	if(getElementType(hitElement) == "player") and (isPedInVehicle(hitElement) == false) then 
		setElementInterior(hitElement, 3)
		setElementDimension(hitElement, dim)
		setElementPosition(hitElement, 365.93826293945, 162.16618347168, 1025.7890625)
	end
end)

addEventHandler("onMarkerHit", element["marker2"], function(hitElement)
	if(getElementType(hitElement) == "player") and (isPedInVehicle(hitElement) == false) then 
		setElementInterior(hitElement, 0)
		setElementDimension(hitElement, 0)
		setElementPosition(hitElement, 592.72894287109, -1248.5554199219, 18.159990310669)

	end
end)

-- UEBERFALL --
element["ueberfallmarker"] = createMarker(2144.2016601563, 1625.419921875, 992.68817138672, "cylinder", 3.0, 0, 255, 0, 20)
setElementInterior(element["ueberfallmarker"], 1)
setElementDimension(element["ueberfallmarker"], dim)

element["tresorcol"] = createColSphere(2144.4306640625, 1615.1683349609, 993.68817138672, 20)
setElementInterior(element["tresorcol"], 1)
setElementDimension(element["tresorcol"], dim)

addEventHandler("onMarkerHit", element["ueberfallmarker"], function(hitElement)
	if(doing == false) then
		outputChatBox("Nutze /robbank um die Tresortuer zu sprengen!", hitElement, 0, 255, 0)
	end
end)

local markerpos = {
	[1] = {2141.9182128906, 1640.9891357422, 993.57611083984},
	[2] = {2142.0400390625, 1633.1617431641, 993.57611083984}, 
	[3] = {2142.0808105469, 1637.1442871094, 993.57611083984},
	[4] = {2141.880859375, 1629.2978515625, 993.57611083984},
	[5] = {2146.7287597656, 1629.2541503906, 993.57611083984},
	[6] = {2146.58203125, 1633.1884765625, 993.57611083984},
	[7] = {2146.5520019531, 1637.0693359375, 993.57611083984},
	[8] = {2146.6931152344, 1641.1104736328, 993.57611083984},
}

local explopos = {
	[1] = {2151.7736816406, 1615.3994140625, 993.68817138672},
	[2] = {2136.6118164063, 1610.7583007813, 993.68817138672},
	[3] = {2137.5075683594, 1622.5439453125, 993.68817138672},
	[4] = {2137.5075683594, 1622.5439453125, 993.68817138672},

}

local function createRandomExplosion()
	local id = math.random(1, #explopos)
	local x, y, z = explopos[id][1], explopos[id][2], explopos[id][3]
	local r2 = math.random(1, 2)
	if(r2 == 1) then r2 = 1 else r2 = 0 end
	createExplosion(x, y, z, r2)
end

local function resetBank()
	barrels = {
		createObject(1222,2153.77124023,1623.12243652,994.38317871,0.00000000,0.00000000,0.00000000), --object(barrel3), (14),
		createObject(1222,2155.04418945,1618.16259766,995.15692139,0.00000000,0.00000000,0.00000000), --object(barrel3), (15),
		createObject(1222,2154.41943359,1617.46240234,995.15692139,0.00000000,0.00000000,0.00000000), --object(barrel3), (16),
		createObject(1222,2153.79736328,1618.64953613,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (17),
		createObject(1222,2151.76367188,1613.64257812,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (18),
		createObject(1222,2148.25390625,1608.07019043,995.40008545,0.00000000,0.00000000,0.00000000), --object(barrel3), (19),
		createObject(1222,2147.99389648,1609.18823242,995.40008545,0.00000000,0.00000000,0.00000000), --object(barrel3), (20),
		createObject(1222,2146.31274414,1609.05358887,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (21),
		createObject(1222,2147.87939453,1610.77575684,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (22),
		createObject(1222,2141.06420898,1625.57897949,995.29693604,0.00000000,0.00000000,0.00000000), --object(barrel3), (1),
		createObject(1222,2142.12011719,1624.64013672,995.29693604,0.00000000,0.00000000,0.00000000), --object(barrel3), (2),
		createObject(1222,2147.46215820,1624.57324219,995.29693604,0.00000000,0.00000000,0.00000000), --object(barrel3), (3),
		createObject(1222,2148.91308594,1623.70141602,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (4),
		createObject(1222,2147.71752930,1623.47448730,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (5),
		createObject(1222,2132.70410156,1613.04968262,995.29693604,0.00000000,0.00000000,0.00000000), --object(barrel3), (6),
		createObject(1222,2132.11596680,1614.04504395,995.29693604,0.00000000,0.00000000,0.00000000), --object(barrel3), (7),
		createObject(1222,2134.17236328,1614.76904297,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (8),
		createObject(1222,2136.33496094,1608.22631836,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (9),
		createObject(1222,2136.74145508,1609.32873535,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (10),
		createObject(1222,2137.03515625,1609.25463867,994.41314697,0.00000000,0.00000000,0.00000000), --object(barrel3), (11),
		createObject(1222,2131.03247070,1623.24780273,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (12),
		createObject(1222,2153.99218750,1623.33764648,993.16424561,0.00000000,0.00000000,0.00000000), --object(barrel3), (13),
	}
	for index, object in pairs(barrels) do
		setElementInterior(object, 1)
		setElementDimension(object, dim)
	end
	refreshPeds()
	doing = false
	tresortuer = createObject(2634, 2144.1765136719, 1626.9592285156, 994.27239990234, 0, 0, 180)
	setElementInterior(tresortuer, 1)
	setElementDimension(tresortuer, dim)
	outputChatBox("Die Bank hat sich vom Ueberfall erholt!", getRootElement(), 0, 200, 200)
	for player, index in next, doingbankrob do
		doingbankrob[player] = false
		erbeutet[player] = 0
	end
end

local function finishExplosion()
	for i = 1, 20, 1 do
		setTimer(createRandomExplosion, (i*500), 1)
	end 
	setTimer(function()
		for i = 1, 3, 1 do
			setTimer(function()
				local id = math.random(1, #explopos)
				local x, y, z = explopos[id][1], explopos[id][2], explopos[id][3]
				createExplosion(x, y, z, 7)
			end, 500+(i*100), 1)
		end
		setTimer(function()
			for index, ob in pairs(barrels) do
				destroyElement(ob)
			end
			for i = 1, #markerpos, 1 do
				if(isElement(element["robmarker"..i])) then
					destroyElement(element["robmarker"..i])
				end
			end
		end, 1000, 1)
	end, 5000, 1)
end

local function detonateBomb(thePlayer)
	for index, player in pairs(getElementsWithinColShape(element["tresorcol"], "player")) do
		outputChatBox("Die Bombe ist hochgegangen!", player, 0, 255, 0)
		outputChatBox("Die Faesser haben Feuer gefangen! Der Tresorraum geht in 30 Sekunden hoch!", player, 255, 9, 0)
	end
	triggerClientEvent(getRootElement(), "onBankraubKlingelStart", thePlayer)
	for i = 1, 30, 1 do
		setTimer(createRandomExplosion, 5000+(i*500), 1)
	end 
	setTimer(finishExplosion, 30*1000, 1)
	local x, y, z = getElementPosition(element["bombe"])
	destroyElement(element["bombe"])
	createExplosion(x, y, z, 0)
	destroyElement(tresortuer)
	for i = 1, #markerpos, 1 do
		element["robmarker"..i] = createMarker(markerpos[i][1], markerpos[i][2], markerpos[i][3]-0.8, "cylinder", 1.0, 0, 255, 0, 50)
		local m = element["robmarker"..i]
		setElementInterior(m, 1)
		setElementDimension(m, dim)
		addEventHandler("onMarkerHit", m, function(hitElement)
			if(getElementType(hitElement) == "player") then
				destroyElement(source)
				setPedAnimation(hitElement, "bomber", "BOM_Plant_Loop", -1, true, false, false)
				toggleAllControls(hitElement, false)
				setTimer(function()
					local geld = math.random(5000, 10000)
					-- SICHERHEITSHINWEIS --
					setPedAnimation(hitElement)
					toggleAllControls(hitElement, true)
					laSetElementData(hitElement, "money", tonumber(laGetElementData(hitElement, "money"))+geld)
					givePlayerMoney(hitElement, geld)
					outputChatBox("Du hast $"..geld.." erbeutet! Nichts wie raus hier!", hitElement, 255, 255, 0)
					doingbankrob[hitElement] = true
					erbeutet[hitElement] = geld
					setTimer(function()
						doingbankrob[hitElement] = false
						erbeutet[hitElement] = 0
					end, 60000, 1)
				end, 15000, 1)
			end
		end)
	end
end

addCommandHandler("robbank", function(thePlayer)
	if(doing == false) and (isElementWithinMarker(thePlayer, element["ueberfallmarker"])) --[[and (#getElementsWithinColShape(element["tresorcol"], "player") > 1) ]]then
		doing = true
		outputChatBox("Die Bank wird ueberfallen!", getRootElement(), 200, 0, 0) 
		for index, player in pairs(getElementsWithinColShape(element["tresorcol"], "player")) do
			outputChatBox("Die Bombe explodiert in 5 Minuten!", player, 255, 255, 0)
		end
		setTimer(function()
			for index, player in pairs(getElementsWithinColShape(element["tresorcol"], "player")) do
				outputChatBox("Die Bombe explodiert in 4 Minuten!", player, 255, 255, 0)
			end
			setTimer(function()
				for index, player in pairs(getElementsWithinColShape(element["tresorcol"], "player")) do
					outputChatBox("Die Bombe explodiert in 3 Minuten!", player, 255, 255, 0)
				end
				setTimer(function()
					for index, player in pairs(getElementsWithinColShape(element["tresorcol"], "player")) do
						outputChatBox("Die Bombe explodiert in 2 Minuten!", player, 255, 255, 0)
					end
					setTimer(function()
						for index, player in pairs(getElementsWithinColShape(element["tresorcol"], "player")) do
							outputChatBox("Die Bombe explodiert in 1 Minute!", player, 255, 255, 0)
						end
							setTimer(function()
							for index, player in pairs(getElementsWithinColShape(element["tresorcol"], "player")) do
								outputChatBox("Die Bombe explodiert in 10 Sekundene!", player, 255, 255, 0)
							end
						end, 60000, 1)
					end, 60000, 1)
				end, 60000, 1)
			end, 60000, 1)
		end, 60000, 1)
		setPedAnimation(thePlayer, "bomber", "BOM_Plant_Loop", -1, true, false, false)
		toggleAllControls(thePlayer, false)
		setTimer(function()
			setPedAnimation(thePlayer)
			local x, y, z = getElementPosition(thePlayer)
			element["bombe"] = createObject(1252, x, y+0.5, z-0.5)
			setElementInterior(element["bombe"], 1)
			setElementDimension(element["bombe"], dim)
			toggleAllControls(thePlayer, true)
			setTimer(detonateBomb, 5*60*1000, 1, thePlayer) --[[5*60*1000]]
			setTimer(resetBank, 90*60*1000, 1) -- 1.5 stunden: 90*60*1000
		end, 10000, 1)
	else
		outputChatBox("Es kann jede 1 1/2 Stunden ein Bankrob gestartet werden/Die Bank wird Ueberfallen/Du bist Alleine!", thePlayer, 200, 0, 0)
	end
end)

-- PLAYER WASTED --
addEventHandler("onPlayerWasted", getRootElement(), function()
	if(doingbankrob[source] == true) then
		if(erbeutet[source]) then
			doingbankrob[source] = false
			local geld = erbeutet[source]
			laSetElementData(source, "money", tonumber(laGetElementData(source, "money"))-geld)
			outputChatBox("Du wurdest getoetet und hast dein Erbeutetes Geld("..geld.."$) verloren!", source, 255, 0, 0)
		end
	end
end)

addEventHandler("onPlayerQuit", getRootElement(), function(reason)
	if(reason ~= "Kicked") and (reason ~= "Timed Out")  then
		if(doingbankrob[source] == true) then
			if(erbeutet[source]) then
				doingbankrob[source] = false
				local geld = erbeutet[source]
				laSetElementData(source, "money", tonumber(laGetElementData(source, "money"))-geld)
				outputChatBox("Du wurdest getoetet und hast dein Erbeutetes Geld("..geld.."$) verloren!", source, 255, 0, 0)
				outputChatBox("Spieler "..getPlayerName(source).." wurde vom Server wegen Disconnecten beim Bankrob fuer eine Stunde gebannt!", getRootElement(), 255, 0, 0)
				-- INSERT INTO HASTENICHTGESEHEN LEYYNEN --
			end
		end
	end
end)

function laGetElementData(...)
	return getElementData(...)
end

function laSetElementData(...)
	return getElementData(...)
end