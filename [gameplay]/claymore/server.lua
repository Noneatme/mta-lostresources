-- Claymorescript [C] by MuLTi --

-- EVENTS --
addEvent("onClaymoreCreate", true)
addEvent("onClaymoreExplode", true)
addEvent("onClaymoreGet", true)

-- ARRAYS & VARIABLEN --
local claymore = {}
local clayid = 0


-- Claymore Create Event --
addEventHandler("onClaymoreCreate", getRootElement(), function(x1, y1, z1, rotx1, roty1, rotz1, x2, y2, z2)
	claymore[clayid] = createObject(1252, x1, y1, z1)
	local object = claymore[clayid]
	setElementRotation(object, rotx1, roty1, rotz1)
	--setElementFrozen(object, true)
	
	local ob2 = createObject(1252, x2, y2, z2)
	setObjectScale(ob2, 0.1)
	setElementFrozen(ob2, true)
	setElementData(object, "ob2", ob2)
	setElementData(object, "id", clayid)
	--setElementData(object, "fraktion", getElementData(source, "fraktion"))
	triggerClientEvent(getRootElement(), "onClientClaymoreGive", source, clayid, object)
	setTimer(setElementData, 3000, 1, object, "armed", true)
	clayid = clayid+1
end)

-- Wenn es Explodiert --
addEventHandler("onClaymoreExplode", getRootElement(), function(id)
	local x, y, z = getElementPosition(claymore[id])
	createExplosion(x, y, z, 7)
	triggerClientEvent(getRootElement(), "onClientClaymoreDestroy", source, getElementData(claymore[id], "id"))
	destroyElement(getElementData(claymore[id], "ob2"))
	destroyElement(claymore[id])
	claymore[id] = nil
end)

-- Sycronisation --
addEventHandler("onClaymoreGet", getRootElement(), function(id)
	for index, clay in pairs(claymore) do
		triggerClientEvent(source, "onClientClaymoreGive", source, getElementData(clay, "id"), clay)
	end
end)


-- SERVER OUTPUT --

outputServerLog("Claymore Script bei MuLTi geladen! /claymore um eine Bombe zu platzieren.")