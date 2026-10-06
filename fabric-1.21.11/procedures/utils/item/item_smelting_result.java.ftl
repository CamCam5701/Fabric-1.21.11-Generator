private static ItemStack getItemStackSmeltingResult(LevelAccessor level, ItemStack input) {
    SingleRecipeInput recipeInput = new SingleRecipeInput(input);
    if (level instanceof ServerLevel serverLevel) {
        HolderLookup.Provider registries = serverLevel.registryAccess();
        return serverLevel.recipeAccess()
                .getRecipeFor(RecipeType.SMELTING, recipeInput, serverLevel)
                .map(recipe -> recipe.value().assemble(recipeInput, registries).copy())
                .orElse(ItemStack.EMPTY);
    }
    return ItemStack.EMPTY;
}
