---------------------------------
-- COPYRIGHT[C], NOVEMBER 2012 --
------- MADE BY NONEATME --------
---------------------------------
-- #######################################
-- ## Project: MTA:The Walking Death	##
-- ## Name: Custom Explosions			##
-- ## Author: Noneatme					##
-- ## Version: 1.0						##
-- ## License: See top Folder			##
-- #######################################


local cFunc = {}
local cSetting = {}


-- FUNCTIONS --
	


-- EVENT HANDLERS --


cFunc["createExplosion"] = function(x, y, z, typ)
		
	engineSetModelLODDistance(2011, 10000)
	engineSetModelLODDistance(2059, 10000)
	engineSetModelLODDistance(2013, 10000)
	engineSetModelLODDistance(2054, 10000)
	engineSetModelLODDistance(2075, 10000)


	if(typ ~= 7) then
		-- OBJEKTE --
		
		local ped = createPed(60, x, y, z+1)
		setElementAlpha(ped, 0)
		setTimer(destroyElement, 5000, 1, ped)
		for i= 1, 8 do
			local x2 = x
			local y2 = y
			
			local randIds = {1252, 1265, 1218, 1230}
			
			
			local id = randIds[1];
			
			if(math.random(0, 5) == 3) then
				id = randIds[math.random(1, #randIds)];
			end
			
			local objekt = createObject(id, x2, y2, z+1)
			
			setElementRotation(objekt, math.random(0, 360), math.random(0, 360), math.random(0, 360))
			setTimer(destroyElement, 15000, 1, objekt)
				
		--	setElementAlpha(objekt, 150)
			setObjectScale(objekt, 0.75)
			
			
			local newX, newY = getPointFromDistanceRotation(x2, y2, 2.5, 360 * (i/8))
				
				for i = 1, 5, 1 do
					setTimer(function()
						setElementVelocity(objekt, (newX-x2)/8, (newY-y2)/8, 0.5)
						
					--	createExplosion(x2, y2, z, 5, false, 0, false)
					end, i*100, 1)
				end
				setElementVelocity(objekt, (newX-x2)/8, (newY-y2)/8, 10)

			end
	
		if not(dim) then
			dim = 0;
		end
		local ob = {}
		local rz = z
		local sound = playSound3D("files/sounds/kaboom.wav", x, y, z, false)
		setSoundMaxDistance(sound, 250)
		local oldExplo = createExplosion(x, y, z, 5, true, -5.0, true)
		fxAddSparks(x, y, z, 0, 0, 3, 3, 500, 0, 0, 3, false, 2, 5)
		createFire(x, y, z);
	--	setElementDimension(oldExplo, dim)
		-- SCHWARZER RAUCH --
			ob[1] = createObject(2054, x, y, z)
			for i2 = 1, #ob, 1 do
				if(isElement(ob[i2])) then
					setTimer(destroyElement, 3000, 1, ob[i2])
					setElementCollisionsEnabled(ob[i2], false)
					setElementDimension(ob[i2], dim)
					setElementAlpha(ob[i2], 0)
				end
			end
			ob = {}
		-- EXPLOSION --
		for i = 0, 5, 0.5 do
			ob[1] = createObject(2013, x+i, y, z)
			ob[2] = createObject(2013, x-i, y, z)
			ob[3] = createObject(2013, x, y+i, z)
			ob[4] = createObject(2013, x, y-i, z)
			ob[5] = createObject(2013, x, y, z)
			ob[6] = createObject(2013, x-i, y+i, z)
			ob[7] = createObject(2013, x+i, y-i, z)
			ob[8] = createObject(2013, x+i, y+i, z)
			ob[9] = createObject(2013, x-i, y-i, z)
			
			ob[10] = createObject(2013, x+i, y, z+2)
			ob[12] = createObject(2013, x-i, y, z+2)
			ob[13] = createObject(2013, x, y+i, z+2)
			ob[14] = createObject(2013, x, y-i, z+2)
		
			ob[15] = createObject(2013, x, y, z+4)
			for i2 = 1, #ob, 1 do
				if(isElement(ob[i2])) then
					setTimer(destroyElement, 1005, 1, ob[i2])
					setElementCollisionsEnabled(ob[i2], false)
					setElementDimension(ob[i2], dim)
					setElementAlpha(ob[i2], 0)
				end
			end
			ob = {}
		end
		-- RAUCH --
	
		setTimer(function()
			for i = 0, 5, 0.5 do
				local id = 2011
				z = z+0.1
				ob[1] = createObject(id, x+i, y, z)
				ob[2] = createObject(id, x-i, y, z)
				ob[3] = createObject(id, x, y+i, z)
				ob[4] = createObject(id, x, y-i, z)
	
				for i2 = 1, #ob, 1 do
					if(isElement(ob[i2])) then
						setTimer(destroyElement, 1004, 1, ob[i2])
						setElementCollisionsEnabled(ob[i2], false)
						setElementDimension(ob[i2], dim)
						setElementAlpha(ob[i2], 0)
					end
				end
				ob = {}
			end
		
		end, 200, 1)
		-- FUNKTEN --
		setTimer(function()
			local id = 2059
			z = z+0.1
			ob[1] = createObject(id, x-2, y+4, z)
			ob[2] = createObject(id, x+2, y-4, z)
			ob[3] = createObject(id, x+4, y-2, z)
			ob[4] = createObject(id, x-4, y+2, z)
			for i2 = 1, #ob, 1 do
				if(isElement(ob[i2])) then
					setTimer(destroyElement, 1003, 1, ob[i2])
					setElementCollisionsEnabled(ob[i2], false)
					setElementDimension(ob[i2], dim)
					setElementAlpha(ob[i2], 0)
				end
			end
			ob = {}
			
		end, 50, 1)
		-- RAUCHBETT --
		
			local id = 2075
			z = rz
			ob[1] = createObject(id, x, y-1, z)
			ob[2] = createObject(id, x, y-2, z)
			ob[3] = createObject(id, x, y+1, z)
			ob[4] = createObject(id, x, y+2, z)
			for i2 = 1, #ob, 1 do
				if(isElement(ob[i2])) then
					setTimer(destroyElement, 5000, 1, ob[i2])
					setElementCollisionsEnabled(ob[i2], false)
					setElementDimension(ob[i2], dim)
					setElementAlpha(ob[i2], 0)
				end
			end
		
		for index, obj in pairs(ob) do
			setElementCollisionsEnabled(obj, false)
			setElementDimension(obj, dim)
		end
		
		
	end
end

addEventHandler("onClientExplosion", getRootElement(), cFunc["createExplosion"])


-- EVENT HANDLERS --
function getPointFromDistanceRotation(x, y, dist, angle)
 
    local a = math.rad(90 - angle);
 
    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;
 
    return x+dx, y+dy;
 
end