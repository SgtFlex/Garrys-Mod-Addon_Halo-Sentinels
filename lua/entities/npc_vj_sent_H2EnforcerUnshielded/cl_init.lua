if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
include('shared.lua')
require('sound_vj_track')
/*--------------------------------------------------
	=============== Creature SNPC Base ===============
	*** Copyright (c) 2012-2019 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
INFO: Used to make creature SNPCs
--------------------------------------------------*/

ENT.RenderGroup = RENDERGROUP_BOTH
local Laser = Material( "cable/redlaser" )
local target = Vector(5000, 5000, 5000)

function ENT:Initialize() end
function ENT:Draw()
	self:DrawModel()
	self:CustomOnDraw()
end
function ENT:DrawTranslucent() self:Draw() end
function ENT:BuildBonePositions(NumBones,NumPhysBones) end
function ENT:SetRagdollBones(bIn) self.m_bRagdollSetup = bIn end
function ENT:DoRagdollBone(PhysBoneNum,BoneNum) /*self:SetBonePosition(BoneNum,Pos,Angle)*/ end
//function ENT:CalcAbsolutePosition(pos, ang) end
-- Custom functions ---------------------------------------------------------------------------------------------------------------------------------------------
/*function ENT:CustomOnDraw()
    render.SetMaterial( Laser )
    if (self:GetNWBool("firing",false)==true) then
    	render.DrawBeam( self:GetPos() + Vector(0, 0,-20), self:GetNWVector("testvector",Vector( 0, 0, 0 )), 35, 1, 1, Color( 255, 150, 255, 255) )
    end
end
*/

---------------------------------------------------------------------------------------------------------------------------------------------
/*net.Receive("vj_creature_onthememusic",function(len)
	//BroadcastLua(print("Theme music net code is running!"))
	local selfEntity = net.ReadEntity()
	if !IsValid(selfEntity) then return end
	//print(selfEntity)
	selfEntity.VJ_IsPlayingSoundTrack = true
	selfEntity:SetNetworkedBool("VJ_IsPlayingSoundTrack",true)
	local TracksTable = net.ReadTable()
	local entSoundLevel = net.ReadFloat()
	if !sound_vj_track.IsPlaying(1) then
		sound_vj_track.Play(1,TracksTable,entSoundLevel)
	end
	local t = sound_vj_track.Duration(1)
	if !t then return end
	local tCurTime = RealTime()
	local tmEnd = t + tCurTime

hook.Add("Think","thememusic_client_runtrack",function()
	//local numEnts = #util.VJ_GetSNPCsWithActiveSoundTracks()
	local fadeouttime = net.ReadFloat()
	if RealTime() >= tmEnd && IsValid(selfEntity) then
		tmEnd = RealTime() + sound_vj_track.Duration(1)
		sound_vj_track.Play(1,TracksTable,entSoundLevel)
	end
	//print(#util.VJ_GetSNPCsWithActiveSoundTracks())
	if (!selfEntity:IsValid()) then
	if #util.VJ_GetSNPCsWithActiveSoundTracks() <= 0 then
		sound_vj_track.FadeOut(1,fadeouttime)
		hook.Remove("Think","thememusic_client_runtrack")
		end
	end
 end)
end)*/