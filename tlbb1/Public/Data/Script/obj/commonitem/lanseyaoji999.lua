--蓝色妖姬999
--脚本号
x890078_g_scriptId = 890078 --临时写这个,真正用的时候一定要改.
--效果的ID
x890078_g_Impact1 = 10547  --临时写这个
x890078_g_Impact2 = 89 --不用
--获得永久时装暂定几率
x890078_g_Random = 15
--永久非绑定时装ID
x890078_g_DressID = 10124407
--发放时装的数量
x890078_g_DressNum = 1
--所使用道具
x890078_g_NeedItemID = 38002283
--所获得的道具
x890078_g_ItemId = 38002284
--所获得的道具数量
x890078_g_ItemNum = 400
--背包空间材料栏所剩数量要求
x890078_g_MatBagSize = 2
--背包空间道具栏所剩数量要求
x890078_g_BagSize = 1
--**********************************
--事件交互入口
--**********************************
function x890078_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x890078_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x890078_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x890078_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	local nMaterialSize = LuaFnGetMaterialBagSpace(sceneId,selfId)
	local nBagSize = LuaFnGetPropertyBagSpace(sceneId,selfId)
	local targetId = LuaFnGetTargetObjID(sceneId, selfId)
	if(0<=targetId) then
		-- 目标必须是友军的检测
		if LuaFnIsFriend(sceneId, targetId, selfId) ~= 1 then
			x890078_NotifyTip(sceneId,selfId,"#{LSYJ_130227_05}")
			return 0;
		end
		
		if LuaFnIsFriend(sceneId, selfId, targetId ) ~= 1 then
			x890078_NotifyTip(sceneId,selfId,"#{LSYJ_130227_05}")
			return 0;
		end
		local SelfSex = LuaFnGetSex(sceneId, selfId)
		local TargetSex = LuaFnGetSex(sceneId, targetId)                
		if( SelfSex == TargetSex ) then
			x890078_NotifyTip(sceneId,selfId,"#{LSYJ_130227_05}")
			return 0;                                            
		end
		--对方背包空间检测
		if LuaFnGetMaterialBagSpace(sceneId,targetId) < x890078_g_MatBagSize then
			x890078_NotifyTip(sceneId,selfId,"#{QXHB_20210701_184}",x890078_g_MatBagSize)
			return 0
		end
		if LuaFnGetPropertyBagSpace(sceneId,targetId) < x890078_g_BagSize then
			x890078_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{QXHB_20210701_172}",x890078_g_BagSize))
			return 0;
		end
	end
	--个人背包空间检测
	if nMaterialSize < x890078_g_MatBagSize then
		x890078_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{QXHB_20210701_186}",x890078_g_MatBagSize))
		return 0;
	end
	
	if nBagSize < x890078_g_BagSize then
		x890078_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{QXHB_20210701_171}",x890078_g_BagSize))
		return 0;
	end
	return 1; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x890078_OnDeplete( sceneId, selfId )
	if(LuaFnDepletingUsedItem(sceneId, selfId)) then
		return 1;
	end
	return 0;
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x890078_OnActivateOnce( sceneId, selfId )
	if(-1~=x890078_g_Impact1) then
		--给目标加效果
		local targetId = LuaFnGetTargetObjID(sceneId, selfId)
		local nFriendPoint = LuaFnGetFriendPoint( sceneId, selfId, targetId );
		if(0<=targetId) then
			if LuaFnIsFriend(sceneId, targetId, selfId) > 0 then
				LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, targetId, x890078_g_Impact1, 0);
				LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, targetId, x890078_g_Impact2, 0);
				--计算几率
				local nRandomData = random(1,100)
				if nRandomData <= x890078_g_Random then
					--利用一个FlagEx记录是否获得了时装，如果达到了这个条件，上面公告方便操作，谁送花存谁就行了，公告发出去了就清空。
					SetMissionFlagEx(sceneId,selfId,MFEX_LANSEYAOJI_999,1)
					--给时装提示
					x890078_NotifyTip(sceneId,selfId,
						ScriptGlobal_Format("#{QXHB_20210701_175}"
						,GetName(sceneId,targetId)
					))
