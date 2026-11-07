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
package ${package}.mixin;

@Mixin(Player.class)
public abstract class PlayerMixin {

	@org.spongepowered.asm.mixin.injection.Inject(
		method = "drop(Lnet/minecraft/world/item/ItemStack;Z)Lnet/minecraft/world/entity/item/ItemEntity;",
		at = @At("RETURN")
	)
	private void mcreator$onItemDropped(net.minecraft.world.item.ItemStack itemstack, boolean includeThrower, org.spongepowered.asm.mixin.injection.callback.CallbackInfoReturnable<net.minecraft.world.entity.item.ItemEntity> cir) {
		Player player = (Player) (Object) this;
		if (!player.level().isClientSide() && cir.getReturnValue() != null) {
			${package}.event.PlayerEvents.ITEM_DROPPED.invoker().onItemDropped(player, cir.getReturnValue().getItem());
		}
	}

	@Inject(method = "giveExperiencePoints(I)V", at = @At("HEAD"))
	public void giveExperiencePoints(int amount, CallbackInfo ci) {
		PlayerEvents.XP_CHANGE.invoker().onXpChange((Player) (Object) this, amount);
	}

	@Inject(method = "giveExperienceLevels(I)V", at = @At("HEAD"))
	public void giveExperienceLevels(int amount, CallbackInfo ci) {
		PlayerEvents.LEVEL_CHANGE.invoker().onLevelChange((Player) (Object) this, amount);
	}
}
<#-- @formatter:on -->
