<#include "procedures.java.ftl">
public ${name}Procedure() {
	net.fabricmc.fabric.api.event.lifecycle.v1.ServerWorldEvents.UNLOAD.register((server, world) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
			"world": "world"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}
