-- Diablo 3 DarkRP HUD! Made by Fearless Captain 
-- Version 0.02

-- Only runs the ui if it is darkrp. I didn't tab everything over because I am lazy.
if GAMEMODE_NAME == "DarkRP" or "darkrp" then 


-- Creates a convar (console variable) to disable/enable the ui.
local d3uiHUDEnable = CreateClientConVar( "d3uiHUD_enable", "1", true, true )


-- Caches the textures in memory. It's bad to fetch the textures over and over again every single frame.
-- VMT files have to be used for images that have ditherd, smooth edges that fade to transparency.
-- PNGs will have some white spots instead of transparent on the edges. Don't know why but they do.
local healthOverlayTex = Material( "d3hb/d3health", "nocull smooth" ) 		-- VMT
local OverlayGoop = Material( "d3hb/d3healthgoop.png", "nocull smooth" )	-- PNG

local armorOverlayTex = Material( "d3hb/d3armor", "nocull smooth" )
local armorGoop = Material( "d3hb/d3armorgoop.png", "nocull smooth" )

local infoOverlay = Material( "d3hb/d3info", "nocull smooth" )
local infoRadar = Material( "d3hb/d3radar.png", "nocull smooth" )
local infoHunger = Material( "d3hb/d3hunger.png", "nocull smooth" )

local infoAgenda = Material( "d3hb/d3agenda", "nocull smooth" )


 -- Precache fonts
surface.CreateFont( "MoneyFont_14", {
	font = "Exocet Light", 
	size = 14,
	weight = 500,
	blursize = 0,
	scanlines = 0,
} )

surface.CreateFont( "MoneyFont_12", {
	font = "Exocet Light", 
	size = 10,
	weight = 500,
	blursize = 0,
	scanlines = 0,
} )

surface.CreateFont( "WeaponFont", {
	font = "Exocet Light", 
	size = 14,
	weight = 500,
	blursize = 0,
	scanlines = 0,
} )

surface.CreateFont( "WeaponFont_Small", {
	font = "Exocet Light", 
	size = 10,
	weight = 500,
	blursize = 0,
	scanlines = 0,
} )

surface.CreateFont( "WeaponFont_Extra_Small", {
	font = "Exocet Light", 
	size = 8,
	weight = 500,
	blursize = 0,
	scanlines = 0,
} )

surface.CreateFont( "AmmoFont", {
	font = "Exocet Light", 
	size = 25,
	weight = 500,
	blursize = 0,
	scanlines = 0,
} )

surface.CreateFont( "JobFont_24", {
	font = "Exocet Light", 
	size = 24,
	weight = 500,
	blursize = 0,
	scanlines = 0,
} )

surface.CreateFont( "JobFont_18", {
	font = "Exocet Light", 
	size = 18,
	weight = 500,
	blursize = 0,
	scanlines = 0,
} )

surface.CreateFont( "JobFont_14", {
	font = "Exocet Light", 
	size = 14,
	weight = 500,
	blursize = 0,
	scanlines = 0,
} )

surface.CreateFont( "JobFont_10", {
	font = "Exocet Light", 
	size = 10,
	weight = 500,
	blursize = 0,
	scanlines = 0,
} )

surface.CreateFont( "JobFont_8", {
	font = "Exocet Light", 
	size = 8,
	weight = 500,
	blursize = 0,
	scanlines = 0,
} )

/*-------------------------------------------------------------------
	This hook draws Health and Armor.
-------------------------------------------------------------------*/

-- These have to be set outside the hook so they don't override everytime.
local hpsmoothing = 0
local arsmoothing = 0

