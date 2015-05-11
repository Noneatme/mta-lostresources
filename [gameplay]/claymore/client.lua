local gMe = getLocalPlayer()
-- Claymore Script [C] by MuLTi. You are not allowed to remove the credits --

-- EVENTS --
addEvent("onClientClaymoreGive", true)
addEvent("onClientClaymoreDestroy", true)


-- ARRAYS & VARIABLEN --
local enabled = false
local claymore = {}
local cMarker = {}

-- Claymore create --

addEventHandler("onClientClick", getRootElement(), function(mouse, state, sx, sy, x, y, z)
	if(mouse == "right") then
		showCursor(false)
		enabled = false
	return end
	if(mouse == "left") and (state == "down") then
		if(enabled == false) then return end
		if(x) then
			enabled = false
			local object = createObject(1252, x, y, z)
			
			local x1, y1 = getElementPosition(object)
			local x2, y2 = getElementPosition(gMe)
			local rot = math.atan2(y2 - y1, x2 - x1) * 180 / math.pi
			
			setElementRotation(object, 0, 0, rot+90)
			
			local pos = getGroundPosition(x, y, z)
			local dis = getDistanceBetweenPoints3D(x, y, z, x, y, pos)
			local rotx = false
			if(dis > 0) then
				
			else
				rotx = true
				setElementRotation(object, 90, 0, rot+90)
			end
			-- POSITION CHANGE --
			local px, py, pz = getElementPosition(object)
			local rx, ry, rz = getElementRotation(object)
			
			rz = rz-180
			local distance = 0.1
			local nx, ny, nz
			
			if(rotx == false) then
				nx = px + math.cos(math.rad(rz + 90)) * distance
				ny = py + math.sin(math.rad(rz + 90)) * distance
				nz = pz
			else
				nx = px
				ny = py
				nz = pz+0.1
			end
			setElementPosition(object, nx, ny, nz)
			local px, py, pz = getElementPosition(object)
			local rx, ry, rz = getElementRotation(object)
			rz = rz-180
			local distance = 70 
			local nx, ny, nz
			
			if(rotx == false) then
				nx = px + math.cos(math.rad(rz + 90)) * distance
				ny = py + math.sin(math.rad(rz + 90)) * distance
				nz = pz
			else
				nx = px
				ny = py
				nz = pz+50
			end
			
			local ob2 = createObject(1252, nx, ny, nz)

			
			setElementData(object, "ob2", ob2)
		
			local x1, y1, z1 = getElementPosition(object)
			local rotx1, roty1, rotz1 = getElementRotation(object)
			local x2, y2, z2 = getElementPosition(ob2)
			
			destroyElement(object)
			destroyElement(ob2)
			triggerServerEvent("onClaymoreCreate", gMe, x1, y1, z1, rotx1, roty1, rotz1, x2, y2, z2)
			showCursor(false)
		end
	end
end)

-- RENDER --

addEventHandler("onClientRender", getRootElement(), function()
	for _, object in pairs(claymore) do
		local x, y, z = getElementPosition(object)
		local x2, y2, z2 = getElementPosition(getElementData(object, "ob2"))
		local hit, hitx, hity, hitz, hitElement = processLineOfSight(x, y, z, x2, y2, z2, true, true, true)
		if(hitx) then
			dxDrawLine3D(x, y, z, hitx, hity, hitz, tocolor(255, 0, 0, 200), 2)
			if(hit == true) and(hitElement) then
				if(getElementType(hitElement) == "player") or (getElementType(hitElement) == "vehicle") then
					if(getElementData(object, "armed") == true) then
						-- FRAKTION WURDE AUSGEKLAMMERT --
						--local frak = getElementData(object, "fraktion")
						--if(frak) then
							--if(frak ~= getElementData(hitElement, "fraktion")) then
								setElementData(object, "armed", "explodet")
								triggerServerEvent("onClaymoreExplode", gMe, getElementData(object, "id"))
							--else
								--setMarkerColor(getElementData(object, "attachedMarker"), 0, 255, 0)
							--end
						end	
					end
				end
		else
			dxDrawLine3D(x, y, z, x2, y2, z2, tocolor(255, 0, 0, 200), 2)
		end
	end
end)


-- Server getriggertes Event --

addEventHandler("onClientClaymoreGive", getRootElement(), function(id, object)
	local x, y, z = getElementPosition(object)
	cMarker[id] = createMarker(x, y, z, "corona", 0.8, 0, 255, 0, 150)
	setElementData(object, "attachedMarker", cMarker[id], false)
	attachElements(cMarker[id], object)
	if(getElementData(cMarker[id], "armed") == true) then
		setMarkerColor(cMarker[id], 255, 0, 0, 200)
	else
		setTimer(function()
			if(isElement(cMarker[id])) then
				setMarkerColor(cMarker[id], 255, 0, 0, 150)
				local sound = playSound3D("armed.mp3", x, y, z, false)
				setSoundMaxDistance(sound, 50)
				setSoundVolume(sound, 1)
			end
		end, 3000, 1)
	end
	claymore[id] = object
end)

-- COMMAND --

addCommandHandler("claymore", function()
	enabled = true
	showCursor(true)
end)

-- NEWSVANS SIRENS --
for index, car in pairs(getElementsByType("vehicle")) do
	if(getElementModel(car) == getVehicleModelFromName("Newsvan")) then
		addVehicleSirens(veh, 4, 4, false, true, false, true)
		setVehicleSirens(veh, 1, -0.9, -1.25, 1.3, 255, 255, 255, 255, 255)
		setVehicleSirens(veh, 2, 0.9, -1.25, 1.3, 255, 255, 255, 255, 255)
		setVehicleSirens(veh, 3, 0.8, -2.7, 1.3, 255, 0, 0, 255, 255)
		setVehicleSirens(veh, 4, -0.8, -2.7, 1.3, 255, 0, 0, 255, 255)
	end
end

-- Client Sycronisation --

addEventHandler("onClientClaymoreDestroy", getRootElement(), function(id)
	claymore[id] = nil
	if(isElement(cMarker[id])) then destroyElement(cMarker[id]) end
end)

addEventHandler("onClientResourceStart", getResourceRootElement(), function()
	triggerServerEvent("onClaymoreGet", gMe)
end)