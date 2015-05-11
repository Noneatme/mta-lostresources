function toggleCursorState(typ)
	if(typ == 1) then
		showCursor(true)
		
	else
		showCursor(false)
	end
end

bindKey("ralt", "down", function() showCursor(true) setElementData(gMe, "cursorshowing", true) end)
bindKey("ralt", "up", function() showCursor(false) setElementData(gMe, "cursorshowing", false) end)

addCommandHandler("rebind", function()
	bindKey("ralt", "down", function() showCursor(true) setElementData(gMe, "cursorshowing", true) end)
	bindKey("ralt", "up", function() showCursor(false) setElementData(gMe, "cursorshowing", false) end)
end)

rollover_country_names = {
	[1] = "Country\n\nThis user come from\nGermany.",
	[2] = "Country\n\nThis user come from\nAustria.",
	[3] = "Country\n\nThis user come from\nSwitzerland.",
	[4] = "Country\n\nThis user come from the\nUSA.",
	[5] = "Country\n\nThis user come from\nAustralia.",
	[6] = "Country\n\nThis user come from\nFrance.",
	[7] = "Country\n\nThis user come from\nunknow."
}

rollover_names = {
	["Stunter"] = "Stunter\n\nThis user is a normal\nstuner.",
	["Admin"] = "Admin\n\nThis is a Multistunt\nstaff-member.",
	["Obstbar"] = "Fruitbar\n\nHere you can see\nyour fruits.",
	["VIP"] = "VIP\n\nThis user is a\nVIP.",
}
