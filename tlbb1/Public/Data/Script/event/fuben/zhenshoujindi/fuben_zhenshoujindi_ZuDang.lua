--副本内动阻配置

--脚本号
x893038_g_ScriptId	= 893038

--副本逻辑脚本号....
x893038_g_FuBenScriptId = 893020

x893038_g_SceneData_Dynamic_State_1 = 15		--动阻状态
x893038_g_SceneData_Dynamic_State_2 = 16		--动阻状态
x893038_g_SceneData_Dynamic_State_3 = 17		--动阻状态
x893038_g_SceneData_Dynamic_State_4 = 18		--动阻状态
x893038_g_SceneData_Dynamic_State_5 = 19		--动阻状态
x893038_g_SceneData_Dynamic_State_6 = 20		--动阻状态
x893038_g_SceneData_Dynamic_State_7 = 21		--动阻状态
x893038_g_SceneData_Dynamic_State_8 = 22		--动阻状态
x893038_g_SceneData_Dynamic_State_9 = 23		--动阻状态
x893038_g_SceneData_Dynamic_State_10 = 24		--动阻状态

--动态阻挡相关
x893038_DyInitState =
{
	--起始点第一道门禁 2000cm_x_200cm
	[1]  = {dataid = 11, posx = 215, posy = 54, npcid = 49617, dir = 0.450},
	--云卷舒出口
	[2]  = {dataid = 11, posx = 182, posy = 141, npcid = 49617, dir = 3.140},
	--逸出口 1400cm_x_200cm
	[3]  = {dataid = 10, posx = 122, posy = 187, npcid = 49616, dir = 4.540},
	--艾虎出口
	[4]  = {dataid = 10, posx = 62, posy = 109, npcid = 49616, dir = 3.140},
	--云卷舒入口
	[5]  = {dataid = 10, posx = 189, posy = 104, npcid = 49616, dir = 5.760},
	--逸入口 1000cm_x_200cm.unr.
	[6]  = {dataid = 9, posx = 158, posy = 179, npcid = 49615, dir = 1.570},
	--艾虎的两个出口
	[7]  = {dataid = 10, posx = 74.8, posy = 152.7, npcid = 49616, dir = 4.110},
	[8]  = {dataid = 10, posx = 71, posy = 133, npcid = 49616, dir = 2.54},
	--九尾狐入口
	[9]  = {dataid = 11, posx = 56.6, posy = 76.4, npcid = 49617, dir = 2.88},
	--九尾狐技能不可抵达区域
	[10]  = {dataid = 12, posx = 56, posy = 59, npcid = 49881, dir = 0.780},
}

--阶段1：封闭1、2、3、4
--阶段2：打开1
--阶段3：封闭1、5
--阶段4：打开1、2、5
--阶段5：封闭1、6
--阶段6：打开1、3、6
--阶段7：封闭1、7、8
--阶段8：打开1、4、7、8
--阶段9：封闭1、9
--阶段10：打开1、9

--**********************************
--动阻创建
--**********************************
function x893038_CreateDynamicBlock( sceneId , index )
	local item = x893038_DyInitState[index]
	if item == nil then
		return 0
	end
	local DyNpcid = LuaFnGetCopySceneData_Param(sceneId, x893038_g_SceneData_Dynamic_State_1 + index - 1)
	if DyNpcid == -1 then
		DyNpcid = CreateMonsterWithDir(sceneId, item.npcid, item.posx, item.posy, 3, -1, -1, item.dir)
		if DyNpcid == nil or DyNpcid < 0 then
			local recordMsg = format("CreateDynamicBlocks npc ERROR sceneid=%d", sceneId)
			ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_QINGQIU, -1,recordMsg)
			return 0
		else
			local DyRetId = LuaFnAddDynamicRegionByObject(sceneId, DyNpcid, item.dataid)
			if DyRetId == -1 then
				local recordMsg = format("CreateDynamicBlocks region ERROR sceneid=%d", sceneId )
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_QINGQIU, -1,recordMsg)
				return 0
			else
				LuaFnSetNpcIntParameter(sceneId, DyNpcid, 0, DyRetId)
				local recordMsg = format("CreateDynamicBlocks sceneid=%d, regionindex=%d, DyRetId=%d", sceneId, index, DyRetId)
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_QINGQIU, -1, recordMsg)
			end
		end
		LuaFnSetCopySceneData_Param(sceneId, x893038_g_SceneData_Dynamic_State_1 + index - 1, DyNpcid)
	else
		local recordMsg = format("Has Been Create ERROR sceneid=%d", sceneId )
		ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_QINGQIU, -1,recordMsg)
	end
	return 0
end
--**********************************
--动阻区域销毁
--**********************************
function x893038_ReleaseDynamicRegion( sceneId,index)
	if index < 1 or index > getn(x893038_DyInitState) then
		local recordMsg = format("ReleaseDynamicRegion sceneid=%d, index=%d", sceneId, index)
		ScriptGlobal_AuditGeneralLog( LUAAUDIT_FUBEN_QINGQIU, -1, recordMsg )
		return 0
	end
	local npcid = -1
	if index >= 1  and index <= getn(x893038_DyInitState) then
		npcid = LuaFnGetCopySceneData_Param(sceneId, index + x893038_g_SceneData_Dynamic_State_1 - 1)
	end
	local ret = 0
	if npcid >= 0 then
		local DyregionID = LuaFnGetNpcIntParameter(sceneId, npcid, 0)
		if DyregionID ~= -1 then
			ret = LuaFnReleaseDynamicRegion(sceneId, DyregionID)
			if ret == 1 then
				LuaFnSetNpcIntParameter(sceneId, npcid, 0, -1)
				--清理动阻的怪物数据
				SetCharacterDieTime(sceneId,npcid,100)
				LuaFnSetCopySceneData_Param(sceneId, index + x893038_g_SceneData_Dynamic_State_1 - 1,-1)
				
				local teamID = LuaFnGetCopySceneData_Param( sceneId, 6)
				local recordMsg = format("ReleaseDynamicRegion sceneid=%d, regionindex=%d, teamID=%d", sceneId, index, teamID)
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_QINGQIU, -1, recordMsg)
			else
				local recordMsg = format("ReleaseDynamicRegion open err sceneid=%d, regionindex=%d", sceneId, index)
				ScriptGlobal_AuditGeneralLog(LUAAUDIT_FUBEN_QINGQIU, -1, recordMsg)
			end
		end
	end
	return 0
end

--**********************************
--对话框提示
--**********************************
function x893038_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

