--奇闻小喇叭
--脚本号
x890982_g_ScriptId	= 890982

--效果的ID
x890982_g_Impact		= -1	--使用一个特定的特效编号

--返回值处理集
x890982_g_WGCResult	=
{
	["SUC_SEND"]			= 49,		--奇闻小喇叭发送成功
	["FAL_FULL"]			= 50,		--奇闻小喇叭发送失败：消息池已满
}
x890982_g_ItemTabIdxList = { 38003086, 38003171 }
x890982_g_CTUID = 1001000017
--**********************************
--事件交互入口
--**********************************
function x890982_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x890982_IsSkillLikeScript( sceneId, selfId )
	return 1	 --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x890982_CancelImpacts( sceneId, selfId )
	return 0	 --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x890982_OnConditionCheck( sceneId, selfId )
	--背包中的位置
	local	bagId	= LuaFnGetBagIndexOfUsedItem( sceneId, selfId )
	if bagId < 0 then
		return 0
	end

	--检测物品是否加锁
	if LuaFnLockCheck( sceneId, selfId, bagId, 0 ) < 0 then
		x890982_MsgBox( sceneId, selfId, "此物品已被锁定！" )
		return 0
	end

	--校验使用的物品
	if( 1 ~= LuaFnVerifyUsedItem( sceneId, selfId ) ) then
		return 0
	end
	return 1

end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x890982_OnDeplete( sceneId, selfId )
--if( 0 < LuaFnDepletingUsedItem( sceneId, selfId ) ) then
--	return 1
--end
--return 0

	return 1
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x890982_OnActivateOnce( sceneId, selfId )

	if( -1 ~= x890982_g_Impact ) then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890982_g_Impact, 0 )
	end
	
	--背包中的位置
	local	bagId	= LuaFnGetBagIndexOfUsedItem( sceneId, selfId )
	if bagId < 0 then
		return 0
	end
	
	--呼叫发送界面
	BeginUICommand( sceneId )
		UICommand_AddInt(sceneId,0)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 890982 )
	return 1

end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x890982_OnActivateEachTick( sceneId, selfId )
	return 1	 --不是引导性脚本, 只保留空函数。
end


--**********************************
--C++回调接口，严禁Client呼叫：
--小喇叭发布前检查
--**********************************
function x890982_CallBackSpeakerBefore( sceneId, selfId )
	if LuaFnCTUCheckIsShutDown(sceneId,selfId,x890982_g_CTUID) == 1 then
		x890982_MsgBox( sceneId, selfId, "该功能临时关闭！" )
		return 0
	end
	--获取物品ID
	local ItemIndex = 0
	if LuaFnGetAvailableItemCount( sceneId, selfId, x890982_g_ItemTabIdxList[2] ) > 0 then
		ItemIndex = x890982_g_ItemTabIdxList[2]
		SetMissionDataEx( sceneId, selfId, MDEX_SPEAKER_MI_STATE, x890982_g_ItemTabIdxList[2] )		
	else
		ItemIndex = x890982_g_ItemTabIdxList[1]
		SetMissionDataEx( sceneId, selfId, MDEX_SPEAKER_MI_STATE, x890982_g_ItemTabIdxList[1] )
	end
			
	local itmId	= ItemIndex;
	if itmId <= 0 then
		x890982_MsgBox( sceneId, selfId, "#{SFDJ_240117_102}" )
		return 0
	end
	if LuaFnDelAvailableItem( sceneId, selfId, itmId, 1 ) == 0 then
		x890982_MsgBox( sceneId, selfId, "#{SFDJ_240117_102}" )
		return 0
	end

	return 1
end

--**********************************
--C++回调接口，严禁Client呼叫：
--小喇叭发布后返回
--**********************************
function x890982_CallBackSpeakerAfter( sceneId, selfId, retType, retParam )
	--获取物品ID
	local ItemIndex = GetMissionDataEx( sceneId, selfId, MDEX_SPEAKER_MI_STATE )

	local ItemId = 0
	for i, ItemTabIdx in x890982_g_ItemTabIdxList do
		if ItemIndex == ItemTabIdx then
			ItemId = ItemIndex
			break
		end
	end
	local itmId	= ItemId;
	if itmId <= 0 then
		return 0
	end

	if retType == x890982_g_WGCResult["SUC_SEND"] then
		if retParam > 0 then
			local nMin		= floor( retParam / 60 )
			local nSec		= mod( retParam, 60 )
			if nMin > 0 then
				x890982_MsgBox( sceneId, selfId, ScriptGlobal_Format("#{SFDJ_240117_105}",tostring(nMin),tostring(nSec)))
			else
				x890982_MsgBox( sceneId, selfId, ScriptGlobal_Format("#{SFDJ_240117_106}",tostring(nSec)))
			end
		else
			x890982_MsgBox( sceneId, selfId, "#{SFDJ_240117_104}" )
		end
	elseif retType == x890982_g_WGCResult["FAL_FULL"] then
		x890982_MsgBox( sceneId, selfId, "#{SFDJ_240117_103}" )
		TryRecieveItem( sceneId, selfId, itmId, QUALITY_CREATE_DEFAULT )
	end

	return 1
end

--**********************************
--信息提示
--**********************************
function x890982_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
