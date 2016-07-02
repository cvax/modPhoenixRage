function StringDefinitionToEnum( s : string ) : name
{
	switch(s)
	{
		// In geralt_skills.xml, you must set the "group_name" and "group_var" attributes.
		// These attributes should be named how they are named in your custom mod menu xml.
		// Make sure to provide all string-to-name conversions below.

		// Ex:
		// case "CustomSkillGroupID"	: return 'CustomSkillGroupID';		// group_name
		// case "customSkillEnabled"	: return 'customSkillEnabled';		// group_var

		case "PhoenixRage"		: return 'PhoenixRage';		// group_name
		case "phxRageEnabled"	: return 'phxRageEnabled';	// group_var for enable
		case "maxHealthReq"		: return 'maxHealthReq';	// arg_int_var1
		case "adrenCost"		: return 'adrenCost';		// arg_int_var2

		default					: return '';
	}
}