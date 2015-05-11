---------------------------------
-- COPYRIGHT[C], NOVEMBER 2012 --
------- MADE BY NONEATME --------
---------------------------------

local cFunc = {}
local cSetting = {}


-- FUNCTIONS --



cFunc["blow_vehicle"] = function()
	local x, y, z = getElementPosition(source)
	createExplosion(x, y, z, 7);
end



-- EVENT HANDLERS --

addEventHandler("onVehicleExplode", getRootElement(), cFunc["blow_vehicle"])