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
<#include "../procedures.java.ftl">

package ${package}.mixin;

@Mixin(ServerPlayer.class)
public abstract class ServerPlayerMixin {
	@com.llamalad7.mixinextras.injector.ModifyExpressionValue(
		method = "drop(Z)V",
		at = @At(
			value = "INVOKE",
			target = "Lnet/minecraft/world/entity/player/Inventory;removeFromSelected(Z)Lnet/minecraft/world/item/ItemStack;"
		)
	)
	private ItemStack mcreator$onDropSelectedItem(ItemStack itemstack) {
		ServerPlayer self = (ServerPlayer) (Object) this;

		<#list items as item>
			<#if item.getModElement().getTypeString() == "item">
				<#if hasProcedure(item.onDroppedByPlayer)>
					if (itemstack.getItem() instanceof ${item.getModElement().getName()}Item)
						((${item.getModElement().getName()}Item)itemstack.getItem()).onDroppedByPlayer(itemstack, self);
				</#if>
			</#if>
		</#list>

		// Return Minecraft's already-removed stack unchanged.
		// Vanilla ServerPlayer.drop(boolean) performs the actual drop exactly once.
		return itemstack;
	}
}
<#-- @formatter:on -->
