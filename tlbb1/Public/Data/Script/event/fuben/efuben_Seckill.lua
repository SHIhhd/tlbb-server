--副本扫荡脚本部分

--脚本号
x891062_g_ScriptId	= 891062
x891062_g_SweepPage_ITEM_NUM = 12;
x891062_g_MAX_SECKILL_BASE_NUM = 32;	--最大空间是32 程序预留
x891062_g_TIME_2000_01_03_ = 946828868
x891062_g_MinLevel = 60
x891062_g_MonthCard = 38000206
x891062_g_DayCard = 38000207
x891062_g_CTUID = 1001000020
--**********************************
--扫荡特权卡
--**********************************
function x891062_OpenTeQuan(sceneId,selfId,nType)
	if GetLevel(sceneId,selfId) < x891062_g_MinLevel then
		x891062_NotifyTip( sceneId, selfId, "#{TQJF_221108_05}")
		return
	end
	--请求激活特权
	local tqmfmonth = GetMissionFlag(sceneId,selfId,MF_TQSD_MONTHCARD)
	local tqmfday = GetMissionFlag(sceneId,selfId,MF_TQSD_DAYCARD)
	if tqmfmonth == 1 or tqmfday == 1 then
		x891062_NotifyTip( sceneId, selfId, "#{TQJF_221108_06}")
		return
	end
	--组队跟随状态
	if IsTeamFollow( sceneId, selfId ) == 1 then
		x891062_NotifyTip(sceneId,selfId,"#{TQJF_221108_19}")
		return
	end
	--摆摊
	if LuaFnIsStalling( sceneId, selfId ) == 1 then
		x891062_NotifyTip(sceneId,selfId,"#{TQJF_221108_20}")
		return
	end
	--请求激活
	if nType == 0 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 0 )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20221115 )
	elseif nType == 1 then
		--月卡
		local nItemPos = LuaFnGetAvailableItemFirstPos(sceneId,selfId,x891062_g_MonthCard)
		if nItemPos < 0 then
			x891062_NotifyTip(sceneId,selfId,"#{TQJF_221108_43}")
			
			local nNeedMoney,nMoneyUnit,itemIndex = LuaFnGetConvenientBuyMoney(sceneId,selfId,10,x891062_g_MonthCard,1)
			if nNeedMoney ~= nil then
				local strTips = ScriptGlobal_Format("#{TQJF_221108_44}",
				tostring(x891062_g_MonthCard),tostring(nNeedMoney),"#{XFYH_20120221_10}","#{XFYH_20120221_12}",tostring(x891062_g_MonthCard))
				
				BeginUICommand( sceneId )
					UICommand_AddInt( sceneId, 2 )
					UICommand_AddInt( sceneId, nMoneyUnit )
					UICommand_AddInt( sceneId, nNeedMoney )
					UICommand_AddInt( sceneId, itemIndex )
					UICommand_AddInt( sceneId, 0 )
					UICommand_AddInt( sceneId, x891062_g_ScriptId )
					UICommand_AddInt( sceneId, 1 )
					UICommand_AddInt( sceneId, -1 )
					UICommand_AddInt( sceneId, 1 )
					UICommand_AddString(sceneId,strTips)
				EndUICommand( sceneId )
				DispatchUICommand( sceneId, selfId, 20120222 )
			
			end
			return
		end
		BeginUICommand( sceneId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 89106201 )
	elseif nType == 2 then
		--日卡
		local nItemPos = LuaFnGetAvailableItemFirstPos(sceneId,selfId,x891062_g_DayCard)
		if nItemPos < 0 then
			x891062_NotifyTip(sceneId,selfId,"#{TQJF_221108_42}")
			
			local nNeedMoney,nMoneyUnit,itemIndex = LuaFnGetConvenientBuyMoney(sceneId,selfId,11,x891062_g_DayCard,1)
			if nNeedMoney ~= nil then
				local strTips = ScriptGlobal_Format("#{TQJF_221108_45}",
				tostring(x891062_g_DayCard),tostring(nNeedMoney),"#{XFYH_20120221_10}","#{XFYH_20120221_12}",tostring(x891062_g_DayCard))
				
				BeginUICommand( sceneId )
					UICommand_AddInt( sceneId, 2 )
					UICommand_AddInt( sceneId, nMoneyUnit )
					UICommand_AddInt( sceneId, nNeedMoney )
					UICommand_AddInt( sceneId, itemIndex )
					UICommand_AddInt( sceneId, 0 )
					UICommand_AddInt( sceneId, x891062_g_ScriptId )
					UICommand_AddInt( sceneId, 1 )
					UICommand_AddInt( sceneId, -1 )
					UICommand_AddInt( sceneId, 1 )
					UICommand_AddString(sceneId,strTips)
				EndUICommand( sceneId )
				DispatchUICommand( sceneId, selfId, 20120222 )
			
			end
			return
		end
		BeginUICommand( sceneId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 89106201 )
	end
