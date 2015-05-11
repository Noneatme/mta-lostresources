addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		local ver = getVersion ().sortable
		local type = string.sub( ver, 7, 7 )
		local build = string.sub( ver, 9, 13 )
		if build < "02888" and type ~= "1" or ver < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			outputChatBox( "Please get latest 1.1 nightly from nightly.mtasa.com" )
			return
		end

		-- Create shader
		local myShader, tec = dxCreateShader ( "shaders/shader_carpaint/car_paint.fx" )

		if not myShader then
			outputChatBox( "Could not create shader. Please use debugscript 3" )
		else

			-- Set textures
			local textureVol = dxCreateTexture ( "shaders/shader_carpaint/images/smallnoise3d.dds" );
			local textureCube = dxCreateTexture ( "shaders/shader_carpaint/images/cube_env256.dds" );
			dxSetShaderValue ( myShader, "microflakeNMapVol_Tex", textureVol );
			dxSetShaderValue ( myShader, "showroomMapCube_Tex", textureCube );

			-- Apply to world texture
			engineApplyShaderToWorldTexture ( myShader, "vehiclegrunge256" )
		end
	end
)
