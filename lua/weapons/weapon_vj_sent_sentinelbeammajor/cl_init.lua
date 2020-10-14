if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
require('sound_vj_track')
include('weapons/weapon_vj_sent_sentinelbeam/cl_init.lua')
include('shared.lua')
/*--------------------------------------------------
	=============== Creature SNPC Base ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to make creature SNPCs
--------------------------------------------------*/
SWEP.RenderGroup = RENDERGROUP_BOTH
SWEP.sentFX = "sentBeamFXBlue"
SWEP.sentFXOrigin = "sentBeamFXOriginBlue"
SWEP.Laser = Material("cable/blue_elec")