end
--**********************************
--打开副本扫荡UI-子界面
--**********************************
function x891062_OpenSecKillPage(sceneId,selfId,nFubenID,nSpecialSweep)
	--是否在安全时间
	if IsPilferLockFlag(sceneId, selfId)  == -1 then
		x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_40}"  )	
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_42}"  )	
			return
		end
	end
	if LuaFnCTUCheckIsShutDown(sceneId,selfId,x891062_g_CTUID) == 1 then
		x891062_NotifyTip( sceneId, selfId,"#{SJBW_130823_64}"  )	
		return
	end
	--取得当前扫荡的数据
	local isInSecKill,FubenID,BossIndex,DoubleExp,SpecialSweep = LuaFnGetSecKillData(sceneId,selfId)			
	if isInSecKill == 1 and FubenID ~= nFubenID then
		--互斥检测
		local MoneySweep = 0
		local TeQuanSweep = 0
		local YinBiSweep = 0
		if SpecialSweep == 1 then
			MoneySweep = 1
		elseif SpecialSweep == 2 then
			TeQuanSweep = 1
		elseif SpecialSweep == 3 then
			YinBiSweep = 1
		end
		
		if nSpecialSweep == 0 then
			if isInSecKill > 0 and ( MoneySweep == 1 and TeQuanSweep ~= 1 and YinBiSweep ~= 1) then--正在金币扫荡中
				x891062_NotifyTip( sceneId, selfId,"#{JBSD_220210_67}")
				return
			end
			if isInSecKill > 0 and ( MoneySweep ~= 1 and TeQuanSweep == 1 and YinBiSweep ~= 1) then--正在特权扫荡中
				x891062_NotifyTip( sceneId, selfId,"#{TQJF_221108_35}")
				return
			end
			if isInSecKill > 0 and ( MoneySweep ~= 1 and TeQuanSweep ~= 1 and YinBiSweep == 1) then--正在银币扫荡中
				x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_16}")
				return
			end
		elseif nSpecialSweep == 1 then
			if isInSecKill > 0 and ( MoneySweep ~= 1 and TeQuanSweep ~= 1 and YinBiSweep ~= 1 ) then--正在普通扫荡中
				x891062_NotifyTip( sceneId, selfId,"#{JBSD_220210_66}")
				return
			end
			if isInSecKill > 0 and (  TeQuanSweep == 1 ) then--正在特权扫荡中
				x891062_NotifyTip( sceneId, selfId,"#{TQJF_221108_38}")
				return
			end
			if isInSecKill > 0 and (  YinBiSweep == 1 ) then--正在银币扫荡中
				x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_16}")
				return
			end
		elseif nSpecialSweep == 2 then
			if isInSecKill > 0 and ( MoneySweep ~= 1 and TeQuanSweep ~= 1 and YinBiSweep ~= 1)  then--正在普通扫荡中
				x891062_NotifyTip( sceneId, selfId,"#{TQJF_221108_36}")
				return
			end
			if isInSecKill > 0 and ( MoneySweep == 1 )  then--正在金币扫荡中
				x891062_NotifyTip( sceneId, selfId,"#{TQJF_221108_37}")
				return
			end
			if isInSecKill > 0 and ( YinBiSweep == 1 )  then--正在银币扫荡中
				x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_16}")
				return
			end
		elseif nSpecialSweep == 3 then
			if isInSecKill > 0 and ( MoneySweep ~= 1 and TeQuanSweep ~= 1 and YinBiSweep ~= 1) then--正在普通扫荡
				x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_13}")
				return
			end
			if isInSecKill > 0 and ( MoneySweep == 1 ) then--正在金币扫荡
				x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_13}")
				return
			end
			if isInSecKill > 0 and ( TeQuanSweep == 1 ) then--正在特权扫荡
				x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_13}")
				return
			end
		else
			return
		end
	end
	local FuBenIndex = SecKillGetIndex(nFubenID)
	local needLevel,xinfaLev,moneyLevel,szFubenName,SecKillMaxNum,SecKillNeedNum,CanDoubleExp, numYuanbao,numMoney,nAction,nScriptId,nBossNum,isCanYinbi,costYinbi = LuaFnGetSecKillInfoByIndex(FuBenIndex)
	if needLevel == nil then
		x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_63}")
		return
	end
	if nSpecialSweep == 1 then
		if moneyLevel > GetLevel(sceneId,selfId) then
			--JBSD_220210_01	#H大于等于%s0级的玩家才能金币扫荡副本：%s1	
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{JBSD_220210_01}",tostring(moneyLevel),szFubenName))
			return
		end
	elseif nSpecialSweep == 2 then
		--特权扫荡
		local tqmfmonth = GetMissionFlag(sceneId,selfId,MF_TQSD_MONTHCARD)
		local tqmfday = GetMissionFlag(sceneId,selfId,MF_TQSD_DAYCARD)
		if tqmfmonth ~= 1 and tqmfday ~= 1 then
			x891062_NotifyTip( sceneId, selfId, "#{TQJF_221108_13}")
			return
		end
