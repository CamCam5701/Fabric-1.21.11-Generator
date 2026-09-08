<#-- @formatter:off -->
<#function blockTextureRef texture>
    <#assign ref = texture.format("%s:block/%s")>
    <#-- Minecraft 1.21.9+ renamed the old iron chain texture from chain to iron_chain. -->
    <#if ref == "minecraft:block/chain">
        <#return "minecraft:block/iron_chain">
    </#if>
    <#return ref>
</#function>
{
    "parent": "${modid}:custom/${data.customModelName.split(":")[0]}",
    "textures": {
        "all": "${blockTextureRef(data.texture)}",
        "particle": "${blockTextureRef(parent???then(data.getParticleTexture(parent.getParticleTexture()), data.getParticleTexture()))}"
        <#if data.getTextureMap()??>
        <#list data.getTextureMap().entrySet() as texture>,
        "${texture.getKey()}": "${blockTextureRef(texture.getValue())}"
        </#list>
        </#if>
    },
    "render_type": "${(parent???then(parent, data)).getRenderType()}"
}
<#-- @formatter:on -->
