/*-------------------------------------------------------------------
					Made by Fearless Captain. 
-------------------------------------------------------------------*/
 
/*-------------------------------------------------------------------
	This product has lifetime support and updates.

	Need support? How my coding? Contact Fearless Captain at any time:
	http://steamcommunity.com/id/FearlessCaptain/
-------------------------------------------------------------------*/

/*-------------------------------------------------------------------

					A note about performance:
	The entire HUD has about a 2 fps impact. The 3d model in the HUD 
	has about a 4 - 8 fps impact, depending on the player model and 
	computer power. On the worst laptop I could find that still ran
	GMod it had a 2 fps impact (from 35 fps to 33 fps). The Steam Avatar
	option and the custom png option both have no impact. 
	
-------------------------------------------------------------------*/

-- I added _Conf to the end of these just incase some other addon messes just happens 
-- to have the same variable.

-- Enable this if you use a special hunger mod that has it's own special meter
-- or you want have the default DarkRP hunger mod on but don't want your players
-- to see the UI for it for whaterver reason.
SpecialHungerMod_Conf = false

-- Set this to 1 (the default) for the players model, 2 for player's steam avatar,
-- 3 for a custom png, 0 for nothing (ugly).
ShowHUDModel_Conf = 1
-- Either overwrite the .png in the material/custom folder or change this to
-- your new one. The new one should be 56x56 pixels. 
ShowHUDModelCustomPNG_Conf = "custom/customimage.png" -- default image

-- Incase you think the defaul font (Exocet Light) is unreadable here is a way to 
-- change it.
-- Default is "JobFont_14" 
-- Options you can choose from by deafult are here: https://wiki.garrysmod.com/page/Default_Fonts

AgendaFont_Conf = "JobFont_14"




