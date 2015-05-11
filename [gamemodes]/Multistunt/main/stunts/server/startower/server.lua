local car = {}

car[1] = createVehicle(468, 1557.0615234375, -1347.109375, 329.12942504883, 359.84619140625, 359.99450683594, 153.20983886719) -- Sanchez
car[2] = createVehicle(468, 1558.654296875, -1347.361328125, 329.1296081543, 0.3460693359375, 359.98352050781, 151.08947753906) -- Sanchez
car[3] = createVehicle(468, 1560.0107421875, -1347.2763671875, 329.12951660156, 0.516357421875, 359.97802734375, 153.85803222656) -- Sanchez

for v = 1, #car, 1 do
	setVehicleColor(car[v], 0, 0, 0, 0, 0, 0)
	setElementData(car[v], "mv.typ", "Freecar")
	setElementData(car[v], "mv.besitzer", "-")
	setElementData(car[v], "mv.stuntcar", "startower")
	toggleVehicleRespawn ( car[v], true )
	setVehicleRespawnDelay ( car[v], 5000 )
	setVehicleIdleRespawnDelay ( car[v], IdleCarRespawn*1000*60 )
	giveVehicleBetterEngine(car[v])
	giveVehiclePanzerung(car[v])
end