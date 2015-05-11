--718.13104248047, -2104.5949707031, 687.45166015625
--718.13104248047, -2104.5949707031, 6.572464466095
local stunt1 = createColSphere(718.13104248047, -2104.5949707031, 687.45166015625, 20)
local stunt2 = createColSphere(718.13104248047, -2104.5949707031, 6.572464466095, 20)

addEventHandler("onColShapeHit", stunt1, function(hitElement) setPlayerToStunt(hitElement, "DUNEDROP", "Birnen", "3", "Dune" ) end)
addEventHandler("onColShapeHit", stunt2, function(hitElement) finishPlayerStunt(hitElement, "DUNEDROP", "Birnen", "3") end)
