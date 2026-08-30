<#include "mcitems.ftl">
<#assign _source_stack = mappedMCItemToItemStackCode(input$a, 1)>
<#assign _target_stack = mappedMCItemToItemStackCode(input$b, 1)>
{
	final Identifier _targetItemModel = ${_target_stack}.get(DataComponents.ITEM_MODEL);
	<#if (field$ignoredefaults!"FALSE") == "TRUE">
	${_target_stack}.applyComponents(${_source_stack}.getComponentsPatch());
	<#else>
	${_target_stack}.applyComponents(${_source_stack}.getComponents());
	</#if>
	if (_targetItemModel != null)
		${_target_stack}.set(DataComponents.ITEM_MODEL, _targetItemModel);
	else
		${_target_stack}.remove(DataComponents.ITEM_MODEL);
}
