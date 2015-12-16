-- Makes the hud load properly.
AddCSLuaFile("client/hud.lua")
AddCSLuaFile("config.lua")

-- Settings file. Located in the lua folder.
include("config.lua")

-- Now uses workshop. 

-- resource.AddFile( "materials/d3hb/d3health.vmt" )
-- resource.AddFile( "materials/d3hb/d3health.vtf" )
-- resource.AddFile( "materials/d3hb/d3healthgoop.png" )

-- resource.AddFile( "materials/d3hb/d3armor.vmt" )
-- resource.AddFile( "materials/d3hb/d3armor.vtf" )
-- resource.AddFile( "materials/d3hb/d3armorgoop.png" )

-- resource.AddFile( "materials/d3hb/d3info.vmt" )
-- resource.AddFile( "materials/d3hb/d3info.vtf" )
-- resource.AddFile( "materials/d3hb/d3hunger.png" )

-- resource.AddFile( "materials/d3hb/d3agenda.vmt" )
-- resource.AddFile( "materials/d3hb/d3agenda.vmf" )

-- Custom font file.
resource.AddFile( "resource/font/exl____.ttf" )

-- Custom PNG.
local filename = "materials/" .. ShowHUDModelCustomPNG_Conf
resource.AddFile( filename )

resource.AddWorkshop(565568580)
