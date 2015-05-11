local randomSpawns = {
	[1] = "-1368.8778076172, -179.89527893066, 14.1484375", -- Airport
	[2] = "-1798.2821044922, 525.46704101563, 234.8874206543, 241", -- Basejump SF
	[3] = "1871.2613525391, -1382.7834472656, 13.528824806213", -- Skatepark
	[4] = "1537.3332519531, -1338.0704345703, 330.05227661133, 24", -- Basejump LS Startower
	[5] = "-2661.5778808594, 1594.9934082031, 225.7578125, 270", -- Basejump SF Goldengate
	[6] = "-1280.8303222656, 48.362674713135, 70.4453125, 137", -- Basejump SF Airport
	
}

addEvent("onMultistuntSpawn",true)
addEventHandler("onMultistuntSpawn", getRootElement(),
function()
	if(getElementType(source) ~= "player") then return end
	setCameraTarget(source, source)
	local x, y, z = getElementPosition(source)
	local int, dim = getElementInterior(source), getElementDimension(source)
	local basejump = false
	if(getElementData(source, "ms.spawned") ~= true) then 
		setElementData(source, "ms.spawned", true) 
		local rand = math.random(1, #randomSpawns)
		local x, y, z, rot = 0, 0, 0, 0
		
		if(rand == 1) or (rand == 3) then
			x, y, z = gettok(randomSpawns[rand], 1, ","), gettok(randomSpawns[rand], 2, ","), gettok(randomSpawns[rand], 3, ",")
		else
			basejump = true
			x, y, z, rot = gettok(randomSpawns[rand], 1, ","), gettok(randomSpawns[rand], 2, ","), gettok(randomSpawns[rand], 3, ","), gettok(randomSpawns[rand], 4, ",")
		end
		spawnPlayer(source, x, y, z)
		setPedRotation(source, rot)
		setElementInterior(source, int)
		setElementDimension(source, dim)
		setCameraTarget(source, source)
		setElementModel(source, getElementData(source, "ms.skin"))
	else
		spawnPlayer(source, x, y, z)
		setElementInterior(source, int)
		setElementDimension(source, dim)
		setCameraTarget(source, source)
		setElementModel(source, getElementData(source, "ms.skin"))
	end
	local result = mysql_query(handler, "SELECT X, Y, Z, LASTINT, LASTDIM FROM settings WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."';")
	if(result) then
		local row = mysql_fetch_assoc(result)
		local x, y, z, int, dim = row['X'], row['Y'], row['Z'], tonumber(row['LASTINT']), tonumber(row['LASTDIM'])
		if(tonumber(x) == 0) and (tonumber(y) == 0) and (tonumber(z) == 0) then
			mysql_free_result(result)
		else
			basejump = false
			setElementPosition(source, x, y, z)
			setElementInterior(source, int)
			setElementDimension(source, dim)
			outputChatBox("Message from the server: You have been warped to a position, where you logged out/you timed out/the server has been restartet.", source, 0, 200, 0)
			mysql_query(handler, "UPDATE settings SET X = '0', Y = '0', Z = '0', LASTINT = '0', LASTDIM = '0' WHERE NAME = '"..mysql_escape_string(handler, getPlayerName(source)).."';")
			
		end
	end
	if(basejump == true) then
		giveWeapon(source, 46, 1, true)
		toggleAllControls(source, false)
		local play = source
		setTimer(triggerClientEvent, 500, 1, play, "onMultistuntSpawnBasejump", play)
	end
end)

addEventHandler("onPlayerWasted", getRootElement(),
function()
	fadeCamera(source, false, 2.0, 255, 255, 255)
	local playa = source
	setTimer(function()
		fadeCamera(playa, true)
		triggerEvent("onMultistuntSpawn", playa)
	end, 2500, 1)
end)