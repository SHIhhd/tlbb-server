--洛阳NPC
--乔复盛
--普通

--1、当九州商会店铺店主离线时间超过180天时，店主及所有合伙人的管理状态将被清除，店铺内所有物品、店铺盈利资金、店铺本金、店主的专属店铺称号将被系统回收。
--2、卖家成功盘出九州商会店铺后，需前往九州商会NPC处收取店铺盘出资金。
--3、新增元宝盘出方式。

x000109_g_scriptId=000109
--店铺回迁帖
x000109_g_ShopHuiqian = 30505256
--**********************************
--事件交互入口
--**********************************
function x000109_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{RCYH_180606_101}")
		--剩余商铺数量
		local nCurFree = LuaFnGetCurrentFreePlayerShop(sceneId)
		AddText(sceneId,"#{SHCK_090522_1}"..tostring(nCurFree).."#{SHCK_090522_2}")
		--查看所有商店
		AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180606_102}",6,2)
		if IsShutout( sceneId, selfId, ONOFF_T_PSHOP ) == 0 then
			if LuaFnMtl_GetCostNum(sceneId, selfId,x000109_g_ShopHuiqian) > 0 then
				AddNumText(sceneId,x000109_g_scriptId,"#{HFBC_90611_7}",6,12)
			else
				AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180606_103}",6,0)
			end
		else
			AddNumText(sceneId,x000109_g_scriptId,"#{HFBC_90611_1}",6,7)
		end
		AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180606_105}",6,1)
		AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180606_106}",6,3)
		--盘出收回
		AddNumText(sceneId,x000109_g_scriptId,"#{WJSD_110124_1}",6,13)
		
		AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180522_22}",11,6)
--		AddNumText(sceneId,x000109_g_scriptId,"关于收购材料",11,10)
		AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180522_39}",11,11)
		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************

--事件列表选中一项

--**********************************

function x000109_OnEventRequest( sceneId, selfId, targetId, eventId )

--0.建立自己的商店->显示建店条款->由客户端请求建店
		if	GetNumText()==0	then

			BeginEvent(sceneId)
				AddText(sceneId,"#{RCYH_180522_5}")
			EndEvent(sceneId)
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x000109_g_scriptId,0,1)
		--1.管理自己店铺
		elseif	GetNumText()==1	then

			--1.0通过店铺名来判定是否此店已经打开
			strShop0Name = LuaFnGetShopName(sceneId, selfId, 0)
			strShop1Name = LuaFnGetShopName(sceneId, selfId, 1)

			--1.1没店铺直接发错误提示
			if((strShop0Name == "")and(strShop1Name == "")) then
				BeginEvent(sceneId)

					strText = "对不起，你好象并没有店铺。"

					AddText(sceneId,strText);

				EndEvent(sceneId)

				DispatchMissionTips(sceneId,selfId)

			--1.2有店铺根据不同情况不同处理
			else
				--1.2.1有两个店铺，等待进一步选择
				if((strShop0Name ~= "") and (strShop1Name ~= "")) then
						BeginEvent(sceneId)

							AddText(sceneId,"#{RCYH_180606_107}")

							if GetPlayerShopFrezeType(sceneId, selfId, 0) == 1 then
								AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180606_108}"..strShop0Name,-1,4)
							else
								AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180606_109}"..strShop0Name,-1,4)
							end
							if GetPlayerShopFrezeType(sceneId, selfId, 1) == 1 then
								AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180606_110}"..strShop1Name,-1,5)
							else
								AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180606_111}"..strShop1Name,-1,5)
							end

						EndEvent(sceneId)
						DispatchEventList(sceneId,selfId,targetId)

				--1.2.2只有一个直接打开这个
				elseif(strShop0Name ~= "") then
						LuaFnOpenPlayerShop(sceneId, selfId, targetId, 0)

				--1.2.3只有一个直接打开这个
				elseif(strShop1Name ~= "") then
						LuaFnOpenPlayerShop(sceneId, selfId, targetId, 1)
				end

			end

		--2.察看所有商店的列表

		elseif	GetNumText()==2	then

			DispatchPlayerShopList( sceneId, selfId, targetId )

		--3.察看所有盘出商店的列表
		elseif	GetNumText()==3	then

			DispatchPlayerShopSaleOutList( sceneId, selfId, targetId )

		--4.察看自己身上的指定商店
		elseif	GetNumText()==4	then

			LuaFnOpenPlayerShop(sceneId, selfId, targetId, 0)

		--5.察看自己身上的指定商店
		elseif	GetNumText()==5	then

			LuaFnOpenPlayerShop(sceneId, selfId, targetId, 1)
		
		--6.玩家商店介绍
		elseif	GetNumText()==6	then
			BeginEvent(sceneId)
				AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180522_23}",11,100)
				AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180522_24}",11,101)
				AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180522_25}",11,102)
				AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180522_26}",11,103)
				AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180522_27}",11,104)
				AddNumText(sceneId,x000109_g_scriptId,"#{RCYH_180522_28}",8,105)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)

		--7.再次确认是否删店
		elseif	GetNumText()==7	then
	
			--1.0通过店铺名来判定是否此店已经打开
			local strShop0Name = LuaFnGetShopName(sceneId, selfId, 0)
			local strShop1Name = LuaFnGetShopName(sceneId, selfId, 1)

			--1.1没店铺直接发错误提示
			if((strShop0Name == "")and(strShop1Name == "")) then
				BeginEvent(sceneId)
					AddText(sceneId,"#{RCYH_180606_112}");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
			else
				BeginEvent(sceneId)
					AddText(sceneId,"#{UnregisterShopHelp}")
					AddNumText(sceneId,x000109_g_scriptId,"确定",6,8)
					AddNumText(sceneId,x000109_g_scriptId,"离开",6,9)
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			end

		--7.删!
		elseif	GetNumText()==8	then
			local canErase,canEraseNum = CanErasePlayerShop(sceneId, selfId)
			if(canErase == 1) then
				--检测背包是否购放回迁帖
				if LuaFnGetPropertyBagSpace( sceneId, selfId) < canEraseNum then
					BeginEvent(sceneId)
						if canEraseNum == 1 then
							AddText(sceneId,"#{HFBC_90611_3}");
						else
							AddText(sceneId,"#{HFBC_90611_4}");
						end
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,selfId)
					return 		 
				end
				--关闭对话框
				BeginUICommand(sceneId)
				EndUICommand(sceneId)
				DispatchUICommand(sceneId,selfId, 1000)
				--销毁店铺
				ErasePlayerShop(sceneId,selfId)
				--给回迁帖
				for i = 1,canEraseNum do
					LuaFnTryRecieveItem( sceneId, selfId, x000109_g_ShopHuiqian, 1)
				end
				--您已成功注销个人商店，并领取店铺回迁帖n个和商店本金。
				BeginEvent(sceneId)
					if canEraseNum == 1 then
						AddText(sceneId,"#{HFBC_90611_5}");
					else
						AddText(sceneId,"#{HFBC_90611_6}");
					end
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				
				BeginUICommand(sceneId)
				EndUICommand(sceneId)
				DispatchUICommand(sceneId,selfId, 19810222)
			elseif canErase == -1 then
				BeginEvent( sceneId )
					AddText( sceneId, "#{RCYH_180606_116}" )
				EndEvent( sceneId )
				DispatchMissionTips( sceneId, selfId )
			else
				BeginEvent( sceneId )
					AddText( sceneId, "#{RCYH_180606_117}" )
				EndEvent( sceneId )
				DispatchMissionTips( sceneId, selfId )
			end
		elseif	GetNumText()==9	then
			BeginUICommand(sceneId)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 1000)
