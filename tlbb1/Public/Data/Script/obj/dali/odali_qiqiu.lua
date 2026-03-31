--祈福气球占用
x002107_g_scriptId = 002107

--所拥有的事件ID列表
x002107_g_eventList={}
--放飞总时间
x002107_g_BallReleasetime = 7200
--最大祝福次数
x002107_g_Blessingmaxcount = 66
--用于存储玩家guid
x002107_g_NPCParam_GUID = 0
--祝福次数
x002107_g_NPCParam_Blessingcount = 1
--剩余放飞时间
x002107_g_NPCParam_Releasetime = 2
--祝福所选的str5个
x002107_g_NPCParam_stridx = 3
x002107_g_NPCParam_stridx2 = 4
x002107_g_NPCParam_stridx3 = 5
x002107_g_NPCParam_stridx4 = 6
x002107_g_NPCParam_stridx5 = 7
--祝福一次的基础经验值
x002107_g_BasicExp = 66
--祝福毛笔
x002107_g_ZhuFuMaoBi = 38000046
--祝福最低等级限制
x002107_g_Blessingminlevel = 15
--**********************************
--事件列表
--**********************************
function x002107_UpdateEventList( sceneId, selfId,targetId )
	local blessing_1,blessing_2,blessing_3,blessing_4,blessing_5 = "","","","",""
	local Wishstr,Wishstr2,Wishstr3,Wishstr4,Wishstr5 = "","","","",""
	local idx = LuaFnGetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_stridx)
	local idx_2 = LuaFnGetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_stridx2)
	local idx_3 = LuaFnGetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_stridx3)
	local idx_4 = LuaFnGetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_stridx4)
	local idx_5 = LuaFnGetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_stridx5)
	local Releasetime = LuaFnGetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_Releasetime)
	local Blessingcount = LuaFnGetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_Blessingcount)
	--达到66次，气球禁止交互。
	if Blessingcount >= 66 then
		return
	end
	if idx > 0 then
		_,Wishstr = GetWishStringById(idx)
		blessing_1 = "#gFF8F59#{TGQF_100111_62}"..Wishstr
	end
	if idx_2 > 0 then
		_,Wishstr2 = GetWishStringById(idx_2)
		blessing_2 = "#e000066#gFFF5EE#{TGQF_100111_63}"..Wishstr2
	end
	if idx_3 > 0 then
		_,Wishstr3 = GetWishStringById(idx_3)
		blessing_3 = "#e330000#gFFD700#{TGQF_100111_64}"..Wishstr3
	end
	if idx_4 > 0 then
		_,Wishstr4 = GetWishStringById(idx_4)
		blessing_4 = "#e336600#gFFF0F5#{TGQF_100111_65}"..Wishstr4
	end
	if idx_5 > 0 then
		_,Wishstr5 = GetWishStringById(idx_5)
		blessing_5 = "#e330066#gFFFF00#{TGQF_100111_66}"..Wishstr5
	end
	Releasetime = floor(Releasetime / 60)
	BeginEvent(sceneId)
		AddText(sceneId,blessing_1)
		AddText(sceneId,blessing_2)
		AddText(sceneId,blessing_3)
		AddText(sceneId,blessing_4)
		AddText(sceneId,blessing_5)
		AddText(sceneId,ScriptGlobal_Format("#{TGQF_XML_45}",Releasetime))
		AddText(sceneId,ScriptGlobal_Format("#{TGQF_XML_46}",Blessingcount))
		if Blessingcount < 5 then
			AddNumText(sceneId,x002107_g_scriptId,"#{TGQF_XML_47}",6,1)
		else
			AddNumText(sceneId,x002107_g_scriptId,"#{TGQF_XML_48}",6,2)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002107_OnDefaultEvent( sceneId, selfId,targetId )
	x002107_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002107_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nNumText = GetNumText();
	local WishNum = GetWishStringNum()
	local nSex;
	local WishType,Wishstr;
	local Blessingcount = LuaFnGetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_Blessingcount)
	local MosDataID = GetMonsterDataID(sceneId,targetId)
	local QiQiuidx = 0
	--选择祝福语句
	if nNumText == 1 then
		if Blessingcount < 5 then
			BeginEvent(sceneId)
				local randomIndex = {}
				for i = 1, WishNum do
					tinsert(randomIndex, i)
				end
				for i = getn(randomIndex), 2, -1 do
					local j = random(i)
					randomIndex[i], randomIndex[j] = randomIndex[j], randomIndex[i]
				end
				local selectedIndexes = {}
				for j = 3, 7 do
					local selectedIndex = LuaFnGetNpcIntParameter(sceneId, targetId, j)
					if selectedIndex ~= 0 then
						selectedIndexes[selectedIndex] = selectedIndex
					end
				end
				for i, index in randomIndex do
					WishType, WishStr = GetWishStringById(index)
					-- 防止选项冲突以及设置nSex的逻辑
					if MosDataID >= 14410 and MosDataID <= 14416
					or MosDataID >= 14431 and MosDataID <= 14437 then
						nSex = GetSex(sceneId, selfId)
					elseif MosDataID >= 14417 and MosDataID <= 14423 then
						nSex = 2
					elseif MosDataID >= 14424 and MosDataID <= 14430 then
						nSex = 3
					end
					if WishType == nSex then
						--加载之前查重
						if index ~= selectedIndexes[index] then
							AddNumText(sceneId, x002107_g_scriptId, WishStr, 6, index + 1000)
						end
					end
				end
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			x002107_ShowNotice(sceneId,selfId,"#{TGQF_100111_67}")
			return
		end
	end
	--我也要祝福他们
	if nNumText == 2 then
		if GetLevel(sceneId,selfId) < x002107_g_Blessingminlevel then
			x002107_ShowNotice(sceneId,selfId,"#{TGQF_100111_50}")
			return
		end
		--检测毛笔
		if LuaFnGetAvailableItemCount(sceneId,selfId,x002107_g_ZhuFuMaoBi) < 1 then
			x002107_ShowNotice(sceneId,selfId,"#{TGQF_100111_51}")
			return
		end
		if LuaFnDelAvailableItem(sceneId,selfId,x002107_g_ZhuFuMaoBi,1) ~= 1 then
			x002107_ShowNotice(sceneId,selfId,"#{TGQF_100111_51}")
			return
		end
		--以上检测结束，开始祝福啦
		--记录祝福次数
		Blessingcount = Blessingcount + 1
		LuaFnSetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_Blessingcount,Blessingcount)
		if Blessingcount < 66 then
			if mod(Blessingcount,10) == 6 then
				if Blessingcount == 6 then
					QiQiuidx = 1;
				elseif Blessingcount == 16 then
					QiQiuidx = 2;
				elseif Blessingcount == 26 then
					QiQiuidx = 3;
				elseif Blessingcount == 36 then
					QiQiuidx = 4;
				elseif Blessingcount == 46 then
					QiQiuidx = 5;
				elseif Blessingcount == 56 then
					QiQiuidx = 6;
				end
				if MosDataID >= 14410 and MosDataID <= 14416
				or MosDataID >= 14431 and MosDataID <= 14437 then
					SetMonsterDataID(sceneId,targetId,MosDataID + QiQiuidx)
				elseif MosDataID >= 14417 and MosDataID <= 14423 then
					SetMonsterDataID(sceneId,targetId,MosDataID + QiQiuidx)
				elseif MosDataID >= 14424 and MosDataID <= 14430 then
					SetMonsterDataID(sceneId,targetId,MosDataID + QiQiuidx)
				end
				--气球发生变化
				x002107_ShowNotice(sceneId,selfId,ScriptGlobal_Format("#{TGQF_100111_54}",Blessingcount))
				LuaFnAddExp(sceneId,selfId,x002107_g_BasicExp * GetLevel(sceneId,selfId) * 2)
				--变大操作
				x002107_ShowNotice(sceneId,selfId,"#{TGQF_100111_55}")
			else
				x002107_ShowNotice(sceneId,selfId,ScriptGlobal_Format("#{TGQF_100111_53}",Blessingcount))
				LuaFnAddExp(sceneId,selfId,x002107_g_BasicExp * GetLevel(sceneId,selfId))
			end
		else
			x002107_ShowNotice(sceneId,selfId,"#{TGQF_100111_56}")
			LuaFnAddExp(sceneId,selfId,x002107_g_BasicExp * GetLevel(sceneId,selfId) * 5)
			x002107_ShowNotice(sceneId,selfId,"#{TGQF_100111_57}")
			AddGlobalCountNews(sceneId,ScriptGlobal_Format("#{TGQF_100111_58}",GetCharacterTitle(sceneId,targetId)))
			--满地送大箱子
			local PlayerX = GetHumanWorldX(sceneId,selfId)
			local PlayerZ = GetHumanWorldZ(sceneId,selfId)
			x002107_OnGiveDropBox(sceneId,PlayerX,PlayerZ) --生成一地财宝
			--达到66次，放飞
			MonsterDoAction(sceneId,targetId,25,-1)
			SetCharacterDieTime(sceneId,targetId,5000)
			--数据全部清空。
			LuaFnSetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_GUID,0)
			LuaFnSetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_Releasetime,0)
			LuaFnSetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_stridx,0)
			LuaFnSetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_stridx2,0)
			LuaFnSetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_stridx3,0)
			LuaFnSetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_stridx4,0)
			LuaFnSetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_stridx5,0)
		end
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,1000)
	end
	--防止选项冲突，范围扩大。
	if nNumText >= 1000 and nNumText < 2000 then
		if GetLevel(sceneId,selfId) < x002107_g_Blessingminlevel then
			x002107_ShowNotice(sceneId,selfId,"#{TGQF_100111_50}")
			return
		end
		--检测毛笔
		if LuaFnGetAvailableItemCount(sceneId,selfId,x002107_g_ZhuFuMaoBi) < 1 then
			x002107_ShowNotice(sceneId,selfId,"#{TGQF_100111_51}")
			return
		end
		if Blessingcount >= 5 then
			x002107_ShowNotice(sceneId,selfId,"#{TGQF_100111_67}")
			BeginUICommand(sceneId)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId,1000)
			return
		end
		if LuaFnDelAvailableItem(sceneId,selfId,x002107_g_ZhuFuMaoBi,1) ~= 1 then
			x002107_ShowNotice(sceneId,selfId,"#{TGQF_100111_51}")
			return
		end
		--记录祝福次数
		LuaFnSetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_Blessingcount,Blessingcount + 1)
		--加入txt选项
		if nNumText < 1010 then
			nNumText = mod(nNumText,10)
		else
			nNumText = mod(nNumText,100)
		end
		LuaFnSetNpcIntParameter(sceneId,targetId,x002107_g_NPCParam_stridx + Blessingcount,nNumText) --加入txt的选项idx
		--给经验，给提示
		LuaFnAddExp(sceneId,selfId,x002107_g_BasicExp * GetLevel(sceneId,selfId))
		x002107_ShowNotice(sceneId,selfId,ScriptGlobal_Format("#{TGQF_100111_53}",Blessingcount + 1))
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,1000)
	end
	
	
	for i, findId in x002107_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end
