<#--
 # This file is part of Fabric-Generator-MCreator.
 # Copyright (C) 2020-2026, Goldorion, opensource contributors
 #
 # Fabric-Generator-MCreator is free software: you can redistribute it and/or modify
 # it under the terms of the GNU General Public License as published by
 # the Free Software Foundation, either version 3 of the License, or
 # (at your option) any later version.
 #
 # Fabric-Generator-MCreator is distributed in the hope that it will be useful,
 # but WITHOUT ANY WARRANTY; without even the implied warranty of
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
 # along with Fabric-Generator-MCreator. If not, see <https://www.gnu.org/licenses/>.
-->

<#-- @formatter:off -->
package ${package};
import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;
import net.fabricmc.fabric.api.client.networking.v1.ClientPlayNetworking;
import net.fabricmc.loader.api.FabricLoader;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Locale;
import java.util.stream.Stream;

import ${package}.init.*;


@Environment(EnvType.CLIENT) public class ${JavaModName}Client implements ClientModInitializer {

	@Override
	public void onInitializeClient() {
		cleanInvalidDevelopmentResources();

		// Start of user code block mod constructor
		// End of user code block mod constructor

		<@javacompress>
		<#if w.hasJavaModels() || types["specialentities"]??>${JavaModName}Models.clientLoad();</#if>
		<#if types["base:blocks"]??>${JavaModName}Blocks.clientLoad();</#if>
		<#if types["armors"]??>${JavaModName}ArmorModels.clientLoad();</#if>
		<#if w.getGElementsOfType("item")?filter(e -> e.getModels()?filter(a -> a.hasCustomJAVAModel())?has_content || e.hasCustomJAVAModel())?size != 0>${JavaModName}ItemRenderers.clientLoad();</#if>
		<#if w.getGElementsOfType("item")?filter(e -> e.getModels()?has_content)?size != 0>LegacyOverrideSelectItemModel.clientLoad();</#if>
		<#if w.getGElementsOfType("item")?filter(e -> e.customProperties?has_content)?size != 0>${JavaModName}ItemProperties.clientLoad();</#if>
		<#if types["base:entities"]??>${JavaModName}EntityRenderers.clientLoad();</#if>
		<#if types["particles"]??>${JavaModName}Particles.clientLoad();</#if>
		<#if types["fluids"]??>${JavaModName}Fluids.clientLoad();</#if>
		<#if types["guis"]??>
		${JavaModName}Screens.clientLoad();
		${JavaModName}Menus.clientLoad();
		</#if>
		<#if types["overlays"]??>${JavaModName}Overlays.clientLoad();</#if>
		<#if w.getGElementsOfType("command")?filter(e -> e.type == "CLIENTSIDE")?size != 0>${JavaModName}Commands.clientLoad();</#if>
		<#if types["keybinds"]??>${JavaModName}KeyMappings.clientLoad();</#if>
		<#if w.getGElementsOfType('dimension')?filter(e -> e.enableCustomSkyboxTextures || e.enableCustomSunMoonTextures)?size != 0>${JavaModName}SkyboxRenderer.renderSky();</#if>
		</@javacompress>

		<#if w.hasVariablesOfScope("GLOBAL_WORLD") || w.hasVariablesOfScope("GLOBAL_MAP")>
			ClientPlayNetworking.registerGlobalReceiver(${JavaModName}Variables.SavedDataSyncMessage.TYPE, ${JavaModName}Variables.SavedDataSyncMessage::handleData);
		</#if>

		<#if w.hasVariablesOfScope("PLAYER_LIFETIME") || w.hasVariablesOfScope("PLAYER_PERSISTENT")>
			ClientPlayNetworking.registerGlobalReceiver(${JavaModName}Variables.PlayerVariablesSyncMessage.TYPE, ${JavaModName}Variables.PlayerVariablesSyncMessage::handleData);
		</#if>

		// Start of user code block mod init
		// End of user code block mod init
	}

	private static void cleanInvalidDevelopmentResources() {
		FabricLoader loader = FabricLoader.getInstance();
		if (!loader.isDevelopmentEnvironment())
			return;

		loader.getModContainer("${modid}").ifPresent(container -> {
			for (Path root : container.getRootPaths()) {
				try {
					if (!Files.isDirectory(root))
						continue;

					String rootName = root.toAbsolutePath().normalize().toString().replace('\\', '/').toLowerCase(Locale.ROOT);

					// Never modify source assets. Loom normally exposes build/resources/main
					// as the resource root in a Gradle development run.
					if (rootName.contains("/src/"))
						continue;

					try (Stream<Path> paths = Files.walk(root)) {
						paths.filter(Files::isRegularFile).forEach(path -> {
							String relative = root.relativize(path).toString().replace('\\', '/');
							String lower = relative.toLowerCase(Locale.ROOT);

							if (relative.contains(" ") || lower.endsWith(".lnk")) {
								try {
									if (Files.deleteIfExists(path))
										System.out.println("[MCreator/Fabric 1.21.11] Ignored invalid development resource: " + relative);
								} catch (IOException ignored) {
								}
							}
						});
					}
				} catch (IOException ignored) {
				}
			}
		});
	}

	// Start of user code block mod methods
	// End of user code block mod methods
}
<#-- @formatter:on -->
