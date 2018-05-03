addEventHandler ( "onClientResourceStart", resourceRoot,
    function ( )
        local texture = dxCreateTexture ( "images/vehiclepoldecals128.png", "dxt5" )
        local shader = dxCreateShader ( "texture.fx" )
        dxSetShaderValue ( shader, "gTexture", texture )
        engineApplyShaderToWorldTexture ( shader, "vehiclepoldecals128" )

        local texture2 = dxCreateTexture ( "images/coronastar.png", "dxt5" )
        local shader2 = dxCreateShader ( "texture.fx" )
        dxSetShaderValue ( shader2, "gTexture", texture2 )
        engineApplyShaderToWorldTexture ( shader2, "coronastar" )

        --local texture3 = dxCreateTexture ( "images/headlight.png", "dxt5" )
        --local shader3 = dxCreateShader ( "texture.fx" )
        --dxSetShaderValue ( shader3, "gTexture", texture3 )
        --engineApplyShaderToWorldTexture ( shader3, "headlight" )

        --local texture4 = dxCreateTexture ( "images/headlight1.png", "dxt5" )
        --local shader4 = dxCreateShader ( "texture.fx" )
        --dxSetShaderValue ( shader4, "gTexture", texture4 )
        --engineApplyShaderToWorldTexture ( shader4, "headlight1" )

        local texture3 = dxCreateTexture ( "images/font2.png", "dxt5" )
        local shader3 = dxCreateShader ( "texture.fx" )
        dxSetShaderValue ( shader3, "gTexture", texture3 )
        engineApplyShaderToWorldTexture ( shader3, "font2" )

        local texture5 = dxCreateTexture ( "images/CJ_PAINTING3.png", "dxt5" )
        local shader5 = dxCreateShader ( "texture.fx" )
        dxSetShaderValue ( shader5, "gTexture", texture5 )
        engineApplyShaderToWorldTexture ( shader5, "CJ_PAINTING3" )


    end
)