--		if moneyLevel > GetLevel(sceneId,selfId) then
--			--TQJF_221108_39	#H需要等级达到%s0级以上才可进行金币扫荡。	
--			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{TQJF_221108_39}",tostring(moneyLevel)))
--			return
--		end
		--检测今日是否可扫
		local n1week, n2week, n3week,n4week,nPrivilegedExclusive = LuaFnGetSecKillPrivilegedInfoByIndex(FuBenIndex)
		local nweekDay = LuaFnGetThisWeekDay()
		local tequan = 0
		if (nweekDay == n1week ) or ( nweekDay == n2week ) or ( nweekDay == n3week ) or ( nweekDay == n4week )  then
			tequan = 1
		else
			tequan = 0
		end
		if tequan == 0 then
			x891062_NotifyTip( sceneId, selfId,"#{TQJF_221108_47}")
			return
		end
	elseif nSpecialSweep == 3 then
		--银币扫荡
		if needLevel > GetLevel(sceneId,selfId) then
			--YBSD_231107_02	角色等级未达%s0级，无法银符扫荡该副本。	
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{YBSD_231107_02}",tostring(needLevel)))
			return
		end
		if isCanYinbi ~= 1 then
			x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_01}")
			return
		end
	else
		if needLevel > GetLevel(sceneId,selfId) then
			--FBSD_150126_44	#H大于等于%s0级的玩家才能扫荡副本：%s1	
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_44}",tostring(needLevel),szFubenName))
			return
		end
	end
	
	if xinfaLev > 0 then
		--FBSD_150126_45	#H前六本心法等级大于等于%s0级的玩家才能扫荡副本：%s1
		--JBSD_220210_02	#H前六本心法等级大于等于%s0级的玩家才能进行金币扫荡副本：%s1	
		if ScriptGlobal_CheckAllXinfaLevel(sceneId, selfId, xinfaLev) == 0 then
			if nSpecialSweep == 1 then
				x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{JBSD_220210_02}",tostring(xinfaLev),szFubenName))
			else
				x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_45}",tostring(xinfaLev),szFubenName))
			end
			return
		end
	end
	--在扫荡过程中，且是一个副本
	if isInSecKill == 1 and FubenID == nFubenID then
		if nBossNum == BossIndex then
			--目前已经扫荡完了,数据做重置
			LuaFnResetSecKillData(sceneId,selfId)
			--刷新UI
			LuaFnSecKillUpdate( sceneId, selfId );
			--本次副本全部BOSS已被扫荡，本次扫荡结束
			x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_64}")
		end
	end
	--次数是否够了
