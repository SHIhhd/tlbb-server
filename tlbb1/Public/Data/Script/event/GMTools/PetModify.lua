-- 珍兽修改器
-- 雪舞原创制作

-- 脚本ID
x666661_g_scriptId	= 666661

--读取珍兽
function x666661_ReadiPetInfo(sceneId, selfId,arg1)
	local nPetIndex = arg1
	-- 获取珍兽GUID
	local petGUID_H, petGUID_L = LuaFnGetPetGUID( sceneId, selfId, nPetIndex )
	local DataID = LuaFnGetPetDataIDByGUID(sceneId,selfId,petGUID_H, petGUID_L)
	--是否查询过/锁定状态 --0未查询 1单锁定 2已查询 3已锁定+锁定
	local isState = LuaFnGetPetState(sceneId,selfId,petGUID_H, petGUID_L)
	print(isState)
	--上次繁殖等级
	local ProcreateLevel = LuaFnGetPetLastProcreateLevel(sceneId, selfId, petGUID_H, petGUID_L)
	--获取珍兽配偶GUID信息
	local HexString1,_ = LuaFnGetPetSpouseGUIDByGUID(sceneId, selfId,petGUID_H, petGUID_L)
	local Hguid = format("%X", HexString1)
	--成长率
	local GrowRate = LuaFnGetPetGrowRateData(sceneId, selfId, petGUID_H, petGUID_L)
	
	--字符串传输给客户端
	BeginUICommand( sceneId )
		UICommand_AddString( sceneId, Hguid)
		UICommand_AddInt(sceneId,DataID) 
		UICommand_AddInt(sceneId,isState) 
		UICommand_AddInt(sceneId,ProcreateLevel) 
		UICommand_AddInt(sceneId,GrowRate) 
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 202402161 )
end
 
--修改珍兽
function x666661_ModifyPet(sceneId, selfId,Type,arg1,arg2,arg3,arg4)
	--权限检查
	if LuaFnIsAdminAccount(sceneId,selfId) == 0 then
		return
	end
	
	local nPetIndex = arg1
	local petGUID_H, petGUID_L = LuaFnGetPetGUID( sceneId, selfId, nPetIndex )
	
	if Type == 1 then --//珍兽ID
		LuaFnSetPetDataIDByGUID(sceneId,selfId,petGUID_H, petGUID_L,arg2)
		PushDebugMessage(sceneId,selfId,"[珍兽修改器] DataID 修改成功")
	elseif Type == 2 then --等级
		LuaFnSetPetLevelByGUID(sceneId,selfId,petGUID_H, petGUID_L,arg2)
		PushDebugMessage(sceneId,selfId,"珍兽等级修改成功")
	elseif Type == 3 then --寿命
		LuaFnSetPetLife( sceneId, selfId, petGUID_H, petGUID_L, arg2 )
		PushDebugMessage(sceneId,selfId,"珍兽寿命修改成功")
	elseif Type == 4 then --快乐
		LuaFnSetPetHappiness( sceneId, selfId, petGUID_H, petGUID_L, arg2 )
		PushDebugMessage(sceneId,selfId,"珍兽快乐修改成功")
	elseif Type == 5 then --悟性
		SetPetSavvy(sceneId,selfId,petGUID_H, petGUID_L,arg2)
		PushDebugMessage(sceneId,selfId,"珍兽悟性修改成功")
	elseif Type >= 6 and Type <= 10 then --五维基础资质
		if Type == 6 then
			LuaFnSetPet_StrPerception(sceneId,selfId,nPetIndex,arg2)
		elseif Type == 7 then
			LuaFnSetPet_SprPerception(sceneId,selfId,nPetIndex,arg2)
		elseif Type == 8 then
			LuaFnSetPet_ConPerception(sceneId,selfId,nPetIndex,arg2)
		elseif Type == 9 then
			LuaFnSetPet_IntPerception(sceneId,selfId,nPetIndex,arg2)
		elseif Type == 10 then
			LuaFnSetPet_DexPerception(sceneId,selfId,nPetIndex,arg2)
		end
		PushDebugMessage(sceneId,selfId,"珍兽基础资质修改成功")
	elseif Type == 11 then --根骨
		LuaFnSetPetGenGuByGUID(sceneId,selfId,petGUID_H, petGUID_L,arg2)
		PushDebugMessage(sceneId,selfId,"珍兽根骨修改成功")
	elseif Type == 12 then --成长率
		LuaFnSetPetData(sceneId, selfId,petGUID_H, petGUID_L,arg2,arg3)
		PushDebugMessage(sceneId,selfId,"成长率设置成功")
	elseif Type == 13 then --剩余潜能
		LuaFnSetPetRemainPointByGUID(sceneId,selfId,petGUID_H, petGUID_L,arg2)
		PushDebugMessage(sceneId,selfId,"珍兽潜能修改成功")
	elseif Type == 14 then --是否珍兽状态
		LuaFnSetPetState(sceneId,selfId,petGUID_H, petGUID_L,arg2)
	elseif Type >= 15 and Type <= 19 then --五维属性值
		LuaFnSetPetData(sceneId,selfId,petGUID_H, petGUID_L,Type-15,arg2)
		PushDebugMessage(sceneId,selfId,"珍兽五维属性值修改成功")
	elseif Type == 20 then --设置性格
		LuaFnSetPetAITypeByGUID(sceneId, selfId,petGUID_H, petGUID_L,arg2)
		PushDebugMessage(sceneId,selfId,"珍兽性格修改成功")
	elseif Type == 21 then 
		if arg2 == nil or arg2 == "" then
			PushDebugMessage(sceneId,selfId,"珍兽名字为空,请重新取一个!")
			return
		end
		LuaFnSetPetNameByGUID( sceneId, selfId, petGUID_H, petGUID_L ,arg2 )
		PushDebugMessage(sceneId,selfId,"珍兽名字修改成功")
	elseif Type == 22 then 
		LuaFnSetPetProcreateGUID(sceneId, selfId,petGUID_H, petGUID_L,arg2,arg3)
		PushDebugMessage(sceneId,selfId,"珍兽配偶修改成功")
	elseif Type == 23 then
		LuaFnSetPetLastProcreateLevel(sceneId, selfId,petGUID_H, petGUID_L,arg2)
		PushDebugMessage(sceneId,selfId,"珍兽上次繁殖等级修改成功")
	elseif Type == 24 then --设置珍兽当前拥有的经验
		LuaFnSetPetExpByGUID(sceneId, selfId,petGUID_H, petGUID_L,arg2)
		PushDebugMessage(sceneId,selfId,"珍兽当前拥有经验修改成功")
	elseif Type == 25 then --灵性
		
	elseif Type == 26 then --融合度
	
	elseif Type == 27 then --觉醒
	
	elseif Type >= 28 and Type <= 39 then --12技能修改 28 29 30 31 32 33 34 35 36 37 38 39
		LuaFnSetPetSkillDataByGUID(sceneId, selfId,petGUID_H, petGUID_L,Type-27,arg2)
		PushDebugMessage(sceneId,selfId,"珍兽技能修改成功")
	end
	x666661_ReadiPetInfo(sceneId, selfId,nPetIndex)
end