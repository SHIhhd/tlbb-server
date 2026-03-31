--Exterior功能
--外观中心主脚本
x999900_g_ScriptId = 999900
--脸型ID
x999900_g_FaceStyleExteriorType = 0 
--发型ID
x999900_g_HairStyleExteriorType = 1
--头像ID
x999900_g_HeadStyleExteriorType = 2 
--坐骑ID
x999900_g_ExteriorType = 3
--附体ID
--x999900_g_PossExteriorType = 4
--华裳阁目前的上限容量
x999900_g_FushionMaxNum = 100

--//新外观系统
--enum EXTERIOR_DATA_TYPE
--{
--	EXTERIOR_FACEMODEL = 0,			//脸型
--	EXTERIOR_HAIRMODEL = 1,			//发型
--	EXTERIOR_HEADIMAGE = 2,			//头像
--	EXTERIOR_MOUNT = 3,				//坐骑
--
--	EXTERIOR_TYPE_NUM,
--};

--**********************************
--取出特殊可取出的易容阁物品
--**********************************
function x999900_ReverseExteriorRideToItem( sceneId, selfId,nExteriorId )
	local strMountName,iReverseItem = LuaFnGetExteriorRideInfoByExteriorID(nExteriorId);
	if strMountName == nil or iReverseItem <= 0 then
		return
	end
	if LuaFnIsHaveExterior(sceneId,selfId,x999900_g_ExteriorType,nExteriorId) ~= 1 then
		x999900_NotifyTip( sceneId, selfId, "#{ZJGN_211105_64}" )
		return
	end
	if LuaFnGetPropertyBagSpace(sceneId, selfId) < 1 then
		x999900_NotifyTip( sceneId, selfId, "#{ZJGN_211105_65}" )
		return
	end
	--取出信息
	LuaFnTryRecieveSingleItem(sceneId,selfId,iReverseItem,1,0)
	--易容阁数据清理
	LuaFnUnActiveExterior(sceneId,selfId,x999900_g_ExteriorType,nExteriorId)
	x999900_NotifyTip( sceneId, selfId, "#{ZJGN_211105_66}" )
end

--**********************************
--上线邮件提醒
--**********************************
function x999900_OnHumanLogin( sceneId, selfId )
	--这个特殊标记在CGShowFashionDepotDataHandler内会置1，lua不再处理
	if GetMissionFlag(sceneId,selfId,MF_ExteriorNewLogin) == 1 then
		return
	end
	--发送欢迎邮件
	LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{WGTJ_201222_55}")
end

--**********************************
--醒目提示
--**********************************
function x999900_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end