--**********************************
--怪物计时器操作
--**********************************
function x002107_OnCharacterTimer(sceneId,objId,dataId,uTime)
	--时间记录
	local Releasetime = LuaFnGetNpcIntParameter(sceneId,objId,x002107_g_NPCParam_Releasetime)
	Releasetime = Releasetime - 1
	LuaFnSetNpcIntParameter(sceneId,objId,x002107_g_NPCParam_Releasetime,Releasetime)
end
--**********************************
--散落满地财宝
--**********************************
x002107_g_DropBoxItem = 
{
	{nItemId = 38000202,nNum = 1,odds = 70},
	{nItemId = 30008002,nNum = 1,odds = 40},
	{nItemId = 30503020,nNum = 1,odds = 50},
	{nItemId = 20310131,nNum = 1,odds = 10},
	{nItemId = 20310140,nNum = 1,odds = 10},
	{nItemId = 20310149,nNum = 1,odds = 5},
	{nItemId = 30900006,nNum = 1,odds = 30},
	{nItemId = 30900015,nNum = 1,odds = 45},
	{nItemId = 30900056,nNum = 1,odds = 35},
	{nItemId = 30502005,nNum = 1,odds = 15},
	{nItemId = 10124111,nNum = 1,odds = 2},
	{nItemId = 10124141,nNum = 1,odds = 2},
	{nItemId = 10124153,nNum = 1,odds = 2},
	{nItemId = 10124157,nNum = 1,odds = 2},
	{nItemId = 10124161,nNum = 1,odds = 2},
	{nItemId = 10124187,nNum = 1,odds = 2},
	{nItemId = 10124193,nNum = 1,odds = 2},
	{nItemId = 10124210,nNum = 1,odds = 2},
	{nItemId = 10124211,nNum = 1,odds = 2},
	{nItemId = 10124212,nNum = 1,odds = 2},
	{nItemId = 10124213,nNum = 1,odds = 2},
	{nItemId = 10124214,nNum = 1,odds = 2},
	{nItemId = 10124230,nNum = 1,odds = 2},
	{nItemId = 10124232,nNum = 1,odds = 2},
	{nItemId = 10124252,nNum = 1,odds = 2},
	{nItemId = 10124253,nNum = 1,odds = 2},
	{nItemId = 10124254,nNum = 1,odds = 2},
	{nItemId = 10124255,nNum = 1,odds = 2},
}
function x002107_OnGiveDropBox(sceneId,nPosX,nPosZ)
	--计算总权重....
	local totalOdds = 0
	for _, item in x002107_g_DropBoxItem do
		totalOdds = totalOdds  + item.odds
	end
	if totalOdds < 1 then
		return
	end
	--给掉落包....
	local BoxId = -1
	local DropItemId = -1
	local DropNum = 0
	local randValue = 0
	for i = 1,18 do
		--计算本包掉落的物品....
		randValue = random(totalOdds) - 1;
		local tempRate = 0;
		for _, item in x002107_g_DropBoxItem do
			tempRate = tempRate + item.odds;
			if tempRate > randValue then
				DropItemId = item.nItemId;
				DropNum = item.nNum
				break;
			end
			randValue = randValue - item.odds;
		end
		local NewPosX = random(nPosX-5,nPosX+5)
		local NewPosZ = random(nPosZ-5,nPosZ+5)
		--放掉落包到场景里....
		if DropItemId > 0 then	
			BoxId = LuaFnItemBoxEnterSceneEx(sceneId,NewPosX,NewPosZ,807,180000)
			if BoxId > -1 then
				AddItemToBox(sceneId,BoxId,QUALITY_CREATE_BY_BOSS,1,DropItemId)
			end
		end
	end
end
--**********************************
--接受此NPC的任务
--**********************************
function x002107_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002107_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x002107_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002107_g_eventList do
		if missionScriptId == findId then
			x002107_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002107_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002107_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002107_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002107_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002107_OnDie( sceneId, selfId, killerId )
end

function x002107_ShowNotice( sceneId, selfId, strNotice)
	BeginEvent( sceneId )
		AddText( sceneId, strNotice )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
