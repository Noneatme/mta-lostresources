addEvent("onMultistuntSpawnBasejump", true)




addEventHandler("onMultistuntSpawnBasejump", getRootElement(), function()
	toggleAllControls(true)
	setControlState("jump", true)
	setTimer(function()
		setControlState("jump", false)
	end, 1000, 1)
end)