--					x890078_NotifyTip(sceneId,selfId,
--						ScriptGlobal_Format("#{QXHB_20210701_176}"
--						,x890078_g_DressNum
--						,GetItemName(sceneId,x890078_g_DressID)
--					))
					
					x890078_NotifyTip(sceneId,targetId,
						ScriptGlobal_Format("#{QXHB_20210701_179}"
						,GetName(sceneId,selfId)
					))
--					x890078_NotifyTip(sceneId,targetId,
--						ScriptGlobal_Format("#{QXHB_20210701_180}"
--						,x890078_g_DressNum
--						,GetItemName(sceneId,x890078_g_DressID)
--					))
					--给双方发时装
--					LuaFnTryRecieveMultiItem(sceneId,selfId,x890078_g_DressID,1,x890078_g_DressNum,0)
--					LuaFnTryRecieveMultiItem(sceneId,targetId,x890078_g_DressID,1,x890078_g_DressNum,0)
					
					if GetMissionFlagEx(sceneId,selfId,MFEX_LANSEYAOJI_999) > 0 then
--						local nItemBagIndex = GetBagPosByItemSn(sceneId, selfId, x890078_g_DressID);
--						if nItemBagIndex ~= -1 then
--							local szTransfer = GetBagItemTransfer(sceneId,selfId, nItemBagIndex);
							SetMissionFlagEx(sceneId,selfId,MFEX_LANSEYAOJI_999,0)
--							AddGlobalCountNews(sceneId,ScriptGlobal_Format("@*;SrvMsg;SCA:#{QXHB_20210701_183}",
--								GetName( sceneId, selfId ),
--								x890078_g_NeedItemID,
--								GetName( sceneId, targetId ),
--								szTransfer))
--						end
						
					else
						AddGlobalCountNews(sceneId,ScriptGlobal_Format("@*;SrvMsg;SCA:#{QXHB_20210701_181}",
							GetName( sceneId, selfId ),
							x890078_g_NeedItemID,
							GetName( sceneId, targetId )))
					end
					
				else
					--给道具提示
--					x890078_NotifyTip(sceneId,selfId,
--						ScriptGlobal_Format("#{QXHB_20210701_173}"
--						,GetName(sceneId,targetId)
--					))
--					x890078_NotifyTip(sceneId,selfId,
--						ScriptGlobal_Format("#{QXHB_20210701_174}"
--						,x890078_g_ItemNum
--						,GetItemName(sceneId,x890078_g_ItemId)
--					))
--					
--					x890078_NotifyTip(sceneId,targetId,
--						ScriptGlobal_Format("#{QXHB_20210701_177}"
--						,GetName(sceneId,selfId)
--					))
--					x890078_NotifyTip(sceneId,targetId,
--						ScriptGlobal_Format("#{QXHB_20210701_178}"
--						,x890078_g_ItemNum
--						,GetItemName(sceneId,x890078_g_ItemId)
--					))
--					--发诉情蝶
--					LuaFnTryRecieveMultiItem(sceneId,selfId,x890078_g_ItemId,1,x890078_g_ItemNum,0)
--					LuaFnTryRecieveMultiItem(sceneId,targetId,x890078_g_ItemId,1,x890078_g_ItemNum,0)
				end
				--更新收花送花数
				CallScriptFunction( 891396, "AddSendFlowerNum", sceneId, selfId,999 ) ;
				CallScriptFunction( 891396, "AddReciveFlowerNum", sceneId, targetId,999 ) ;
				
				--给收花的玩家写入榜单数据
				if nFriendPoint >= 9999 then
					x890078_NotifyTip(sceneId,selfId,"#{QXHB_20210701_81}");
				else
					x890078_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{QXHB_20210701_80}",tostring(5000)))
				end
			end
		end
	end
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x890078_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end
--**********************************
--屏幕中间提示
--**********************************
function x890078_NotifyTip(sceneId,selfId,tip)
	BeginEvent(sceneId)
		AddText(sceneId,tip)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end