--珍兽繁殖
--脚本号 （改成正确脚本号）

x800101_g_scriptId = 800101
--单人珍兽繁殖材料ID 爱心小窝
x800101_g_ItemTblID   = 30309794
--**********************************
--宠物单人繁殖
--**********************************
function x800101_OnSignalPetProcreateRegister(sceneId,selfId,targetId,firstPetGH,firstPetGL,secondPetGH,secondPetGL,nCostItemPos)
	local ret = LuaFnIsItemLocked( sceneId, selfId, nCostItemPos)
	if ret ~= 0 then
		x800101_NotifyTip(sceneId, selfId, "#{DRFZZC_091013_16}");
		return
	end
	--检测物品是否爱心小窝
	local nItemTableIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nCostItemPos )
	if LuaFnGetAvailableItemCount(sceneId, selfId,x800101_g_ItemTblID)<1 or nItemTableIndex ~= x800101_g_ItemTblID then
		x800101_NotifyTip(sceneId, selfId, "#{DRFZZC_091013_17}");
		return
	end
	--前期检测就这么多，其余的交给程序
	LuaFnRequestPetPropagateSingle(sceneId,selfId,firstPetGH,firstPetGL,secondPetGH,secondPetGL,nCostItemPos)
end
--**********************************
--枚举繁殖选项
--**********************************
function x800101_OnDefaultEvent( sceneId, selfId,targetId )
	local key	= GetNumText()
	if key == x800101_g_scriptId then
		BeginEvent( sceneId )
			AddText( sceneId, "#{DRFZZC_091013_01}" )
			AddNumText(sceneId,x800101_g_scriptId,"#{DRFZZC_091013_02}",6,100)
			AddNumText(sceneId,x800101_g_scriptId,"#{DRFZZC_091013_03}",6,101)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	if key == 100 then
		local checkRet = LuaFnCheckCallPetProcreateRegisterUI(sceneId, selfId,targetId);
		if checkRet == 1 then
			local ret = LuaFnCallPetProcreateRegisterUI(sceneId, selfId,targetId,26);
			if ret == 1 then
				Msg2Player(sceneId, selfId, "执行成功", MSG2PLAYER_PARA);
			else
				Msg2Player(sceneId, selfId, "执行失败", MSG2PLAYER_PARA);
			end
		end
	end
	if key == 101 then
		LuaFnCallPetPropagateSingleRegisterUI(sceneId, selfId,targetId);
	end
end

function x800101_OnEnumerate( sceneId, selfId,targetId )
	if IsShutout( sceneId, selfId, ONOFF_T_PETPRO ) == 0 then
		AddNumText(sceneId,x800101_g_scriptId,"珍兽繁殖",6,x800101_g_scriptId)
	end
end
--**********************************
--醒目提示
--**********************************
function x800101_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
	AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
