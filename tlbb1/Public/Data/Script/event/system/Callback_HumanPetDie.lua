-- 珍兽死亡回调

-- 脚本ID
x769003_g_ScriptId = 769003


	-- 珍兽死亡事件回调
	-- 参数:
		-- sceneId         - 当前场景ID
		-- myObjId         - 珍兽主人的ObjID
		-- KillerObjID     - 击杀者的ObjID (-1表示无击杀者)
		-- KillerPetObjID  - 被杀死的珍兽ObjID
	-- 无返回值 (通知型回调，不影响逻辑)

function x769003_callback_HumanPetDie(sceneId, myObjId, KillerObjID, KillerPetObjID)
	-- 默认不做任何处理
	-- 示例: 全服广播珍兽死亡消息
	AddGlobalCountNews(sceneId, format("#{_INFOUSR%s}的珍兽#{_INFOUSR%s}被#{_INFOUSR%s}击杀了",
	    GetName(sceneId, myObjId), GetName(sceneId, KillerPetObjID), GetName(sceneId, KillerObjID)))
end

function x769003_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