hook.Add( "HUDPaint", "HUDDiabloHealth", function()
	
	if d3uiHUDEnable:GetBool() == false then return end
	

	local ply = LocalPlayer()
	local hp = ply:Health()
	local ar = ply:Armor()
	
	if hp > 100 then 
		draw.RoundedBox( 5, 15, ScrH() - 185, 120, 17, Color( 34, 34, 34, 100 ) )
		draw.SimpleText( "You have ".. hp .." health." , "DermaDefault", 24, ScrH() - 185, Color( 255, 255, 255, 255 ) )
	end
	
	-- This is where the smoothing magic happens. 
	hpsmoothing = math.Approach( hpsmoothing, hp, 70 * FrameTime())
	arsmoothing = math.Approach( arsmoothing, ar, 70 * FrameTime())
	
	-- The size of the goop that will be scissor rect'd.
	local w = 256
	local h = 256
	
	-- used for pos of goop and overlay.
	local y = ScrH() - h
	local z = ScrW() - w
	
	-- Sets the number to somethine like 0.0433 usually 
	local HPmath = 1 - math.Clamp( hpsmoothing / 100, 0, 1)
		
	local goopW,goopH = 152.5,148
	local goopX,goopY = 92, y + 93.5
	
	-- Then the scissor rect moves to the outside of the goop, or cutting the top off.
	render.SetScissorRect( goopX, goopY + ( goopW * HPmath ), goopX + goopW, goopY + goopW, true ) // Sets a scissor rect; anything outside of it is cut off
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( OverlayGoop )
		surface.DrawTexturedRect( goopX, goopY, goopW, goopH )
	render.SetScissorRect( 0, 0, 0, 0, false ) -- Has to be reset after. 

	-- The overlay overtop of the goop.
	surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( healthOverlayTex )
	surface.DrawTexturedRect( 0, y, w, h )
	
	-- Hides the armor meter if you have no Armor 
	if ar < 1 then return end
	
	-- This is all the same as the health above but moved to the other side of the screen.
	local ARmath = 1 - math.Clamp( arsmoothing / 100, 0, 1)
	
	local goopW,goopH = 155, 155
	local goopX,goopY = z + 10, y + 89
	
	
	render.SetScissorRect( goopX, goopY + ( goopW * ARmath ), goopX + goopW, goopY + goopW, true ) // Sets a scissor rect; anything outside of it is cut off
		surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( armorGoop )
		surface.DrawTexturedRect( goopX, goopY, goopW, goopH )
	render.SetScissorRect( 0, 0, 0, 0, false )
	
	
	surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( armorOverlayTex )
	surface.DrawTexturedRect( z, y, w, h )
	
	
end )

/*-------------------------------------------------------------------
	This is DarkRP info, ammo, ect.
-------------------------------------------------------------------*/

