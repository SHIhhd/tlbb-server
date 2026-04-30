--�ܻ�Ծ����ϵͳ

x800121_g_ScriptId = 800121
--������͵ȼ�
x800121_g_MinLevel = 35
--�ܻ�Ծ���޻�Ծ��
x800121_g_ZhouHuoYueMax = 2200
--�ܻ�Ծ�����޻�Ծ��
x800121_g_ZhouHuoYueDayMax = 2200
--˫����Ծֵʱ��
x800121_g_DouStartTime = 20210930
x800121_g_DouEndTime = 20211007
--������Ʒ
x800121_g_ZhouHuoYueItemId = {
	[1] = {item = 30900006, num = 2},
	[2] = {item = 38010158, num = 1},
	[3] = {item = 30503133, num = 1},
	[4] = {item = 38010158, num = 1},
	[5] = {item = 20310168, num = 3},
	[6] = {item = 38010158, num = 1},
	[7] = {item = 30502002, num = 2},
	[8] = {item = 38010158, num = 1},
	[9] = {item = 20502002, num = 1},
	[10] = {item = 38010158, num = 1},
	[11] = {item = 20501002, num = 1},
	[12] = {item = 38010158, num = 1},
	[13] = {item = 50213004, num = 1},
	[14] = {item = 38010158, num = 1},
	[15] = {item = 20310168, num = 5},
	[16] = {item = 38010158, num = 3},
	[17] = {item = 20800013, num = 5},
	[18] = {item = 38010158, num = 3},
	[19] = {item = 38002221, num = 1},
	[20] = {item = 38010158, num = 3},
}
--���ȹ���
x800121_g_ProcessLimit = {
	[1] = {neednum = 100, itemspace = 2, materialspace = 0},
	[2] = {neednum = 200, itemspace = 2, materialspace = 0},
	[3] = {neednum = 300, itemspace = 1, materialspace = 1},
	[4] = {neednum = 400, itemspace = 2, materialspace = 0},
	[5] = {neednum = 500, itemspace = 1, materialspace = 1},
	[6] = {neednum = 600, itemspace = 1, materialspace = 1},
	[7] = {neednum = 700, itemspace = 1, materialspace = 1},
	[8] = {neednum = 800, itemspace = 1, materialspace = 1},
	[9] = {neednum = 900, itemspace = 1, materialspace = 1},
	[10] = {neednum = 1000, itemspace = 2, materialspace = 0},
}
--**********************************
--�ͻ����������ĳ��
--**********************************
function x800121_AddHuoYueZhi(sceneId,selfId,nIndex)
	if GetLevel(sceneId,selfId) < x800121_g_MinLevel then
		x800121_NotifyTip( sceneId, selfId, "#{ZHY_210301_02}" )
		return
	end
	local nIndex, nBigClass, nSmallClass, nSmallClassIndex, strName, nNeedTimes, nHuoYueZhi, nLevel = Lua_GetZhouHuoYueInfo(nIndex-1)
	if nIndex == nil then
		return
	end
	--�ж��ȼ�
	if GetLevel(sceneId,selfId) < nLevel then
		return
	end
	--�Ѵ�������
	local nWeekActiveP = LuaFnGetWeekActivePoint(sceneId,selfId)
	if nWeekActiveP >= x800121_g_ZhouHuoYueMax then
		x800121_NotifyTip( sceneId, selfId, "#{ZHY_210301_14}" )
		return
	end
	--�ﵽ������
	local nDayActiveP = LuaFnGetTodayActivePoint(sceneId,selfId)
	if nDayActiveP >= x800121_g_ZhouHuoYueDayMax then
		x800121_NotifyTip( sceneId, selfId, "#{ZHY_210301_69}" )
		--����ֵ���졿��ʾ����
		x800121_NotifyTip( sceneId, selfId, "#{SFJN_231225_2}" )
		return
	end
	--����ʱ�λ�Ծ�ȷ���
	local nTimeDay = GetTime2Day()
	if nTimeDay >= x800121_g_DouStartTime and nTimeDay <= x800121_g_DouEndTime then
		nHuoYueZhi = nHuoYueZhi * 2
	end
	--�ж��Ƿ���ɵ�ǰ�׶�
	local nSmallClassMaxIndex = Lua_GetZhouHuoYueSmallClassMax(nSmallClass)
	if nSmallClassMaxIndex == nil then
		return
	end
	local nGetAwardInfo = Lua_GetZhouHuoYueNum(sceneId,selfId,nSmallClass-1)
	local nProcessInfo = Lua_GetZhouHuoYueProcess(sceneId,selfId,nSmallClass-1)
	if  nProcessInfo == nSmallClassIndex - 1 and nGetAwardInfo >= nNeedTimes then
		--����ȡ
		--��������һ�׶�
		if nSmallClassIndex < nSmallClassMaxIndex then
			--�����׶��ڵļ���
			Lua_SetZhouHuoYueNum(sceneId,selfId,nSmallClass-1,0)
		end
		--��Ǳ��׶����
		Lua_SetZhouHuoYueProcess(sceneId,selfId,nSmallClass-1,nProcessInfo + 1)
		--������ɺ����ڵĻ�Ծֵ�Ƿ񳬱�
		if nHuoYueZhi + nDayActiveP > x800121_g_ZhouHuoYueDayMax then
			--�����µĻ�Ծֵ
			nHuoYueZhi = x800121_g_ZhouHuoYueDayMax - nDayActiveP
			x800121_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{ZHY_210301_72}",tostring(nHuoYueZhi)) )
			--����ֵ���졿��ʾ����
			x800121_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{SFJN_231225_3}",tostring(nHuoYueZhi)) )
		else
			x800121_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{ZHY_210301_15}",tostring(nHuoYueZhi)) )
		end
		--���ӻ�Ծֵ
		LuaFnAddWeekActivePoint(sceneId,selfId,nHuoYueZhi)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,49,0)
		UpdateZhouHuoYueInfo(sceneId,selfId)
		--����ֵ������
		x800121_AddIBPower(sceneId,selfId,nHuoYueZhi)
	else
		x800121_NotifyTip( sceneId, selfId, "#{ZHY_210301_13}" )
	end
