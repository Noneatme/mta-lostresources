-- Barrel Gamemode by MuLTi!--
-- Bitte nicht Credits entfernen!--
local ingame = false
local remtime = 0
local starting_time = 45000
local gespielt = 0
local timer
local map = 0
setTime(0, 0)
setMinuteDuration(10000000)
setGameType("Barrel-Mode")

local randomvel = {
	[1] = "0.05",
	[2] = "0.1",
	[3] = "0.15",
	[4] = "0.2",
	[5] = "0.3",
	[6] = "0.5"
}

local mapNames = {
	[0] = "Berg"
}
	
local randompos = {
	[1] = "0.1",
	[2] = "0.5",
	[3] = "1.0",
	[4] = "1.5",
	[5] = "2.0",
	[6] = "2.5",
	[7] = "3.0",
	[8] = "3.5",
	[9] = "4.1",
}

function setPlayerToStatus(thePlayer, map)
	fadeCamera(thePlayer, true)
		if(ingame == false) then
			
		else
			if(map == 0) then
				setCameraMatrix(thePlayer,-600.67163085938, -692.43823242188, 41.391277313232, -639.07952880859, -781.35723876953, 66.255668640137)
			end
			if(getElementData(thePlayer, "done") ~= true) then
				outputChatBox("Das Spiel ist bereits gestartet! Du musst noch warten.", thePlayer, 0, 200, 200)
			end
		end
end

addEventHandler("onPlayerJoin", getRootElement(), function()
	for i = 1, 20, 1 do
		outputChatBox(" ", source)
	end
	outputChatBox("Willkommen auf Barrel-Mode!", source, 0, 200, 0)
	fadeCamera(source, true)
	setPlayerToStatus(source, map)
end)

addEventHandler("onPlayerWasted", getRootElement(),function()
	local player = source
	fadeCamera(player, false, 1.0, 255, 255, 255)
	setTimer(setPlayerToStatus, 1500, 1, player, map)
end)	

function stop_barrel()
	local done = 0
	outputChatBox("Spiel Vorbei! Neues Spiel startet in 5 Sekunden.", getRootElement(), 0, 200, 0)
	outputChatBox("Rundenergebnisse: ", getRootElement(), 255, 255, 0)
	for index, player in pairs(getElementsByType("player")) do
		setElementData(player, "barrel.alive", false)
		if(getElementData(player, "done") == true) then
			outputChatBox(getPlayerName(player).." hat Ueberlebt!", getRootElement(), 0, 255, 0)
			done = 1
		end
		setElementData(player, "done", false)
	end
	if(done == 0) then outputChatBox("Es hat keiner ins Ziel geschafft.", getRootElement(), 255, 0, 0) end
	setTimer(start_barrel, 7000, 1)
	remtime = 0
	gespielt = 0
	if(map == 0) then
		for index, object in pairs(getElementsByType("object")) do
			if(getElementData(object, "ROFL") == true) then
				destroyElement(object)
			end
		end
		for index, object in pairs(getElementsByType("marker")) do
			if(getElementData(object, "ROFL") == true) then
				destroyElement(object)
			end
		end
	end
end
addEvent("onMinutenZeitNeed", true)
addEventHandler("onMinutenZeitNeed", getRootElement(),
function()
	triggerClientEvent(source, "onBarrelSpawn", source, (gespielt*60*1000)/60)
end)