hook.Add( "HUDPaint", "!HUDDiablo", function()
	
	-- if 1 == 1 then return end
	
-- local function DiabloInfoHUD ()
	if d3uiHUDEnable:GetBool() == false then return end
	
	local ply = LocalPlayer()
	
	local w = 512
	local h = 256
	
	local g = ScrW() / 2 
	
	local y = ScrH() - h + 130
	local z = ScrW() - 256 - g
	
	-- info hud render
	surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( infoOverlay )
	surface.DrawTexturedRect( z, y, w , h )
	
	-- gets the players ammo count and current weapon 
	-- Checks here to see if the player is alive. It also checks if to ammo is valid to avoid error spam
	if ply:Alive() and ply:GetActiveWeapon().Clip1 and ply:GetActiveWeapon().GetPrimaryAmmoType then 
		local wep = ply:GetActiveWeapon()
		local wepAmmo = ply:GetAmmoCount( wep:GetPrimaryAmmoType() )
		local wepClip1 = wep:Clip1()
		local wepClip1Size = 0
		
		if wep.Primary && wep.Primary.ClipSize then
			wepClip1Size = wep.Primary.ClipSize or 0
		else
			wepClip1Size = wepAmmo
		end 
		
		
		local weaponName = ""
		if IsValid(wep) then
			if wep:IsScripted() then
				weaponName =  wep.PrintName or ""
			else
				weaponName = wep:GetClass()
			end
		else 
			weaponName = "not valid" 
		end
		
		-- avoids long gross HL2 names on guns
		if weaponName == "weapon_physcannon" then weaponName = "Gravity Gun" end 
		if weaponName == "weapon_physgun" then weaponName = "Physgun" end
		
		local x = 293
		if wepClip1 > 99 then x = 289 end
		if wepClip1 < 10 then x = 300 end 
		
		local xx = 355
		if wepAmmo > 99 then xx = 347 end
		if wepAmmo < 10 then xx = 359 end 
		
		
		-- avoids ugly -1 in the ammo counter
		if wepClip1 == -1 or wepClip1 < 0 or weaponName == "Gravity Gun" then wepClip1 = "∞" wepAmmo = "∞" end
		
		-- tries to avoid very long weapon names spilling over the side of the ui. 
		-- I could make this a dynamicly updating 2d3d thing at somepoint.
		local weaponNameFont = "WeaponFont"
		if string.len( weaponName ) > 16 then weaponNameFont = "WeaponFont_Extra_Small" elseif string.len( weaponName ) > 12 then weaponNameFont = "WeaponFont_Small" end 
		
		
		draw.SimpleText( weaponName , weaponNameFont, z + 339 , y + 53, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER  )
		draw.SimpleText( wepClip1 .. " | " .. wepAmmo , "AmmoFont", z + 339  , y + 72, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER  )
		-- draw.SimpleText( "|"  , "AmmoFont", z + 334 , y + 71, Color( 255, 255, 255, 255 ) )
		-- draw.SimpleText( wepAmmo , "AmmoFont", z + xx , y + 73, Color( 255, 255, 255, 255 ) )
		
	end
	
	-- gets and draws the players darkrp money
	draw.SimpleText( string.sub( DarkRP.getPhrase("salary", DarkRP.formatMoney(ply:getDarkRPVar("salary")), ""), 9 ), MoneyFont_14, z + 22 , y + 55, Color( 255, 255, 255, 255 ) )
	draw.SimpleText( string.sub( DarkRP.getPhrase("wallet", DarkRP.formatMoney(ply:getDarkRPVar("money")), ""), 9 ), MoneyFont_14, z + 20 , y + 82, Color( 255, 255, 255, 255 ) )
	
	-- gets and draws the players job 
	darkrpJob = ply:getDarkRPVar("job")
	JobFont = "JobFont_24"
	
	if string.len( darkrpJob ) > 18 then JobFont = "JobFont_8" elseif  string.len( darkrpJob ) > 15 then JobFont = "JobFont_10" elseif string.len( darkrpJob ) > 10 then JobFont = "JobFont_14" elseif string.len( darkrpJob ) > 8 then JobFont = "JobFont_18" end

	draw.SimpleText( darkrpJob, JobFont, z + 205 , y + 52, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER  )
	
	-- gets and draws the player count of the server
	-- the # takes the returned table and makes it a number
	draw.SimpleText( #player.GetAll() .. "  /  " .. game.MaxPlayers(), "AmmoFont", z + 205, y + 73, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER )
	
end )

/*-------------------------------------------------------------------
	This was is going to be a radar function. I put it here because 
	I might do something fancy. Now it's just hunger. 
-------------------------------------------------------------------*/

hook.Add( "HUDPaint", "zHUDRadar", function()
	
	if d3uiHUDEnable:GetBool() == false then return end
	
	local w = 512
	local h = 256
	
	local g = ScrW() / 2 
	
	local y = ScrH() - h + 130
	local x = ScrW() - 256 - g
	
	if SpecialHungerMod == false then
		local nrg = LocalPlayer():getDarkRPVar("Energy")
		if nrg != nil then
			
			local HungerMath = (( math.Clamp( LocalPlayer():getDarkRPVar("Energy") / 100, 0, 1) ) * 472 ) + x

			-- Radar render
			render.SetScissorRect( x, y + 32, HungerMath, y + 40, true )
			-- draw.RoundedBox( 0, 0, 0, ScrW(), ScrH(), color_black )

				surface.SetDrawColor( 255, 255, 255, 255 )
					surface.SetMaterial( infoRadar )
				surface.DrawTexturedRect( x + 3, y + 32, 469 , 8 )
			render.SetScissorRect( 0, 0, 0, 0, false )
			
			-- draw hunger bread
			surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( infoHunger )
			surface.DrawTexturedRect( HungerMath - 13, y + 24  , 164 / 6 , 140 / 6 )

		else

			surface.SetDrawColor( 255, 255, 255, 255 )
				surface.SetMaterial( infoRadar )
			surface.DrawTexturedRect( x + 3, y + 32, 469 , 8 )

		end 
	else 
	
		surface.SetDrawColor( 255, 255, 255, 255 )
			surface.SetMaterial( infoRadar )
		surface.DrawTexturedRect( x + 3, y + 32, 469 , 8 )

	end 
	
end)
	

/*-------------------------------------------------------------------
	Shows the player's avatar in the UI. Neat!
-------------------------------------------------------------------*/

-- Put this is in a seperate function. It's part of the hud.
function GenerateView(Panel,Two)
		-- Thanks gmod wiki
        if !Panel.Entity or !Panel.Entity:IsValid() then return end
       
        local eyepos = Panel.Entity:GetBonePosition( Panel.Entity:LookupBone( "ValveBiped.Bip01_Head1" ) )
        eyepos:Add( Vector( 0, 0, 2 ) ) -- Move up slightly
        Panel:SetLookAt( eyepos )
        Panel:SetCamPos( eyepos-Vector( -15, 0, 0 ) )   -- Move cam in front of eyes
        Panel.Entity:SetEyeTarget( eyepos-Vector( -12, 0, 0 ) )   
end

CustomImage = Material( ShowHUDModelCustomPNG_Conf ),
hook.Add( "InitPostEntity", "HUDLittleGuy", function()
	
	if d3uiHUDEnable:GetBool() == false then return end

	h = ScrH() - 92
	w = ScrW() / 2 + 148
	local panel = vgui.Create( "DPanel" )
	panel:ParentToHUD()
	panel:SetPos( w, h )
	-- panel:SetPos( 0, 0 )
	panel:SetSize( 70, 70 )
	panel:SetBackgroundColor( Color( 0, 0, 0, 0 ) )
	
	-- 3D player model 
	if ShowHUDModel_Conf == 1 then
		
		local PlyModel = vgui.Create( "DModelPanel", panel )
		
		-- Thanks Jackool
		local lastModel =  ""
		PlyModel.Think = function(self)
			local curModel = LocalPlayer():GetModel()
			
			-- local wep = LocalPlayer():GetActiveWeapon() -- Leaving this here incase I want to change this to weapon view later. Would take some annoying diddling with view angles.
			-- curModel =  wep.WorldModel or ""
			
			if curModel != lastModel then
				lastModel = curModel
				self:SetModel(curModel)
				GenerateView(self)
			end
		end
		
		PlyModel:SetPos(0,0)
		PlyModel:SetSize( 70, 70 )
		function PlyModel:LayoutEntity( Entity ) return end -- tw guy on 
	end
	
	-- Shows the players Steam Avatar in the UI.
	if ShowHUDModel_Conf == 2 then 
	
		-- thanks gmod wiki
		local Avatar = vgui.Create( "AvatarImage", panel )
		Avatar:SetSize( 56, 56 )
		Avatar:SetPos( 8, 12 )
		Avatar:SetPlayer( LocalPlayer(), 64 )
	
	end
	
	if ShowHUDModel_Conf == 3 then 
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( CustomImage )
		surface.DrawTexturedRect( h, w, 56, 56 )
	end
	
	if ShowHUDModel_Conf == 0 then 
	end
	
end)


/*-------------------------------------------------------------------
	Agenda for DarkRP. I feel like the guy the maintains dark rp doesn't 
	want people to edit the agenda. It's a little more hacky then the 
	rest but it works. Tested on a super shitty laptop with no frame impact.
-------------------------------------------------------------------*/

local agendaText
hook.Add("HUDPaint", "DarkRP_Agenda", function()
	if d3uiHUDEnable:GetBool() == false then return end
	
    local agenda = LocalPlayer():getAgendaTable()
    if not agenda then return end
	-- This isn't as bad as it looks. Tested on a netbook and a computer with an Intel HD 3000 and it was fine.
    agendaText = DarkRP.textWrap((LocalPlayer():getDarkRPVar("agenda") or ""):gsub("//", "\n"):gsub("\\n", "\n"), "MoneyFont_14", 440)
    -- agendaText = agendaText or LocalPlayer():getDarkRPVar("agenda") 

	
	surface.SetDrawColor( 255, 255, 255, 255 )
		surface.SetMaterial( infoAgenda )
	surface.DrawTexturedRect( 10, 10, 512 , 256 )
	
	
    draw.DrawNonParsedText( agenda.Title, "JobFont_18", 260, 20, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
    draw.DrawNonParsedText( agendaText, AgendaFont_Conf, 60, 52, Color( 255, 255, 255, 255 ), 0)
end)


/*-------------------------------------------------------------------
	Hides the default hud.
	A lot of people like to put these in a table when you are hiding more 
	then one or two ui elements, but I like to cut out the middleman and 
	make big confusing lines of code.
-------------------------------------------------------------------*/

function HideDefaultHUDD3( name )
	if d3uiHUDEnable:GetBool() == false then return end
	if ( name == "CHudHealth" ) or ( name == "CHudBattery" ) or ( name == "CHudSecondaryAmmo" ) or ( name == "CHudAmmo" ) or ( name == "DarkRP_LocalPlayerHUD" ) or ( name == "DarkRP_Agenda" ) or ( name == "DarkRP_Hungermod" ) then return false end
	-- if ( name == "CHudHealth" ) or ( name == "CHudBattery" ) or ( name == "CHudSecondaryAmmo" ) or ( name == "CHudAmmo" ) or ( name == "DarkRP_LocalPlayerHUD" ) then return false end
end

hook.Add( "HUDShouldDraw", "HideDefaultHUDD3", HideDefaultHUDD3 )

-- ends the if opened at the very top of the file.
end