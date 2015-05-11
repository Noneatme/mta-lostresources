--jumptop1_128
--jumpside2_256
-- ws_carrierdeckbase

local stuntShader, stuntShader2, stuntShader3
local startTickCount

addEventHandler("onClientResourceStart", getResourceRootElement(), function()	
	--[[
		Totales Chaos hier!
		Keine Ahnung, wie das entstanden ist
	--]]
	-- Uzi waffe --
	local txd = engineLoadTXD ( "data/textures/uzi.txd" )
	engineImportTXD ( txd, 352 )
	local dff = engineLoadDFF ( "data/textures/uzi.dff", 352 )
	engineReplaceModel ( dff, 352 )
	-- Rampe
	--[[
	local shad = dxCreateShader("client/fx/stunt.fx")
	if shad then
		dxSetShaderValue(shad, "myTex", dxCreateTexture("client/fx/stunt.png"))
		engineApplyShaderToWorldTexture(shad, "jumptop1_128")
	end	]]
	stuntShader = dxCreateShader ( "client/fx/stuntscroll.fx" )
	stuntShader2 = dxCreateShader ( "client/fx/stuntscroll.fx" )
	stuntShader3 = dxCreateShader ( "client/fx/stuntscroll.fx" )
	local tex = dxCreateTexture ( "client/fx/env3.bmp" )
	local tex2 = dxCreateTexture ( "client/fx/stunt2.bmp" )
	dxSetShaderValue ( stuntShader, "CUSTOMTEX0", tex )
	dxSetShaderValue ( stuntShader2, "CUSTOMTEX0", tex2 )
	local tex = dxCreateTexture ( "client/fx/stunt3.bmp" )
	dxSetShaderValue ( stuntShader3, "CUSTOMTEX0", tex )
	

	
	startTickCount = getTickCount()
	addEventHandler( "onClientRender", root, updateStuntTop )
	local shad = dxCreateShader("client/fx/stunt.fx")
	if shad then
		dxSetShaderValue(shad, "myTex", dxCreateTexture("client/fx/stunt2.png"))
		engineApplyShaderToWorldTexture(shad, "jumpside2_256")
		engineApplyShaderToWorldTexture(shad, "jumpside1_256")
	end
	local shad = dxCreateShader("client/fx/stunt.fx")
	if shad then
		dxSetShaderValue(shad, "myTex", dxCreateTexture("client/fx/carrierdeck.png"))
		engineApplyShaderToWorldTexture(shad, "ws_carrierdeckbase")
	end	
	local shad = dxCreateShader("client/fx/stunt.fx")
	if(shad) then
		dxSetShaderValue(shad, "myTex", dxCreateTexture("data/images/radar.png"))
		engineApplyShaderToWorldTexture(shad, "radardisc")
	end
	-- Billboards --
	local shad = dxCreateShader("client/fx/stunt.fx")
	dxSetShaderValue(shad, "myTex", dxCreateTexture("data/images/billboards/1.jpg"))
	engineApplyShaderToWorldTexture(shad, "heat_02") 
	local shad = dxCreateShader("client/fx/stunt.fx")	
	dxSetShaderValue(shad, "myTex", dxCreateTexture("data/images/billboards/2.jpg"))
	engineApplyShaderToWorldTexture(shad, "bobo_2") 

	engineApplyShaderToWorldTexture(stuntShader, "jumptop1_128" )
	engineApplyShaderToWorldTexture(stuntShader2, "ws_decklines")
	engineApplyShaderToWorldTexture(stuntShader2, "ah_ramp")
	engineApplyShaderToWorldTexture(stuntShader3, "midtrack")
	-- Neon --
	local txd = engineLoadTXD( "data/textures/farben.txd" )
	local dff = engineLoadDFF( "data/textures/neon/greenneon.dff", 2052 )
	local dff2 = engineLoadDFF( "data/textures/neon/redneon.dff", 2053 )
	local dff3 = engineLoadDFF( "data/textures/neon/blueneon.dff", 2054 )
	local dff4 = engineLoadDFF( "data/textures/neon/yellowneon.dff", 2371 )
	local dff6 = engineLoadDFF( "data/textures/neon/whiteneon.dff", 2373 )
	local dff5 = engineLoadDFF( "data/textures/neon/sirene.dff", 2372 )
	 
	engineImportTXD( txd, 2052 )
	engineImportTXD( txd, 2053 )
	engineImportTXD( txd, 2054 )
	engineImportTXD( txd, 2371 )
	engineImportTXD( txd, 2372 )
	engineImportTXD( txd, 2373 ) -- weiss
	engineReplaceModel( dff, 2052 )
	engineReplaceModel( dff2, 2053 )
	engineReplaceModel( dff3, 2054 )
	engineReplaceModel( dff4, 2371 )
	engineReplaceModel( dff5, 2372 )
	engineReplaceModel( dff6, 2373 )
end)

function updateStuntTop()
	-- Valide shader to save bazillions of warnings
	if not isElement( stuntShader ) then return end

	-- Calc how many seconds have passed since uv anim started
	local secondsElapsed = ( getTickCount() - startTickCount ) / 1000

	-- Calc section (0-6) and time (0-1) within the section
	local timeLooped = ( secondsElapsed / 2 ) % 6
	local section = math.floor ( timeLooped )
	local time = timeLooped % 1

	-- Figure out what uv anims to do
	local bScrollLeft = section == 0 or section == 3 or section == 4 or section == 6
	local bWobbleRotate = section == 1 or section == 3 or section == 5 or section == 6
	local bGoneAllZoomy = section == 2 or section == 4 or section == 5 or section == 6

	local u,v = 0, 0
	local angle = 0
	local scale = 1

	-- Do uv anims
	if bScrollLeft then
		u = time
	end
	if bWobbleRotate then
		angle = math.sin(time/2*6.28)/4
	end
	if bGoneAllZoomy then
		scale = math.cos(time*6.28) * 0.5 + 0.5
	end

	-- Apply uv anims
	dxSetShaderValue ( stuntShader, "gUVPosition", u,v );
	dxSetShaderValue ( stuntShader, "gUVRotAngle", angle );
	dxSetShaderValue ( stuntShader, "gUVScale", scale, scale );
	dxSetShaderValue ( stuntShader2, "gUVPosition", u,v );
	dxSetShaderValue ( stuntShader2, "gUVRotAngle", angle );
	dxSetShaderValue ( stuntShader2, "gUVScale", scale, scale );
	dxSetShaderValue ( stuntShader3, "gUVPosition", u,v );
	dxSetShaderValue ( stuntShader3, "gUVRotAngle", angle );
	dxSetShaderValue ( stuntShader3, "gUVScale", scale, scale );
end