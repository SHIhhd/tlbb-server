--内测临时泡点脚本，公测取消
x777776_g_scriptId=777776
x777776_g_CTUID = 1001000004
--**********************************
--事件交互入口
--**********************************
function x777776_OnSceneTimer(sceneId)
	-- local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	-- if nHumanCount <= 0 then
		-- return
	-- end
	-- local AddYuanBao = 50000;
	-- local nHumanID;
	-- for i = 0,nHumanCount - 1 do
		-- nHumanID = LuaFnGetCopyScene_HumanObjId(sceneId,i)
		-- if LuaFnIsObjValid(sceneId,nHumanID) == 1 and LuaFnIsCanDoScriptLogic(sceneId,nHumanID) == 1 and LuaFnIsCharacterLiving(sceneId,nHumanID) == 1 then
			-- if LuaFnCTUCheckIsShutDown(sceneId,nHumanID,x777776_g_CTUID) == 0 then
				--先查询玩家元宝和绑元数量
				-- if YuanBao(sceneId,nHumanID,-1,3,0) + AddYuanBao < 2000000000 then
					-- YuanBao(sceneId,nHumanID,-1,1,AddYuanBao)
				-- end
				-- if BindYuanBao(sceneId,nHumanID,-1,3,0) + AddYuanBao < 2000000000 then
					-- BindYuanBao(sceneId,nHumanID,-1,1,AddYuanBao)
				-- end
				--获得了泡点奖励
				-- x777776_NotifyTip( sceneId, nHumanID, format("获得了泡点奖励：元宝（%d）、绑定元宝（%d）",AddYuanBao,AddYuanBao ))
			-- end
		-- end
	-- end
end
--**********************************
-- 屏幕中间信息提示
--**********************************
function x777776_NotifyTip( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
