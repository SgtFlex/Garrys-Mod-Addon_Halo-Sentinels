AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('entities/npc_vj_sent_H3AggressorMajor/init.lua')
include('shared.lua')

ENT.lights = {
	RightLight = {Object = "", Attachment = "root", Color = "0 180 255", Scale = .25, Offset = Vector(8, 16, -1)},
	LeftLight = {Object = "", Attachment = "root", Color = "0 180 255", Scale = .25, Offset = Vector(8, -16, -1)},
	EngineLight = {Object = "", Attachment = "root", Color = "200 240 240", Scale = .7, Offset = Vector(7, 0, 11)},
	GunLight = {Object = "", Attachment = "barrel", Color = "255 150 0", Scale = .25, Offset = Vector(8, 0, -2)},
	HeadLight = {Object = "", Attachment = "eye", Color = "0 155 255", Scale = .25, Offset = Vector(3, 0, -2.5)}
}
ENT.models = {
	BaseModel = "models/sentinels/h2aggressor.mdl",
	CorpseModel = "models/sentinels/h2aggressor.mdl",
	ShieldModel = "models/sentinels/sentinel_a_shield.mdl",
}
ENT.Model = ENT.models["BaseModel"]

function ENT:VariantCode()
	self:SetMaterial("models/sentinels/h2aggressor/h2aggressor_base_major")
end