function letFaesserFall(map)
	if(map == 0) then
		local shape = createColSphere(-552.07012939453, -709.57989501953, 29.388408660889, 10)
		addEventHandler("onColShapeHit", shape,
		function(hitElement)
			outputChatBox("Du hast es Geschafft!", hitElement, 0, 255, 0)
			setElementData(hitElement, "done", true)
			setPlayerToStatus(hitElement, map)
		end)
		setTimer(function()
			local rand = math.random(1, #randompos)
			local vers = tonumber(randompos[rand])
			local object = createObject(1218, -665.6298828125, -815.64636230469+vers, 96.897972106934)
			local vehicle = createVehicle(594, -665.6298828125, -815.64636230469+vers, 96.897972106934)
			local marker = createMarker(-665.6298828125, -815.64636230469+vers, 96.897972106934, "corona", 1, math.random(0, 255), math.random(0, 255), math.random(0, 255), 100)
			setElementAlpha(vehicle, 0)
			attachElements(object, vehicle)
			attachElements(marker, object)
			setTimer(destroyElement, 100, 1, vehicle)
			setElementVelocity(vehicle, 0.2, 0.7-(vers/5), 0.2+(tonumber(randomvel[math.random(1, #randomvel)])))
			setElementData(object, "ROFL", true)
			setElementData(marker, "ROFL", true)
			setTimer(destroyElement,15000, 1, object)
			setTimer(destroyElement,15000, 1, marker)
		end, 50, 40)
		setTimer(function()
			setTimer(function()
				local rand = math.random(1, #randompos)
				local vers = tonumber(randompos[rand])
				local object = createObject(1218, -605.77593994141, -739.20642089844, 58.644638061523)
				local vehicle = createVehicle(594, -605.77593994141, -739.20642089844, 58.644638061523)
				local marker = createMarker(-605.77593994141, -739.20642089844, 58.644638061523, "corona", 1, math.random(0, 255), math.random(0, 255), math.random(0, 255), 100)
				setElementAlpha(vehicle, 0)
				attachElements(object, vehicle)
				attachElements(marker, object)
				setTimer(destroyElement, 100, 1, vehicle)
				setElementVelocity(vehicle, -0.3, 0+(vers/5), 0.1+(tonumber(randomvel[math.random(1, #randomvel)])))
				setElementData(object, "ROFL", true)
				setElementData(marker, "ROFL", true)
				setTimer(destroyElement,15000, 1, object)
				setTimer(destroyElement,15000, 1, marker)
			end, 50, 50)
		end, 8000, 1)
		setTimer(function()
			setTimer(function()
				local rand = math.random(1, #randompos)
				local vers = tonumber(randompos[rand])
				local object = createObject(1218, -653.96826171875, -712.81927490234, 62.304466247559)
				local vehicle = createVehicle(594, -653.96826171875, -712.81927490234, 62.304466247559)
				local marker = createMarker(-653.96826171875, -712.81927490234, 62.304466247559, "corona", 1, math.random(0, 255), math.random(0, 255), math.random(0, 255), 100)
				setElementAlpha(vehicle, 0)
				attachElements(object, vehicle)
				attachElements(marker, object)
				setTimer(destroyElement, 100, 1, vehicle)
				setElementVelocity(vehicle, 0.7, 0+(vers/5), 0.1+(tonumber(randomvel[math.random(1, #randomvel)])))
				setElementData(object, "ROFL", true)
				setElementData(marker, "ROFL", true)
			end, 50, 50)
		end, 8000, 1)
		setTimer(function()
			setTimer(function()
				local rand = math.random(1, #randompos)
				local vers = tonumber(randompos[rand])
				local object = createObject(1218, -572.11541748047, -700.40496826172, 32.199913024902)
				local vehicle = createVehicle(594, -572.11541748047, -700.40496826172, 32.199913024902)
				local marker = createMarker(-572.11541748047, -700.40496826172, 32.199913024902, "corona", 1, math.random(0, 255), math.random(0, 255), math.random(0, 255), 100)
				setElementAlpha(vehicle, 0)
				attachElements(object, vehicle)
				attachElements(marker, object)
				setTimer(destroyElement, 100, 1, vehicle)
				setElementVelocity(vehicle, 0.3, 0-(vers/7), 0.1+(tonumber(randomvel[math.random(1, #randomvel)])))
				setElementData(object, "ROFL", true)
				setElementData(marker, "ROFL", true)
			end, 50, 50)
		end, 12000, 1)
		-- -572.11541748047, -700.40496826172, 32.199913024902
	end
end
addEvent("onBarrelVersage", true)
addEventHandler("onBarrelVersage", getRootElement(),
function()
	killPed(source)
	outputChatBox("Du wurdest getroffen!", source, 200, 0, 0)
end)
function start_barrel()
	ingame = true
	remtime = starting_time
	gespielt = (starting_time/60/1000)*60
	setMapName(mapNames[map])
	setTimer(function() gespielt = gespielt-1 end, 1000, starting_time/60)
	for index, player in pairs(getElementsByType("player")) do
		outputChatBox("Du wirst gespawnt...", player, 0, 255, 0)
		setElementData(player, "barrel.alive", true)
		spawnPlayer(player, 0, 0, 2)
		fadeCamera(player, false, 1.0, 255, 255, 255)
		setTimer(function()
			fadeCamera(player, true)
			setElementPosition(player, -670.05267333984, -812.53765869141, 96.39582824707)
			triggerClientEvent(player, "onBarrelSpawn", player, starting_time)
			setElementAlpha(player, 200)
			setTimer(setElementAlpha, 3000, 1, player, 255)
			local skins = getValidPedModels()
			local mathskin = math.random(1, #skins)
			setElementModel(player, mathskin)
			setCameraTarget(player, player)
		end, 1500, 1)
	end
	setTimer(stop_barrel, starting_time, 1)
	--setTimer(function() remtime = remtime-1 end, 1000, starting_time)
	outputChatBox("Los! Die Faesser fallen!", getRootElement(), 255, 0, 0)
	setTimer(letFaesserFall, 2000, 1, map)
end
start_barrel()



