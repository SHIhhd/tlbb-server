--MisDescBegin
--脚本号
x890277_g_ScriptId = 890277
--任务号
x890277_g_MissionId = 2242
--任务归类
x890277_g_MissionKind = 9 --引导任务 类型：9 路径：\Client\Config\MissionKind.txt
--任务等级
x890277_g_MissionLevel = 65
--任务名
x890277_g_MissionName = "#{SQYD_230802_91}"
--任务目标
x890277_g_MissionTarget = "#{SQYD_230802_95}"
--标记成功是哪号位 这里标记的是0号位
x890277_g_IsMissionOkFail = 0
-- 任务完成情况,占用任务参数的第1位
x890277_g_Custom = { { id = "已将长恨刀交还", num = 1 } }
--任务奖励
x890277_g_ExpBonus = 5000000
x890277_g_ItemBonus={{id=38002946,num=1},{id=38002987,num=1}}

--MisDescEnd
x890277_g_PreMissionId = 2241
x890277_g_AcceptNPC_Name = "扫地神僧"
x890277_g_FinishedNPC_Name = "欧冶安"
--**********************************
--任务入口函数
--**********************************
function x890277_OnDefaultEvent( sceneId, selfId, targetId )
	--如果玩家完成过这个任务
	if (IsMissionHaveDone(sceneId,selfId,x890277_g_MissionId) > 0 ) then
		return
	elseif( IsHaveMission(sceneId,selfId,x890277_g_MissionId) > 0)  then
		if GetName(sceneId,targetId) == x890277_g_FinishedNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SQYD_230802_98}")
				for i, item in x890277_g_ItemBonus do
					AddItemBonus( sceneId, item.id, item.num )
				end
			EndEvent()
			DispatchMissionContinueInfo(sceneId,selfId,targetId,x890277_g_ScriptId,x890277_g_MissionId)
		end
	elseif x890277_CheckAccept( sceneId, selfId ) > 0 then
--		发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,"#{SQYD_230802_92}")
			for i, item in x890277_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x890277_g_ScriptId,x890277_g_MissionId)
	end
end
--**********************************
--列举事件
--**********************************
function x890277_OnEnumerate( sceneId, selfId, targetId )
--	如果玩家完成过这个任务
	if IsMissionHaveDone(sceneId,selfId,x890277_g_MissionId) > 0 then
		return 
--	如果已接此任务
	elseif IsHaveMission(sceneId,selfId,x890277_g_MissionId) > 0 then
		if GetName(sceneId,targetId) == x890277_g_FinishedNPC_Name then
			AddNumText(sceneId, x890277_g_ScriptId,x890277_g_MissionName,2,-1);
		end
--	满足任务接收条件
	elseif x890277_CheckAccept(sceneId,selfId) > 0 then
		if GetName(sceneId,targetId) == x890277_g_AcceptNPC_Name then
			AddNumText(sceneId,x890277_g_ScriptId,x890277_g_MissionName,1,-1);
		end
	end
end
--**********************************
--检测接受条件
--**********************************
function x890277_CheckAccept( sceneId, selfId )
	-- 1，检测玩家是不是已经做过
	if (IsMissionHaveDone(sceneId,selfId,x890277_g_MissionId) > 0 ) then
		return 0
	end
		
	-- 等级检测
	if GetLevel(sceneId, selfId) < x890277_g_MissionLevel then
		return 0
	end
	
	-- 前一个任务是否完成
	if (IsMissionHaveDone(sceneId,selfId,x890277_g_PreMissionId) <= 0 ) then
		return 0
	end
	
	return 1
end
--**********************************
--接受
--**********************************
function x890277_OnAccept( sceneId, selfId, targetId )
	if x890277_CheckAccept(sceneId,selfId) ~= 1 then
		return
	end
	-- 加入任务到玩家列表
	--LuaFnAddMission参数说明：
	--sceneId, selfId, misId(任务编号), scriptId, k(是否回调x600041_OnKillObject), e(是否回调OnEnterArea), i(是否回调OnItemChange)
	--功能说明：在玩家身上添加misId编号的任务，成功返回1
	local ret = AddMission( sceneId,selfId, x890277_g_MissionId, x890277_g_ScriptId, 0, 0, 0 )
	if ret <= 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{SQYD_230802_11}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	--成功接取任务
	BeginEvent(sceneId)
		AddText(sceneId, ScriptGlobal_Format("#{SQYD_230802_12}",x890277_g_MissionName))
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
	--附加说明
	BeginEvent(sceneId)
		AddText(sceneId,"#{SQYD_230802_94}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--放弃
--**********************************
function x890277_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x890277_g_MissionId )
end

--**********************************
--检测是否可以提交
--**********************************
function x890277_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x890277_g_MissionId )
	if bRet ~= 1 then
		return 0
	end

	return 1
end

--**********************************
--提交
--**********************************
function x890277_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	if x890277_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
			BeginEvent(sceneId)
				AddText(sceneId, "#{SQYD_230802_100}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		if GetName(sceneId,targetId) ~= x890277_g_FinishedNPC_Name then
			BeginEvent(sceneId)
				AddText(sceneId, "#{SQYD_230802_100}")
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return
		end
		BeginAddItem(sceneId)
		for i, item in x890277_g_ItemBonus do
			AddItem( sceneId,item.id, item.num )
		end
		if EndAddItem(sceneId,selfId) <= 0 then
			return
		end
		--添加任务奖励		
		AddItemListToHuman(sceneId,selfId)
		LuaFnAddExp( sceneId, selfId, x890277_g_ExpBonus)
		DelMission( sceneId, selfId, x890277_g_MissionId )
		MissionCom( sceneId, selfId, x890277_g_MissionId )
		
		BeginEvent(sceneId)
			AddText(sceneId, ScriptGlobal_Format("#{SQYD_230802_24}",x890277_g_MissionName))
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		
		--下一阶段任务【暂未开放】
--		CallScriptFunction(890286,"OnDefaultEvent",sceneId,selfId,targetId)
	end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x890277_OnKillObject( sceneId, selfId, objdataId )
end

--**********************************
--进入区域事件
--**********************************
function x890277_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x890277_OnItemChanged( sceneId, selfId, itemdataId )
end