--	JBSD_220210_34	#H您今日副本金币扫荡次数已经耗尽，无法再次进行金币扫荡。	
--	SDYH_170110_06	#H该副本的每日免费参与次数已经耗尽，无法再次进行扫荡。	
	if isInSecKill ~= 1 then
		local nTodayCount = GetCampaignCountNum(sceneId,selfId,nFubenID)
		if nTodayCount >= nAction then
			if nSpecialSweep == 1 then
				x891062_NotifyTip( sceneId, selfId,"#{JBSD_220210_34}")	
			elseif nSpecialSweep == 2 then
				x891062_NotifyTip( sceneId, selfId,"#{SDYH_170110_06}")	
			else
				x891062_NotifyTip( sceneId, selfId,"#{SDYH_170110_06}")	
			end
			return
		end
	end
	--非金币要进行扫荡点检测
	if nSpecialSweep == 1 then
		--金币扫荡
	elseif nSpecialSweep == 2 then
		--特权扫荡
		local _, _, _,_,nPrivilegedExclusive = LuaFnGetSecKillPrivilegedInfoByIndex(FuBenIndex)
		--判断MD中是否已经记录了两个互斥标记 begin 其实这里直接判断是否进行了两次特权扫荡就行
		local dayCount = GetMissionData(sceneId,selfId,MD_TQSD_DAYCOUNT)
		local alreadyCount = mod(dayCount,10)
		local firstFlag = 0
		local secondFlag = 0
		if (dayCount - alreadyCount)>0 then
			dayCount = (dayCount - alreadyCount)/10
			firstFlag = mod(dayCount,100)
		end
		if (dayCount - firstFlag)>0 then
			secondFlag = (dayCount - firstFlag)/100
		end
		--TQJF_230425_03	每日只能选取两个特权副本进行扫荡。	
		--特权扫荡每日两次，日清 11 22 alreadyCount
		if firstFlag>0 and secondFlag>0 and nPrivilegedExclusive~=firstFlag and nPrivilegedExclusive~=secondFlag then
			x891062_NotifyTip( sceneId, selfId,"#{TQJF_230425_03}")
			return
		end
		if nPrivilegedExclusive~=firstFlag and nPrivilegedExclusive~=secondFlag and alreadyCount == 2 then--点的特权扫荡副本 不是已经特权扫荡过的副本之一 并且 当前已经特权扫荡两次了
			x891062_NotifyTip( sceneId, selfId,"#{TQJF_230425_03}")
			return
		end
	elseif nSpecialSweep == 3 then
		--银币扫荡
	else
		local nCurSweepPoint = LuaFnGetSweepPoint(sceneId,selfId,nFubenID)
		if nCurSweepPoint < SecKillNeedNum then
			x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_52}"  )	
			return
		end
	end

	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,FuBenIndex)		--扫荡id
		UICommand_AddInt( sceneId,nSpecialSweep)	--是否特殊扫荡
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId,20150212)
end

--**********************************
--开启扫荡
--**********************************
function x891062_OnFuBenSecKill(sceneId,selfId,FuBenIndex,nIndex,isDoubleExp,isYuanBao,nSpecialSweep)
	--是否在安全时间
	if IsPilferLockFlag(sceneId, selfId)  == -1 then
		x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_40}"  )	
		return
	end
	--需要二级密码
	if LuaFnIsPasswordSetup( sceneId, selfId, 0 ) == 1 then
		if LuaFnIsPasswordUnlocked( sceneId, selfId, 1 ) == 0 then
			x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_42}"  )	
			return
		end
	end
	if LuaFnCTUCheckIsShutDown(sceneId,selfId,x891062_g_CTUID) == 1 then
		x891062_NotifyTip( sceneId, selfId,"#{SJBW_130823_64}"  )	
		return
	end
	local nFubenID = FuBenIndex - 1
	local needLevel,xinfaLev,moneyLevel,szFubenName,SecKillMaxNum,SecKillNeedNum,CanDoubleExp, numYuanbao,numMoney,nAction,nScriptId,nBossNum,isCanYinbi,costYinbi = LuaFnGetSecKillInfoByIndex(FuBenIndex)
	if needLevel == nil then
		x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_63}")
		return
	end
	if nSpecialSweep == 1 then
		if GetLevel(sceneId, selfId) < moneyLevel then
			--JBSD_220210_01	#H大于等于%s0级的玩家才能金币扫荡副本：%s1	
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{JBSD_220210_01}",tostring(moneyLevel),szFubenName))
			return
		end
		--JBSD_220210_64	#H此副本无法金币扫荡。	
		if numMoney <= 0 then
			x891062_NotifyTip( sceneId, selfId,"#{JBSD_220210_64}"  )	
			return
		end
	elseif nSpecialSweep == 2 then
		--特权扫荡
		local tqmfmonth = GetMissionFlag(sceneId,selfId,MF_TQSD_MONTHCARD)
		local tqmfday = GetMissionFlag(sceneId,selfId,MF_TQSD_DAYCARD)
		if tqmfmonth ~= 1 and tqmfday ~= 1 then
			x891062_NotifyTip( sceneId, selfId, "#{TQJF_221108_13}")
			return
		end
