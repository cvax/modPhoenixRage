class PhxRage
{
	public function SetActionForKeyBinding()
	{
		// Unfortunately registering CastSign to try and reduce a keybind results in it being completely overwritten
		theInput.RegisterListener( this, 'OnPressButton', 'PhoenixRage' );
		theInput.RegisterListener( this, 'OnPressButton', 'PhoenixRageModifier' );
	}

	event OnPressButton (action : SInputAction)
	{
		var healthReq : float;
		var drainFocus : float;
		var stamCost : float;
		
		healthReq = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PhoenixRage', 'maxHealthReq')) / 100;
		drainFocus = StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PhoenixRage', 'adrenCost'));
		stamCost = thePlayer.GetStatMax(BCS_Stamina) * (StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PhoenixRage', 'stamCost')) / 100);

		if (thePlayer.GetSkillLevel(S_Magic_s26) == 2)
		{
			healthReq = MinF(healthReq * 2, 1);
			drainFocus = MaxF(drainFocus - 1, 0);
			stamCost = MaxF((thePlayer.GetStatMax(BCS_Stamina) * (StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PhoenixRage', 'stamCost')) / 100)) / 2, 0);
		}
		else if (thePlayer.GetSkillLevel(S_Magic_s26) == 3)
		{
			healthReq = MinF(healthReq * 3, 1);
			drainFocus = MaxF(drainFocus - 2, 0);
			stamCost = MaxF((thePlayer.GetStatMax(BCS_Stamina) * (StringToFloat(theGame.GetInGameConfigWrapper().GetVarValue('PhoenixRage', 'stamCost')) / 100)) / 3, 0);
		}
			
		if (theInput.IsActionPressed('PhoenixRageModifier'))
		{
			if (action.aName == 'PhoenixRage')
			{
				thePlayer.BlockAction(EIAB_Signs, SkillEnumToName(S_Magic_s26));

				//theGame.GetGuiManager().ShowNotification("Hello: " + thePlayer.CanUseSkill(S_Magic_s26));
				//theGame.GetGuiManager().ShowNotification( "Health: " + thePlayer.GetHealthPercents() + " Focus: " + thePlayer.GetStat(BCS_Focus) + " Stamina: " + thePlayer.GetStat(BCS_Stamina));
				//GetWitcherPlayer().DisplayHudMessage( "Req Health: " + healthReq + " Foc: " + drainFocus + " Stam: " + stamCost );
				if (IsPressed (action)
					&& thePlayer.GetEquippedSign() == ST_Igni
					&& thePlayer.CanUseSkill(S_Magic_s26)
					&& thePlayer.GetHealthPercents() <= healthReq
					&& thePlayer.GetStat(BCS_Focus) >= drainFocus
					&& thePlayer.GetStat(BCS_Stamina) >= stamCost)
				{
					thePlayer.PhoenixRage();
					thePlayer.DrainFocus(drainFocus);
					thePlayer.DrainStamina(ESAT_FixedValue, stamCost, 0, SkillEnumToName(S_Magic_s26));
				}
				else if (IsReleased (action))
					thePlayer.UnblockAction(EIAB_Signs, SkillEnumToName(S_Magic_s26));
			}
		}
	}

	// Double click attempt. Engine Time seems to slow down randomly preventing skill from triggering
	/*public function SetActionForKeyBinding()
	{
		theInput.RegisterListener( this, 'OnPressButton', 'PhoenixRage' );
	}

	private var pressTimestamp : float;
	private var pressTimestamp2 : float;

	event OnPressButton (action : SInputAction)
	{
		// cvax: Timestamp check needed to differentiate pressing to reload vs holding to disable ULM
		if (action.aName == 'PhoenixRage')
		{
			if (IsPressed (action))
			{
				if (pressTimestamp == 0)
					pressTimestamp = theGame.GetEngineTimeAsSeconds();
				else
					pressTimestamp2 = theGame.GetEngineTimeAsSeconds();
			}
			else if (IsReleased(action) && pressTimestamp != 0 && pressTimestamp2 != 0)
			{
				if (pressTimestamp >= pressTimestamp2 - 0.5)
					thePlayer.SetSelectedItemId();

				theGame.GetGuiManager().ShowNotification( "Reset: " + pressTimestamp + " " + pressTimestamp2);
				pressTimestamp = 0;
				pressTimestamp2 = 0;
			}
		}
	}*/
}