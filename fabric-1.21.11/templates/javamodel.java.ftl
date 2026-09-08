<#--
 # This file is based on MCreator's NeoForge 1.21.8 Java model conversion template.
 # It is included here because MCreator 2026.2 no longer ships the 1.21.8 generator,
 # while Minecraft 1.21.11 still uses the render-state Java model format.
-->

<#-- @formatter:off -->
package ${package}.client.model;

${model
?replace("private final ModelPart", "public final ModelPart")
?replace("new Identifier\\(\"(.*?)\", \"(.*?)\"\\)", "Identifier.fromNamespaceAndPath(\"" + modid + "\", \"" + modelregistryname + "\")", "r")
?replace("Identifier.fromNamespaceAndPath\\(\"(.*?)\", \"(.*?)\"\\)", "Identifier.fromNamespaceAndPath(\"" + modid + "\", \"" + modelregistryname + "\")", "r")
?replace("new ResourceLocation\\(\"(.*?)\", \"(.*?)\"\\)", "Identifier.fromNamespaceAndPath(\"" + modid + "\", \"" + modelregistryname + "\")", "r")
?replace("ResourceLocation.fromNamespaceAndPath\\(\"(.*?)\", \"(.*?)\"\\)", "Identifier.fromNamespaceAndPath(\"" + modid + "\", \"" + modelregistryname + "\")", "r")
?replace("float\\s+red,\\s+float\\s+green,\\s+float\\s+blue,\\s+float\\s+alpha", "int rgb", "r")
?replace("red,\\s+green,\\s+blue,\\s+alpha", "rgb", "r")
?replace("void setupAnim(Entity ", "void setupAnim(T ")
?replace("@Override", "")
?replace("public\\s+void\\s+renderToBuffer\\((.*?)}", "", "rms")
?replace("<T\\s+extends\\s+(.*?)>", "", "r")
?replace("<T>", "<LivingEntityRenderState>", "")
?replace("root\\)\\s+\\{", "root) {super(root);", "r")
?replace("void setupAnim\\(T(.*?)\\{", "void setupAnim(LivingEntityRenderState state) {\n\t\tfloat limbSwing = state.walkAnimationPos;\n\t\tfloat limbSwingAmount = state.walkAnimationSpeed;\n\t\tfloat ageInTicks = state.ageInTicks;\n\t\tfloat netHeadYaw = state.yRot;\n\t\tfloat headPitch = state.xRot;\n", "rms")
}
<#-- @formatter:on -->