--		elseif	GetNumText()==10	then
--			BeginEvent(sceneId)
--				AddText( sceneId, "#{function_help_101}" )
--			EndEvent(sceneId)
--			DispatchEventList(sceneId,selfId,targetId)
		elseif	GetNumText()==11	then
			BeginEvent(sceneId)
				AddText( sceneId, "#{RCYH_180522_40}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		--12.重开店铺->显示开店须知->由客户端请求建店
		elseif	GetNumText()==12	then

			BeginEvent(sceneId)
				AddText(sceneId,"#{HFBC_90611_8}")
			EndEvent(sceneId)
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x000109_g_scriptId,1,1)
			
		elseif	GetNumText()==13	then	
			--收取店铺盘出资金
			--需要二级密码
			if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
				if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
					return
				end
			end
			--WJSD_110124_3	对不起，您目前处于防沉迷状态，暂时无法收取到店铺盘出资金。	
			
			LuaFnAskNpcScriptMail(sceneId, selfId, MAIL_PLAYERSHOP_SALEOUT)
			return
		elseif	GetNumText()==100	then
			BeginEvent(sceneId)
				AddText( sceneId, "#{RCYH_180522_29}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif	GetNumText()==101	then
			BeginEvent(sceneId)
				AddText( sceneId, "#{RCYH_180522_31}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif	GetNumText()==102	then
			BeginEvent(sceneId)
				AddText( sceneId, "#{function_help_101}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif	GetNumText()==103	then
			BeginEvent(sceneId)
				AddText( sceneId, "#{SDS_90511_21}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif	GetNumText()==104	then
			BeginEvent(sceneId)
				AddText( sceneId, "#{RCYH_180522_32}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif	GetNumText()==105	then
			--返回首页
			x000109_OnDefaultEvent( sceneId, selfId,targetId )
		end

end

--**********************************
--继续
--**********************************
function x000109_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	if LuaFnMtl_GetCostNum(sceneId, selfId,x000109_g_ShopHuiqian) > 0 then
		--重新开张
		ApplyPlayerShop( sceneId, selfId, targetId,1 )
	else	
		--建立新商店
		ApplyPlayerShop( sceneId, selfId, targetId,0 )
	end
end
