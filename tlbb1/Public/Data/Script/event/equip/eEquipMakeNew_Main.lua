--手工装备制作保星机制
--脚本号
x791099_g_ScriptId = 791099
-- 最大能工值
x791099_g_MaxLuckyPoint = 500
-- 装备点幸运值存储信息
x791099_g_tEquipLuckyPointSaveInfo			= 
{
	-- HEQUIP_CAP			=1,		//帽子	DEFENCE 
	[1] 	= {nSaveMD = MD_EQUIP_MAKE_NEW_LUCKY_POINT_01, nSaveType = 1, },
	-- HEQUIP_ARMOR			=2,		//衣服	DEFENCE 
	[2] 	= {nSaveMD = MD_EQUIP_MAKE_NEW_LUCKY_POINT_02, nSaveType = 1, },
	-- HEQUIP_CUFF			=3,		//手套	DEFENCE 
	[3] 	= {nSaveMD = MD_EQUIP_MAKE_NEW_LUCKY_POINT_03, nSaveType = 1, },
	-- HEQUIP_BOOT			=4,		//鞋	DEFENCE 
	[4] 	= {nSaveMD = MD_EQUIP_MAKE_NEW_LUCKY_POINT_04, nSaveType = 1, },
	-- HEQUIP_SASH			=5,		//腰带	DEFENCE 
	[5] 	= {nSaveMD = MD_EQUIP_MAKE_NEW_LUCKY_POINT_05, nSaveType = 1, },
	-- HEQUIP_RING			=6,		//戒指	ADORN  
	[6] 	= {nSaveMD = MD_EQUIP_MAKE_NEW_LUCKY_POINT_01, nSaveType = 2, },
	-- HEQUIP_NECKLACE		=7,		//项链	ADORN 
	[7] 	= {nSaveMD = MD_EQUIP_MAKE_NEW_LUCKY_POINT_02, nSaveType = 2, },
	-- HEQUIP_CHARM			=12,	//护符	 
	[12] 	= {nSaveMD = MD_EQUIP_MAKE_NEW_LUCKY_POINT_03, nSaveType = 2, },
	-- HEQUIP_WRIST			=14,	//护腕	DEFENCE  
	[14] 	= {nSaveMD = MD_EQUIP_MAKE_NEW_LUCKY_POINT_04, nSaveType = 2, },
	-- HEQUIP_SHOULDER		=15,	//护肩	DEFENCE  
	[15] 	= {nSaveMD = MD_EQUIP_MAKE_NEW_LUCKY_POINT_05, nSaveType = 2, },
}

-- 20501000	棉布碎片
-- 20501001	1级棉布
-- 20501002	2级棉布
-- 20501003	3级棉布
-- 20501004	4级棉布
-- 20501005	5级棉布
-- 20501006	6级棉布
-- 20501007	7级棉布
-- 20501008	8级棉布
-- 20502000	秘银碎片
-- 20502001	1级秘银
-- 20502002	2级秘银
-- 20502003	3级秘银
-- 20502004	4级秘银
-- 20502005	5级秘银
-- 20502006	6级秘银
-- 20502007	7级秘银
-- 20502008	8级秘银
-- 20501009	3级棉布·精品
-- 20501010	3级棉布·臻品
-- 20502013	3级秘银·精品
-- 20502014	3级秘银·臻品
-- 装备保星合法材料
x791099_g_tCanAddEquipLuckyPointMat = 
{
	-- 20501003,	--	3级棉布
	-- 20501004,	--	4级棉布
	-- 20501005,	--	5级棉布
	-- 20501006,	--	6级棉布
	-- 20501007,	--	7级棉布
	-- 20501008,	--	8级棉布
	-- 20502003,	--	3级秘银
	-- 20502004,	--	4级秘银
	-- 20502005,	--	5级秘银
	-- 20502006,	--	6级秘银
	-- 20502007,	--	7级秘银
	-- 20502008,	--	8级秘银

	-- 20501009,	--	3级棉布·精品
	20501010,		--	3级棉布·臻品
	-- 20502013,	--	3级秘银·精品
	20502014,		--	3级秘银·臻品
}
--**********************************
--精工等技能锻造后的c++回调
--**********************************
function x791099_AbilityProduce( sceneId, selfId, nAbilityId,itemBagPos,nMaterialItemId )
	local bCorrectMat = 0
	for i = 1, getn(x791099_g_tCanAddEquipLuckyPointMat) do
		if nMaterialItemId == x791099_g_tCanAddEquipLuckyPointMat[i] then
			bCorrectMat = 1
			break
		end
	end
	if bCorrectMat ~= 1 then
		return
	end
	--增加巧匠点
