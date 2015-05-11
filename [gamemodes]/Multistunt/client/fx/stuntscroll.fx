///////////////////////////////////////////////////////////////////////////////
// Global variables
///////////////////////////////////////////////////////////////////////////////
texture gOrigTexure0 : TEXTURE0;
texture gCustomTex0 : CUSTOMTEX0;

float2 gUVPrePosition = float2( 0, 0 );
float2 gUVScale = float( 1 );                     // UV scale
float2 gUVScaleCenter = float2( 0.5, 0.5 );
float gUVRotAngle = float( 0 );                   // UV Rotation
float2 gUVRotCenter = float2( 0.5, 0.5 );
float2 gUVPosition = float2( 0, 0 );              // UV position

//
// tex_matrix.fx
//


//-------------------------------------------
// Returns a translation matrix
//-------------------------------------------
float3x3 makeTranslationMatrix ( float2 pos )
{
    return float3x3(
                    1, 0, 0,
                    0, 1, 0,
                    pos.x, pos.y, 1
                    );
}


//-------------------------------------------
// Returns a rotation matrix
//-------------------------------------------
float3x3 makeRotationMatrix ( float angle )
{
    float s = sin(angle);
    float c = cos(angle);
    return float3x3(
                    c, s, 0,
                    -s, c, 0,
                    0, 0, 1
                    );
}


//-------------------------------------------
// Returns a scale matrix
//-------------------------------------------
float3x3 makeScaleMatrix ( float2 scale )
{
    return float3x3(
                    scale.x, 0, 0,
                    0, scale.y, 0,
                    0, 0, 1
                    );
}


//-------------------------------------------
// Returns a combined matrix of doom
//-------------------------------------------
float gTime : TIME;

float3x3 makeTextureTransform ( float2 prePosition, float2 scale, float2 scaleCenter, float rotAngle, float2 rotCenter, float2 postPosition )
{
    float posU = 0;
    float posV = fmod( gTime ,1 );

    return float3x3(
                    1, 0, 0,
                    0, 1, 0,
                    posU, posV, 1
                    );
}

///////////////////////////////////////////////////////////////////////////////
// Functions
///////////////////////////////////////////////////////////////////////////////


//-------------------------------------------
// Returns UV transform using external settings
//-------------------------------------------
float3x3 getTextureTransform()
{
    return makeTextureTransform( gUVPrePosition, gUVScale, gUVScaleCenter, gUVRotAngle, gUVRotCenter, gUVPosition );
}


///////////////////////////////////////////////////////////////////////////////
// Techniques
///////////////////////////////////////////////////////////////////////////////
technique hello
{
    pass P0
    {
        // Set the texture
        Texture[0] = gCustomTex0;       // Use custom texture

        // Set the UV thingy
        TextureTransform[0] = getTextureTransform();

        // Enable UV thingy
        TextureTransformFlags[0] = Count2;
    }
}
