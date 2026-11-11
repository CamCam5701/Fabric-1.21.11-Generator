<#include "procedures.java.ftl">
public ${name}Procedure() {
    ${package}.event.PlayerEvents.GEM_DROPPED.register((entity, itemstack) -> {
        <#assign dependenciesCode>
            <@procedureDependenciesCode dependencies, {
                "x": "entity.getX()",
                "y": "entity.getY()",
                "z": "entity.getZ()",
                "world": "entity.level()",
                "entity": "entity",
                "itemstack": "itemstack"
            }/>
        </#assign>
        execute(${dependenciesCode});
        boolean result = eventResult;
        eventResult = true;
        return result;
    });
}
