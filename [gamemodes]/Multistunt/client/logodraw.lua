local show = true
local sx, sy = guiGetScreenSize()
addEventHandler("onClientRender", getRootElement(), function()
	if(show == true) then
		local x, y = sx/2, sy/2
		dxDrawImage ( x/x+20, y*2-65, 150, 52, "data/images/multistunt.png", 0, 0, 0, tocolor(255, 255, 255, 200), true)
	end
end)

addCommandHandler("logo", function() show = not show end)