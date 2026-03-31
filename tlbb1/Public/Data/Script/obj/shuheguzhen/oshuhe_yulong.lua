--束河古镇NPC
--玉龙
--一般

x001175_g_MsgInfo = { "#{SHGZ_0612_35}",
											"#{SHGZ_0620_103}",
											"#{SHGZ_0620_104}",
											"#{SHGZ_0620_105}",
										}

--**********************************
--事件交互入口
--**********************************
function x001175_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local msgidx = random(getn(x001175_g_MsgInfo))
		AddText(sceneId, x001175_g_MsgInfo[msgidx])
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

x001175_g_BossMonsterId = 60000
x001175_g_BOSS_CTUID = 1001000005
--**********************************
--Monster Timer
--**********************************
function x001175_OnCharacterTimer( sceneId, objId, dataId, uTime )
	local curTime = GetHour() * 100 + GetMinute();
	if curTime ~= 1500 then
		return
	end
	if LuaFnCTUCheckIsShutDown(sceneId,objId,x001175_g_BOSS_CTUID) == 1 then
		return
	end
	--BOSS已存在
	if x001175_IsHaveMonster( sceneId, x001175_g_BossMonsterId ) == 1 then
		return
	end
	--创建BOSS
	local nMonId = CreateMonsterWithDir(sceneId,x001175_g_BossMonsterId , 210, 33, 19, -1, 810101,6.283)
	if nMonId ~= -1 then
		SetCharacterTitle(sceneId, nMonId, "“中原霸主”")
		local str = "#P帝释天已经出现在#G束河古镇（210，33）#P！请天下英雄速去剿灭！最后将其斩杀者朝廷将给予获得丰厚奖励！"
		AddGlobalCountNews(sceneId, "@*;SrvMsg;SCA:"..str)
	end
end

--**********************************
--Monster 是否存在
--**********************************
function x001175_IsHaveMonster( sceneId, nDataId )
	local nMonsterNum = GetMonsterCount(sceneId)
	local bHaveMonster = 0
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		if GetMonsterDataID(sceneId, nMonsterId)  == nDataId  then
			bHaveMonster = 1
		end
	end
	return bHaveMonster
end

