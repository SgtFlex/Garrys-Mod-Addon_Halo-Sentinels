if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
include('shared.lua')
require('sound_vj_track')
include('entities/npc_vj_sent_H2Constructor/cl_init.lua')

/*--------------------------------------------------
	=============== Creature SNPC Base ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to make creature SNPCs
--------------------------------------------------*/
ENT.Laser = Material("cable/hydra")
ENT.firingOffset = Vector(0, 0, 0)