--		if moneyLevel > GetLevel(sceneId,selfId) then
--			--TQJF_221108_39	#H需要等级达到%s0级以上才可进行金币扫荡。	
--			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{TQJF_221108_39}",tostring(moneyLevel)))
--			return
--		end
		--检测今日是否可扫
		local n1week, n2week, n3week,n4week,nPrivilegedExclusive = LuaFnGetSecKillPrivilegedInfoByIndex(FuBenIndex)
		local nweekDay = LuaFnGetThisWeekDay()
		local tequan = 0
		if (nweekDay == n1week ) or ( nweekDay == n2week ) or ( nweekDay == n3week ) or ( nweekDay == n4week )  then
			tequan = 1
		else
			tequan = 0
		end
		if tequan == 0 then
			x891062_NotifyTip( sceneId, selfId,"#{TQJF_221108_47}")
			return
		end
	elseif nSpecialSweep == 3 then
		--银币扫荡
		if needLevel > GetLevel(sceneId,selfId) then
			--YBSD_231107_02	角色等级未达%s0级，无法银符扫荡该副本。	
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{YBSD_231107_02}",tostring(needLevel)))
			return
		end
		if isCanYinbi ~= 1 then
			x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_01}")
			return
		end
	else
		if GetLevel(sceneId, selfId) < needLevel then
			--FBSD_150126_44	#H大于等于%s0级的玩家才能扫荡副本：%s1	
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_44}",tostring(needLevel),szFubenName))
			return
		end
	end
	if xinfaLev > 0 then
		--FBSD_150126_45	#H前六本心法等级大于等于%s0级的玩家才能扫荡副本：%s1	
		if ScriptGlobal_CheckAllXinfaLevel(sceneId, selfId, xinfaLev) == 0 then
			if nSpecialSweep == 1 then
				x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{JBSD_220210_02}",tostring(xinfaLev),szFubenName))
			else
				x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_45}",tostring(xinfaLev),szFubenName))
			end
			return
		end
	end
	if isDoubleExp == 1 and CanDoubleExp ~= 1 then
		--状态非法
		x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_63}")
		return
	end
	if isDoubleExp == 1 then
		--检查元宝是否够
		if YuanBao(sceneId,selfId,selfId,3,0) < numYuanbao then
			x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_56}"  )	
			return
		end
		if LuaFnIsCanYuanBaoCost(sceneId,selfId,numYuanbao) ~= 1 then
			x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_57}"  )	
			return
		end
	end
	--取得当前扫荡的数据
	local isInSecKill,FubenID,BossIndex,DoubleExp,SpecialSweep,Jinbidaibi,YinbiDaibi = LuaFnGetSecKillData(sceneId,selfId)
	if isInSecKill == 1 and FubenID ~= nFubenID then
		--有副本在扫荡但是不是当前副本-非法
		x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_63}"  )	
		return
	end
	--检查点击的BOSS是否是当前BOSS
	if BossIndex ~= nIndex - 1 then
		--FBSD_150126_48 该BOSS已经扫荡过，请重新选择需要扫荡的BOSS
		--FBSD_150126_49  BOSS需顺次扫荡，请重新选择需要扫荡的BOSS