end
--**********************************
--����ֵ���졿������ֵ
--**********************************
x800121_g_MAX_IBPOWER = 2000
function x800121_AddIBPower(sceneId,selfId,nPower)
	local nIBPower = LuaFnGetIBPower(sceneId,selfId)
	if nIBPower >= x800121_g_MAX_IBPOWER then
		x800121_NotifyTip( sceneId, selfId, "#{SFJN_231225_65}" )
		return
	end
	if nIBPower + nPower > x800121_g_MAX_IBPOWER then
		--�����µ���ֵ
		nPower = x800121_g_MAX_IBPOWER - nIBPower
		x800121_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{SFJN_231225_64}",tostring(nPower)) )
	else
		x800121_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{SFJN_231225_4}",tostring(nPower)) )
	end
	LuaFnSetIBPower(sceneId,selfId,nIBPower + nPower)
end
--**********************************
--�ͻ���������ȡ�ܻ�Ծ����
--**********************************
function x800121_GetZhouHuoYueAward(sceneId,selfId)
	if GetLevel(sceneId,selfId) < x800121_g_MinLevel then
		x800121_NotifyTip( sceneId, selfId, "#{ZHY_210301_02}" )
		return
	end
	local nCurAwardIdx = LuaFnGetWeekAwardInfo(sceneId,selfId)
	--������
	if nCurAwardIdx >= getn(x800121_g_ProcessLimit) then
		x800121_NotifyTip( sceneId, selfId, "#{ZHY_210301_31}" )
		return
	end
	local nCanPrizeIdx = 0
	local nWeekActiveP = LuaFnGetWeekActivePoint(sceneId,selfId)
	for i = 1,getn(x800121_g_ProcessLimit) do
		if nWeekActiveP >= x800121_g_ProcessLimit[i].neednum and nCurAwardIdx < i then
			nCanPrizeIdx = i
			break
		end
	end
	if nCanPrizeIdx == 0 then
		x800121_NotifyTip( sceneId, selfId, "#{ZHY_210301_31}" )
		return
	end
	--���㱳���ռ��Ƿ��㹻
	local nNeedItemSpace = x800121_g_ProcessLimit[nCanPrizeIdx].itemspace
	local nNeedMatSpace = x800121_g_ProcessLimit[nCanPrizeIdx].materialspace
	if nNeedItemSpace > 0 and nNeedMatSpace > 0  then
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < nNeedItemSpace
			or LuaFnGetMaterialBagSpace(sceneId,selfId) < nNeedMatSpace then
			x800121_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{ZHY_210301_19}",tostring(nNeedItemSpace),tostring(nNeedMatSpace)))
			return
		end
	elseif nNeedItemSpace > 0 and nNeedMatSpace == 0  then
		if LuaFnGetPropertyBagSpace(sceneId,selfId) < nNeedItemSpace then
			x800121_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{ZHY_210301_17}",tostring(nNeedItemSpace)))
			return
		end
	elseif nNeedItemSpace == 0 and nNeedMatSpace > 0  then
		if LuaFnGetMaterialBagSpace(sceneId,selfId) < nNeedMatSpace then
			x800121_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{ZHY_210301_18}",tostring(nNeedMatSpace)))
			return
		end
	end
	--������Ʒ
	local nItemPosB = nCanPrizeIdx * 2
	local nItemPosA = nItemPosB - 1
	for i = 1,x800121_g_ZhouHuoYueItemId[nItemPosA].num do
		LuaFnTryRecieveSingleItem(sceneId,selfId,x800121_g_ZhouHuoYueItemId[nItemPosA].item,1,1)
	end
	x800121_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{ZHY_210301_20}",tostring(x800121_g_ZhouHuoYueItemId[nItemPosA].num),GetItemName(sceneId,x800121_g_ZhouHuoYueItemId[nItemPosA].item)))
	
	for i = 1,x800121_g_ZhouHuoYueItemId[nItemPosB].num do
		LuaFnTryRecieveSingleItem(sceneId,selfId,x800121_g_ZhouHuoYueItemId[nItemPosB].item,1,1)
	end
	x800121_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{ZHY_210301_20}",tostring(x800121_g_ZhouHuoYueItemId[nItemPosB].num),GetItemName(sceneId,x800121_g_ZhouHuoYueItemId[nItemPosB].item)))
	--������ȡ���
	LuaFnSetWeekAwardInfo(sceneId,selfId,nCurAwardIdx + 1)
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,49,0)
	
	
	
	UpdateZhouHuoYueInfo(sceneId,selfId)