--	ZBBX_20230526_3	#Y巧匠点#r#r    #W每次使用#Y3级秘银·臻品#W、#Y3级棉布·臻品#W制造装备后，均可增加对应部位的#G巧匠点10点#W。#r    当对应部位的#G巧匠点#W达到#G500点#W上限后，再次使用#Y3级秘银·臻品#W、#Y3级棉布·臻品#W制造该部位的装备时，即可获得最低为#G7星#W的该部位装备，同时#G巧匠点清零#W。	
--	ZBBX_20230526_4	#P造化机缘，鬼斧神工！#{_INFOUSR%s0}集巧匠之大成，制造出了一件%s1星的#{_INFOMSG%s2}！顿时此间云散霞开，光华万丈！ 	
	local nEquipPoint = LuaFnGetBagEquipType(sceneId,selfId,itemBagPos)
	if x791099_g_tEquipLuckyPointSaveInfo[nEquipPoint] == nil then
		return
	end
	local nMDValue = GetMissionData(sceneId,selfId,x791099_g_tEquipLuckyPointSaveInfo[nEquipPoint].nSaveMD)
	local nCurLuckyPoint = 0
	if 1 == x791099_g_tEquipLuckyPointSaveInfo[nEquipPoint].nSaveType then
		nCurLuckyPoint = mod(nMDValue, 100000)
	elseif 2 == x791099_g_tEquipLuckyPointSaveInfo[nEquipPoint].nSaveType then
		nCurLuckyPoint = floor(nMDValue / 100000)
	end
	--必出七星
	if nCurLuckyPoint >= x791099_g_MaxLuckyPoint then
		nCurLuckyPoint = 0
		--设置装备星级
		LuaFnSetEquipQual(sceneId,selfId,itemBagPos,random(7,8))
		
		local nItemQual = LuaFnGetEquipQual(sceneId,selfId,itemBagPos)
		local nPlayerName = GetName(sceneId,selfId);
		local nEquip = GetBagItemTransfer(sceneId,selfId,nPos);
		local nNews = ScriptGlobal_Format("#{ZBBX_20230526_4}",nPlayerName,nItemQual,nEquip)
		AddGlobalCountNews(sceneId,nNews);
	else
		nCurLuckyPoint = nCurLuckyPoint + 10
		if nCurLuckyPoint >= x791099_g_MaxLuckyPoint then
			nCurLuckyPoint = x791099_g_MaxLuckyPoint
		end
		--保存新的值
		if 1 == x791099_g_tEquipLuckyPointSaveInfo[nEquipPoint].nSaveType then
			SetMissionData(sceneId,selfId,x791099_g_tEquipLuckyPointSaveInfo[nEquipPoint].nSaveMD,floor(nMDValue / 100000) * 100000 + nCurLuckyPoint)
		elseif 2 == x791099_g_tEquipLuckyPointSaveInfo[nEquipPoint].nSaveType then
			SetMissionData(sceneId,selfId,x791099_g_tEquipLuckyPointSaveInfo[nEquipPoint].nSaveMD,nCurLuckyPoint * 100000 + mod(nMDValue, 100000))
		end
	end
	--取消装备的绑定
	LuaFnItemUnBind(sceneId,selfId,itemBagPos)
	
	--增加能工值
--	ZBJB_20230526_3	#Y能工值#r#r#W    每次使用#Y3级秘银·臻品#W、#Y3级棉布·臻品#W制造装备后，均可增加#G10点能工值#W。#r    消耗#G1500点能工值#W可在#G苏州#{_INFOAIM270,150,1,朱锋}#R朱锋#W处兑换#Y解魂符#W，#Y解魂符#W可将#G已绑定#W的等级#G40#W级以上的#Y手工装备#W解锁（不包含手工武器）。#r#r#cfabf8f解绑消耗#r#G    注意：每次解绑将会减少1次该装备可修理次数的上限，当可修理次数上限小于等于1时无法解绑。	
	local nCurUnBindPoint = GetMissionData(sceneId,selfId,MD_EQUIP_MAKE_NEW_UNBIND_POINT)
	SetMissionData(sceneId,selfId,MD_EQUIP_MAKE_NEW_UNBIND_POINT,nCurUnBindPoint + 10)
	--更新客户端
	BeginUICommand( sceneId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 79109901 )
end
--**********************************
--列举事件
--**********************************
function x791099_ShowHelp( sceneId, selfId, nHelpIndex )
	if nHelpIndex == 1 then
		x791099_MsgBox( sceneId, selfId, -1, "#{ZBBX_20230526_3}" )
	elseif nHelpIndex == 2 then
		x791099_MsgBox( sceneId, selfId, -1, "#{ZBJB_20230526_3}" )
	end
end
--**********************************
--提示信息
--**********************************
function x791099_NotifyTip( sceneId,selfId,Tip )
	BeginEvent( sceneId )
	AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话窗口信息提示
--**********************************
function x791099_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