--		JBSD_220210_42	#H该BOSS已经金币扫荡过，请重新选择需要金币扫荡的BOSS。	
--		JBSD_220210_43	#HBOSS需顺次金币扫荡，请重新选择需要金币扫荡的BOSS。	
		if nSpecialSweep == 1 then
			x891062_NotifyTip( sceneId, selfId,"#{JBSD_220210_43}"  )
		else
			x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_49}"  )
		end
		return	
	end
	--还有物品
	for i = 1,x891062_g_SweepPage_ITEM_NUM do
		local nItemID,nItemNum = LuaFnGetSeckillItem(sceneId,selfId,i - 1)
		if nItemID > 0 then
			--JBSD_220210_41	#H请把金币扫荡背包内的物品全部放入背包内，再进行金币扫荡。	
			if nSpecialSweep == 1 then
				x891062_NotifyTip( sceneId, selfId,"#{JBSD_220210_41}")
			else
				x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_47}")
			end
			return
		end
	end
	--互斥检测
	if isInSecKill > 0 then
		if SpecialSweep ~= nSpecialSweep then
			--互斥检测
			local MoneySweep = 0
			local TeQuanSweep = 0
			local YinBiSweep = 0
			if SpecialSweep == 1 then
				MoneySweep = 1
			elseif SpecialSweep == 2 then
				TeQuanSweep = 1
			elseif SpecialSweep == 3 then
				YinBiSweep = 1
			end
			
			if nSpecialSweep == 0 then
				if isInSecKill > 0 and ( MoneySweep == 1 and TeQuanSweep ~= 1 and YinBiSweep ~= 1) then--正在金币扫荡中
					x891062_NotifyTip( sceneId, selfId,"#{JBSD_220210_67}")
					return
				end
				if isInSecKill > 0 and ( MoneySweep ~= 1 and TeQuanSweep == 1 and YinBiSweep ~= 1) then--正在特权扫荡中
					x891062_NotifyTip( sceneId, selfId,"#{TQJF_221108_35}")
					return
				end
				if isInSecKill > 0 and ( MoneySweep ~= 1 and TeQuanSweep ~= 1 and YinBiSweep == 1) then--正在银币扫荡中
					x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_16}")
					return
				end
			elseif nSpecialSweep == 1 then
				if isInSecKill > 0 and ( MoneySweep ~= 1 and TeQuanSweep ~= 1 and YinBiSweep ~= 1 ) then--正在普通扫荡中
					x891062_NotifyTip( sceneId, selfId,"#{JBSD_220210_66}")
					return
				end
				if isInSecKill > 0 and (  TeQuanSweep == 1 ) then--正在特权扫荡中
					x891062_NotifyTip( sceneId, selfId,"#{TQJF_221108_38}")
					return
				end
				if isInSecKill > 0 and (  YinBiSweep == 1 ) then--正在银币扫荡中
					x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_16}")
					return
				end
			elseif nSpecialSweep == 2 then
				if isInSecKill > 0 and ( MoneySweep ~= 1 and TeQuanSweep ~= 1 and YinBiSweep ~= 1)  then--正在普通扫荡中
					x891062_NotifyTip( sceneId, selfId,"#{TQJF_221108_36}")
					return
				end
				if isInSecKill > 0 and ( MoneySweep == 1 )  then--正在金币扫荡中
					x891062_NotifyTip( sceneId, selfId,"#{TQJF_221108_37}")
					return
				end
				if isInSecKill > 0 and ( YinBiSweep == 1 )  then--正在银币扫荡中
					x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_16}")
					return
				end
			elseif nSpecialSweep == 3 then
				if isInSecKill > 0 and ( MoneySweep ~= 1 and TeQuanSweep ~= 1 and YinBiSweep ~= 1) then--正在普通扫荡
					x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_13}")
					return
				end
				if isInSecKill > 0 and ( MoneySweep == 1 ) then--正在金币扫荡
					x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_13}")
					return
				end
				if isInSecKill > 0 and ( TeQuanSweep == 1 ) then--正在特权扫荡
					x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_13}")
					return
				end
			else
				return
			end
		end
	end
	--第一个图标
	if nIndex == 1 then
		--次数是否够了
		local nTodayCount = GetCampaignCountNum(sceneId,selfId,nFubenID)
		if nTodayCount >= nAction then
			if nSpecialSweep == 1 then
				x891062_NotifyTip( sceneId, selfId,"#{JBSD_220210_35}")	
			elseif nSpecialSweep == 2 then
				x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_50}")
			elseif nSpecialSweep == 3 then
				x891062_NotifyTip( sceneId, selfId,"#{YBSD_231107_15}")	
			else
				x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_50}")	
			end
			return
		end
		if nSpecialSweep == 1 then
			--查钱和扣钱
			local nMoneySelf = GetMoney(sceneId,selfId)
			if nMoneySelf < numMoney then
				x891062_NotifyTip( sceneId, selfId, "#{JBSD_220210_33}" )
				return
			end	
			CostMoney(sceneId, selfId, numMoney)
		elseif nSpecialSweep == 2 then
			--特权扫荡
			local _, _, _,_,nPrivilegedExclusive = LuaFnGetSecKillPrivilegedInfoByIndex(FuBenIndex)
			--判断MD中是否已经记录了两个互斥标记 begin 其实这里直接判断是否进行了两次特权扫荡就行
			local dayCount = GetMissionData(sceneId,selfId,MD_TQSD_DAYCOUNT)
			local alreadyCount = mod(dayCount,10)
			local firstFlag = 0
			local secondFlag = 0
			if (dayCount - alreadyCount)>0 then
				dayCount = (dayCount - alreadyCount)/10
				firstFlag = mod(dayCount,100)
			end
			if (dayCount - firstFlag)>0 then
				secondFlag = (dayCount - firstFlag)/100
			end
			--TQJF_230425_03	每日只能选取两个特权副本进行扫荡。	
			--特权扫荡每日两次，日清 11 22 alreadyCount
			if firstFlag>0 and secondFlag>0 and nPrivilegedExclusive~=firstFlag and nPrivilegedExclusive~=secondFlag then
				x891062_NotifyTip( sceneId, selfId,"#{TQJF_230425_03}")
				return
			end
			if nPrivilegedExclusive~=firstFlag and nPrivilegedExclusive~=secondFlag and alreadyCount == 2 then--点的特权扫荡副本 不是已经特权扫荡过的副本之一 并且 当前已经特权扫荡两次了
				x891062_NotifyTip( sceneId, selfId,"#{TQJF_230425_03}")
				return
			end
			if firstFlag == 0 and secondFlag ~= nPrivilegedExclusive then
				firstFlag = nPrivilegedExclusive
				alreadyCount = alreadyCount + 1
			elseif secondFlag == 0 and firstFlag ~= nPrivilegedExclusive then
				secondFlag = nPrivilegedExclusive
				alreadyCount = alreadyCount + 1
			end
			local dayCount = secondFlag * 1000 + firstFlag * 10 + alreadyCount
			SetMissionData(sceneId, selfId, MD_TQSD_DAYCOUNT, dayCount)
		elseif nSpecialSweep == 3 then
			--查钱和扣钱
			if YinbiDaibi < costYinbi then
				if Jinbidaibi < costYinbi then
					local nMoneySelf = GetMoney(sceneId,selfId)
					if nMoneySelf < costYinbi then
						x891062_NotifyTip( sceneId, selfId, "#{YBSD_231107_11}" )
						return
					else
						CostMoney(sceneId, selfId, costYinbi)
					end
				else
					LuaFnSetSecKillJinBi(sceneId,selfId,Jinbidaibi - costYinbi )
				end
			else
				LuaFnSetSecKillYinBi(sceneId,selfId,YinbiDaibi - costYinbi )
			end
		else
			--扫荡点检测
			local nCurSweepPoint = LuaFnGetSweepPoint(sceneId,selfId,nFubenID)
			if nCurSweepPoint < SecKillNeedNum then
				x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_52}"  )	
				return
			end
			--增加次数&扣除扫荡点
			LuaFnSetSweepPoint(sceneId,selfId,nFubenID,nCurSweepPoint - SecKillNeedNum)
		end
		--增加活动次数
		AddCampaignCountNum(sceneId,selfId,nFubenID)
	end
	--双倍
	if DoubleExp == 1 or isDoubleExp == 1 then
		DoubleExp = 1
		if nIndex == 1 then
			--扣除元宝
			if LuaFnCostYuanBao(sceneId,selfId,numYuanbao,891062,"OnFuBenSecKill",0,0) ~= 1 then
				return
			end
		end
	end
	--获取BOSS或者普通怪的DataId
	local nMonsterDataID,isBoss = CallScriptFunction( nScriptId, "GetFubenMonsterDataId",sceneId, selfId ,nIndex)
	if nMonsterDataID == nil or nMonsterDataID <= 0 then
		return
	end
	--进入扫荡状态
	LuaFnSetSecKillData(sceneId,selfId,nFubenID,nIndex,DoubleExp,nSpecialSweep)
	--进行扫荡
	local nRet,nGainExp,nDropNum = LuaFnSecKillGenNewByMonsterDataId(sceneId,selfId,nMonsterDataID,isBoss,nSpecialSweep)
	if nRet == 0 then
		--这里是非法状态，要报错
		x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_63}"  )	
		return
	end
	--提示信息
	--FBSD_150126_58	#H成功扫荡BOSS：%s0，请尽快把扫荡背包内的道具放入背包。	
	--FBSD_150126_59	#H成功扫荡BOSS：%s0，因开启双倍经验扫荡，所获经验为双倍经验。
	--JBSD_220210_58	#H成功金币扫荡BOSS：%s0，请尽快把金币扫荡背包内的道具放入背包。	
	
	local strBossName = LuaFnGetSecKillBossInfoByIndex(FuBenIndex,nIndex - 1)
	if DoubleExp == 1 then
		x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_59}",strBossName))
	else
		if nSpecialSweep == 1 then
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{JBSD_220210_58}",strBossName))
		elseif nSpecialSweep == 2 then
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_58}",strBossName))
		else
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_58}",strBossName))
		end
	end
	--最后一个做结束处理