end
--**********************************
--�ͻ��������UI
--**********************************
function x800121_OpenUI(sceneId,selfId)
	if GetLevel(sceneId,selfId) < x800121_g_MinLevel then
		x800121_NotifyTip( sceneId, selfId, "#{ZHY_210301_02}" )
		return
	end
	OpenZhouHuoYueInfo(sceneId,selfId)
end
--**********************************
--�������
--**********************************
function x800121_CheckQuickAndRedPoint(sceneId,selfId)
	if GetLevel(sceneId,selfId) < x800121_g_MinLevel then
		return
	end
	local nMaxRecord = Lua_GetZhouHuoYueMaxRecord()
	if nMaxRecord <= 0 then
		return
	end
	for i = 1,nMaxRecord do
		local nIndex, _, nSmallClass, nSmallClassIndex, _, nNeedTimes, _, nLevel = Lua_GetZhouHuoYueInfo(i-1)
		if nIndex ~= nil then
			
			if GetLevel(sceneId,selfId) >= nLevel then
				local nGetAwardInfo = Lua_GetZhouHuoYueNum(sceneId,selfId,nSmallClass-1)
				local nProcessInfo = Lua_GetZhouHuoYueProcess(sceneId,selfId,nSmallClass-1)
				if  nProcessInfo == nSmallClassIndex - 1 and nGetAwardInfo >= nNeedTimes then
					--�򿪿ͻ��˿�����(�����)
					x800121_UpdateClientQuick(sceneId,selfId,1,1)
					return
				end
			end
			
		end
	end
	--�򿪿ͻ��˿�����
	x800121_UpdateClientQuick(sceneId,selfId,1,0)
end
--**********************************
--�ͻ��˿�����״̬����
--**********************************
function x800121_UpdateClientQuick(sceneId,selfId,bShow,bShowHotpoint)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, bShow )
		UICommand_AddInt( sceneId, bShowHotpoint )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 80012101 )		
end
--**********************************
--��Ŀ��ʾ
--**********************************
function x800121_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end