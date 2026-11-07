<#-- @formatter:off -->
package ${package}.mixin;

import net.minecraft.nbt.NbtAccounter;
import net.minecraft.world.level.storage.LevelStorageSource;

import org.spongepowered.asm.mixin.Mixin;
import org.spongepowered.asm.mixin.injection.At;
import org.spongepowered.asm.mixin.injection.ModifyArg;

@Mixin(LevelStorageSource.class)
public class LevelStorageSourceMixin {
    @ModifyArg(
        method = "readLevelDataTagRaw",
        at = @At(
            value = "INVOKE",
            target = "Lnet/minecraft/nbt/NbtIo;readCompressed(Ljava/nio/file/Path;Lnet/minecraft/nbt/NbtAccounter;)Lnet/minecraft/nbt/CompoundTag;"
        ),
        index = 1
    )
    private static NbtAccounter increaseSavedDataQuota(NbtAccounter originalAccounter) {
        return NbtAccounter.unlimitedHeap();
    }
}
<#-- @formatter:on -->