--	FBSD_150126_87	#H你获得BOSS经验：%s0，同时获得经验奖励：%s1。	
--	FBSD_150126_88	#H你获得普通怪物经验：%s0，同时获得经验奖励：%s1。	
--	FBSD_150126_90	你获得BOSS经验：%s0	
--	FBSD_150126_91	你获得普通怪物经验：%s0
	if nIndex == nBossNum  then
		LuaFnResetSecKillData(sceneId,selfId)
		--本次副本全部BOSS已被扫荡，本次扫荡结束
		--JBSD_220210_61	#H本次副本全部BOSS已被金币扫荡，本次金币扫荡结束。
		if nSpecialSweep == 1 then
			x891062_NotifyTip( sceneId, selfId,"#{JBSD_220210_61}")
		elseif nSpecialSweep == 2 then
			x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_64}")
			--特权给予扫荡点
			x891062_OnFinish(sceneId, selfId, nFubenID)
		else
			x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_64}")
		end
		--BOSS
		if DoubleExp == 1 then
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_87}",tostring(nGainExp),tostring(nGainExp)))
			nGainExp = nGainExp * 2
		else
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_90}",tostring(nGainExp)))
		end
	else
		--普通怪物
		if DoubleExp == 1 then
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_88}",tostring(nGainExp),tostring(nGainExp)))
			nGainExp = nGainExp * 2
		else
			x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_91}",tostring(nGainExp)))
		end
	end
	AddExp( sceneId, selfId, nGainExp );
	--刷新UI
	LuaFnSecKillUpdate( sceneId, selfId );
