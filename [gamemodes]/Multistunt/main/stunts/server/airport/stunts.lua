local stunt = {}

stunt[1] = createColSphere(-1356.1156005859, -166.49806213379, 14.165584564209, 2) -- Bike wand, naehe Spawn, anfang
setElementData(stunt[1], "ms.stunttype", "start")
stunt[2] = createColSphere(-1451.4631347656, -128.4737701416, 21.460729598999, 2) -- Bike wand, naehe Spawn, anfang, finnish
setElementData(stunt[2], "ms.stunttype", "finish")
stunt[3] = createColSphere(-1419.1500244141, -259.27862548828, 25.4375, 4) -- Plattformen die sich nach oben und so bewegen, start
setElementData(stunt[3], "ms.stunttype", "start")
stunt[4] = createColSphere(-1490.7009277344, -207.6706237793, 65.512176513672, 4) -- Plattformen die sich nach oben und so bewegen, start
setElementData(stunt[4], "ms.stunttype", "finish")

stunt[3] = createColSphere(-1419.1500244141, -259.27862548828, 25.4375, 4) -- Plattformen die sich nach oben und so bewegen, start
setElementData(stunt[3], "ms.stunttype", "start")
stunt[4] = createColSphere(-1490.7009277344, -207.6706237793, 65.512176513672, 4) -- Plattformen die sich nach oben und so bewegen, start
setElementData(stunt[4], "ms.stunttype", "finish")

stunt[5] = createColSphere(-1263.9842529297, -201.32130432129, 14.1484375, 2) -- Roehre
setElementData(stunt[5], "ms.stunttype", "start")
stunt[6] = createColSphere(-1277.6944580078, -161.5029296875, 47.622619628906, 4) -- 
setElementData(stunt[6], "ms.stunttype", "finish")

stunt[7] = createColSphere(-1351.4881591797, -205.85278320313, 14.97101020813, 2) -- Busjump
setElementData(stunt[7], "ms.stunttype", "start")
stunt[8] = createColSphere(-1314.2435302734, -215.31100463867, 17.84130859375, 2) -- 
setElementData(stunt[8], "ms.stunttype", "finish")

stunt[9] = createColSphere(-1253.3640136719, -29.839651107788, 14.1484375, 4) -- Rampejump am Hangar tower
setElementData(stunt[9], "ms.stunttype", "start")
stunt[10] = createColSphere(-1150.8764648438, -145.69862365723, 37.125801086426, 6) -- 
setElementData(stunt[10], "ms.stunttype", "finish")

stunt[11] = createColSphere(-1218.2125244141, -181.2848815918, 14.1484375, 3) -- Rampejump trailer airport
setElementData(stunt[11], "ms.stunttype", "start")
stunt[12] = createColSphere(-1202.3912353516, -181.97410583496, 26.899324417114, 5) -- 
setElementData(stunt[12], "ms.stunttype", "finish")

stunt[13] = createColSphere(-1286.7449951172, -130.0592956543, 16.881549835205, 3) -- Kiesrampe aiport
setElementData(stunt[13], "ms.stunttype", "start")
stunt[14] = createColSphere(-1408.7211914063, 3.9465835094452, 58.436000823975, 10) -- 
setElementData(stunt[14], "ms.stunttype", "finish")

stunt[15] = createColSphere(-1322.2817382813, -469.90274047852, 22.610816955566, 8) -- Hangarrampe 2
setElementData(stunt[15], "ms.stunttype", "start")
stunt[16] = createColSphere(-1471.4732666016, -543.72155761719, 29.296264648438, 3) -- 
setElementData(stunt[16], "ms.stunttype", "finish") ---

stunt[17] = createColSphere(-1482.2774658203, -627.55859375, 19.998500823975, 4) -- Hangarrampe 3
setElementData(stunt[17], "ms.stunttype", "start")
stunt[18] = createColSphere(-1251.3997802734, -621.06915283203, 23.114528656006, 3) -- 
setElementData(stunt[18], "ms.stunttype", "finish") ---

local stuntmarker = createMarker(-1247.9727783203, -159.78880310059, 49.828842163086, "corona", 6, 0, 255, 0)
addEventHandler("onMarkerHit", stuntmarker, function(hitElement)
	if(getElementType(hitElement) == "vehicle") then
		local x, y, z = getElementVelocity(hitElement)
		setElementVelocity(hitElement, x, y, z+0.55)
	end
end)

addEventHandler("onColShapeHit", stunt[1], function(hitElement) setPlayerToStunt(hitElement, "BIKEWALLAIRPORT", "Birnen", "5", "bike" ) end)
addEventHandler("onColShapeHit", stunt[2], function(hitElement) finishPlayerStunt(hitElement, "BIKEWALLAIRPORT", "Birnen", "5") end)

addEventHandler("onColShapeHit", stunt[3], function(hitElement) setPlayerToStunt(hitElement, "PLATTFORMEN", "Aepfel", "50", "car" ) end)
addEventHandler("onColShapeHit", stunt[4], function(hitElement) finishPlayerStunt(hitElement, "PLATTFORMEN", "Aepfel", "50") end)

addEventHandler("onColShapeHit", stunt[5], function(hitElement) setPlayerToStunt(hitElement, "ROEHRE", "Birnen", "10", "car" ) end)
addEventHandler("onColShapeHit", stunt[6], function(hitElement) finishPlayerStunt(hitElement, "ROEHRE", "Birnen", "10") end)

addEventHandler("onColShapeHit", stunt[7], function(hitElement) setPlayerToStunt(hitElement, "BUSJUMP", "Aepfel", "45", "bike" ) end)
addEventHandler("onColShapeHit", stunt[8], function(hitElement) finishPlayerStunt(hitElement, "BUSJUMP", "Aepfel", "45") end)

addEventHandler("onColShapeHit", stunt[9], function(hitElement) setPlayerToStunt(hitElement, "RAMPEJUMPTOWER", "Birnen", "2", "all" ) end)
addEventHandler("onColShapeHit", stunt[10], function(hitElement) finishPlayerStunt(hitElement, "RAMPEJUMPTOWER", "Birnen", "2") end)

addEventHandler("onColShapeHit", stunt[11], function(hitElement) setPlayerToStunt(hitElement, "RAMPETRAILER", "Aepfel", "10", "all" ) end)
addEventHandler("onColShapeHit", stunt[12], function(hitElement) finishPlayerStunt(hitElement, "RAMPETRAILER", "Aepfel", "10") end)

addEventHandler("onColShapeHit", stunt[13], function(hitElement) setPlayerToStunt(hitElement, "KIESRAMPE", "Birnen", "5", "all" ) end)
addEventHandler("onColShapeHit", stunt[14], function(hitElement) finishPlayerStunt(hitElement, "KIESRAMPE", "Birnen", "5") end)

addEventHandler("onColShapeHit", stunt[15], function(hitElement) setPlayerToStunt(hitElement, "HANGARRAMPE", "Birnen", "2", "all" ) end)
addEventHandler("onColShapeHit", stunt[16], function(hitElement) finishPlayerStunt(hitElement, "HANGARRAMPE", "Birnen", "2") end)

addEventHandler("onColShapeHit", stunt[17], function(hitElement) setPlayerToStunt(hitElement, "HANGARRAMPE2", "Birnen", "15", "car" ) end)
addEventHandler("onColShapeHit", stunt[18], function(hitElement) finishPlayerStunt(hitElement, "HANGARRAMPE2", "Birnen", "15") end)