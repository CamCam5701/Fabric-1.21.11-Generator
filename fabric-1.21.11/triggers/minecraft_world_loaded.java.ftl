<#include "procedures.java.ftl">
public ${name}Procedure() {
	ServerLifecycleEvents.SERVER_STARTED.register((server) -> {
		<#assign dependenciesCode>
			<@procedureDependenciesCode dependencies, {
			"world": "server.overworld()"
			}/>
		</#assign>
		execute(${dependenciesCode});
	});
}
