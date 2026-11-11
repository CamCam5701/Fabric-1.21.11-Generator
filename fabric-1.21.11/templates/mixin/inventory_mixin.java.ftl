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

@Mixin(Inventory.class)
public abstract class InventoryMixin {
    @Shadow @Final public Player player;
    @Shadow public abstract ItemStack getSelectedItem();

    // The vanilla inventory removes the held item before Player.drop(ItemStack, boolean).
    // Cancel here to keep the stack in its original slot instead of deleting it.
    @Inject(method = "removeFromSelected(Z)Lnet/minecraft/world/item/ItemStack;", at = @At("HEAD"), cancellable = true)
    private void mcreator$beforeItemDropped(boolean entireStack, CallbackInfoReturnable<ItemStack> cir) {
        if (this.player.level().isClientSide())
            return;
        ItemStack selected = this.getSelectedItem();
        if (selected.isEmpty())
            return;
        ItemStack dropped = selected.copy();
        if (!entireStack)
            dropped.setCount(1);
        if (!${package}.event.PlayerEvents.GEM_DROPPED.invoker().onGemDropped(this.player, dropped)) {
            // Client-side Q/Ctrl+Q predicts the item removal immediately. The server has
            // canceled that removal, so explicitly restore the unchanged hotbar slot on
            // the client. Do not notify for successful drops or client-side execution.
            if (this.player instanceof net.minecraft.server.level.ServerPlayer serverPlayer) {
                net.minecraft.world.entity.player.Inventory inventory = serverPlayer.getInventory();
                serverPlayer.connection.send(inventory.createInventoryUpdatePacket(inventory.getSelectedSlot()));
            }
            cir.setReturnValue(ItemStack.EMPTY);
        }
    }
}
<#-- @formatter:on -->