end

--**********************************
--继续副本扫荡
--**********************************
function x891062_OnContinueFuBenSecKill(sceneId, selfId, nFubenID,nSpecialSweep)
	x891062_OpenSecKillPage(sceneId,selfId,nFubenID,nSpecialSweep)
end

--**********************************
--副本完成 
--副本ID为 CAMPAIGN_ 开头的全局定义
--**********************************
function x891062_OnFinish(sceneId, selfId, nFubenID)
	local nLevelIdx = 0
	local nCurLevel = GetLevel(sceneId,selfId)
	if nCurLevel < 40 then
		nLevelIdx = 0
	else
		nLevelIdx = floor((nCurLevel - 40) / 10)
	end
	local nAddPoint = LuaFnGetSecKillSweepPointAddById(nFubenID,nLevelIdx)
	if nAddPoint == nil then
		return
	end
	local FuBenIndex = SecKillGetIndex(nFubenID)
	local needLevel,_,moneyLevel,szFubenName,SecKillMaxNum = LuaFnGetSecKillInfoByIndex(FuBenIndex)
	if needLevel == nil then
		--副本不存在
		return
	end
	--扫荡点检测
	local nCurSweepPoint = LuaFnGetSweepPoint(sceneId,selfId,nFubenID)
	if nCurSweepPoint >= SecKillMaxNum then
		--达到上限
		x891062_NotifyTip( sceneId, selfId,"#{FBSD_150126_05}")
		return
	end
	if nCurSweepPoint + nAddPoint > SecKillMaxNum then
		nAddPoint = SecKillMaxNum - nCurSweepPoint
		x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_170228_02}",tostring(nAddPoint),tostring(SecKillMaxNum)))
	else
		x891062_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{FBSD_150126_06}",tostring(nAddPoint),tostring(nCurSweepPoint + nAddPoint)))
	end
	LuaFnSetSweepPoint(sceneId,selfId,nFubenID,nCurSweepPoint + nAddPoint)
	--这里后面考虑要加审计日志
	
end

--**********************************
--提示
--**********************************
function x891062_NotifyTip(sceneId, selfId, msg)
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
