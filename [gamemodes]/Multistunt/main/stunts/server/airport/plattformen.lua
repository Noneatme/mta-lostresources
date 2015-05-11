local p1 = createObject(3115, -1423.5, -256.69921875, 24.200000762939, 0, 0, 323) -- nach Oben
local p2 = createObject(3115, -1440.5, -244.2998046875, 44.200000762939, 0, 0, 323)--nach unten
local p3 = createObject(3115, -1457.599609375, -231.8994140625, 44.200000762939, 0, 0, 323)--nach oben
local p4 = createObject(3115, -1474.6999511719, -219.5, 64.200000762939, 0, 0, 323)--nach unten
setElementData(p1, "movingobject", true)
setElementData(p2, "movingobject", true)
setElementData(p3, "movingobject", true)
setElementData(p4, "movingobject", true)

local var = 0
setTimer( function()
	if(var == 0) then
		var = 1
		local x, y, z = getElementPosition(p1)
		moveObject(p1, 3000, x, y, z+10, 0, 0, 0, "InOutQuad")
		local x, y, z = getElementPosition(p2)
		moveObject(p2, 3000, x, y, z-10, 0, 0, 0, "InOutQuad")
		local x, y, z = getElementPosition(p3)
		moveObject(p3, 3000, x, y, z+10, 0, 0, 0, "InOutQuad")
		local x, y, z = getElementPosition(p4)
		moveObject(p4, 3000, x, y, z-10, 0, 0, 0, "InOutQuad")
	else
		var = 0
		local x, y, z = getElementPosition(p1)
		moveObject(p1, 3000, x, y, z-10, 0, 0, 0, "InOutQuad")
		local x, y, z = getElementPosition(p2)
		moveObject(p2, 3000, x, y, z+10, 0, 0, 0, "InOutQuad")
		local x, y, z = getElementPosition(p3)
		moveObject(p3, 3000, x, y, z-10, 0, 0, 0, "InOutQuad")
		local x, y, z = getElementPosition(p4)
		moveObject(p4, 3000, x, y, z+10, 0, 0, 0, "InOutQuad")
	end
end, 3000, 0)
