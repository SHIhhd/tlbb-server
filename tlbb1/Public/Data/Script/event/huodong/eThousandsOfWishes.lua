--MisDescBegin
--脚本号
x808131_g_ScriptId = 808131

--接受任务NPC属性
x808131_g_Position_X=186
x808131_g_Position_Z=182
x808131_g_SceneID=1
x808131_g_AccomplishNPC_Name="梁道士"

--任务号
x808131_g_MissionId = 1161

--目标NPC
x808131_g_Name	="梁道士"

--任务归类
x808131_g_MissionKind = 12

--任务等级
x808131_g_MissionLevel = 10000

--是否是精英任务
x808131_g_IfMissionElite = 0

--许愿所需道具
x808131_g_needItem	= 30505255

--任务名
x808131_g_MissionName="#{SQXY_09061_4}"
x808131_g_MissionInfo="#{SQXY_09061_39}"
x808131_g_MissionTarget="#{SQXY_09061_11}"
x808131_g_ContinueInfo="#{SQXY_09061_19}"
x808131_g_MissionComplete = "#{SQXY_09061_36}"
x808131_g_IsMissionOkFail=0
x808131_g_IsMissionCount=1
x808131_g_ItemBonus={{id=20502010,num=1}} --许愿果 暂用
x808131_g_Custom	= { {id="向许愿树许愿：",num=5} }
--太湖许愿点
x808131_g_SignPost = {sceneNum = 4,x = 157, z = 185, tip = "许愿点"}

--接取任务的最低等级
x808131_g_Accept_MiniLv = 30
--MisDescEnd

--**********************************
--任务入口函数
--**********************************
function x808131_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	local nNumText = GetNumText()
	if nNumText == 1 then
		x808131_NotifyFailBox(sceneId,selfId,targetId,"#{SQXY_09061_10}")
		return
	end
	if IsHaveMission(sceneId,selfId,x808131_g_MissionId) > 0 then
		--发送任务需求的信息
		BeginEvent(sceneId)
			AddText(sceneId,x808131_g_MissionName)
			AddText(sceneId,x808131_g_ContinueInfo)
		EndEvent( )
		bDone = x808131_CheckSubmit(sceneId,selfId)
		DispatchMissionDemandInfo(sceneId,selfId,targetId,x808131_g_ScriptId,x808131_g_MissionId,bDone)
	--满足任务接收条件
	elseif x808131_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x808131_g_MissionName)
			AddText(sceneId,x808131_g_MissionInfo)
			AddText(sceneId,"#{M_MUBIAO}#r")
			AddText(sceneId,x808131_g_MissionTarget)
			for i, item in x808131_g_ItemBonus do
				AddItemBonus( sceneId, item.id, item.num )
			end
		EndEvent()
		DispatchMissionInfo(sceneId,selfId,targetId,x808131_g_ScriptId,x808131_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x808131_OnEnumerate( sceneId, selfId, targetId )
	if IsHaveMission(sceneId,selfId,x808131_g_MissionId) > 0 then
		AddNumText(sceneId,x808131_g_ScriptId,x808131_g_MissionName,4,-1)
	elseif x808131_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x808131_g_ScriptId,x808131_g_MissionName,3,-1)
	end
	--关于一千零一个愿望
	AddNumText(sceneId,x808131_g_ScriptId,"#{SQXY_09061_6}",11,1)
end

--**********************************
--检测是否满足接取任务条件
--**********************************
function x808131_CheckAccept(sceneId,selfId)
	local nDayTime = GetMissionDataEx(sceneId,selfId,MDEX_WISHES_DAYTIME)
	local nNowTime = GetDayTime()
	local nLevel = GetLevel(sceneId,selfId)
	if nDayTime >= nNowTime then
		x808131_NotifyFailBox(sceneId,selfId,-1,"#{SQXY_09061_7}")
		return 0
	end
	if nLevel < x808131_g_Accept_MiniLv then
		x808131_NotifyFailBox(sceneId,selfId,-1,"#{SQXY_09061_8}")
		return 0
	end
	if GetMissionCount(sceneId, selfId) >= 20 then
		x808131_NotifyFailBox(sceneId,selfId,-1,"#{SQXY_09061_9}")
		return 0
	end
	return 1
end
--**********************************
--接受任务
--**********************************
function x808131_OnAccept( sceneId, selfId )
	local ret = AddMission( sceneId,selfId, x808131_g_MissionId, x808131_g_ScriptId, 0, 0, 1 ) --添加任务给玩家
	if ret > 0 then
		local misIndex = GetMissionIndexByID(sceneId,selfId,x808131_g_MissionId)
		SetMissionByIndex(sceneId,selfId,misIndex,x808131_g_IsMissionOkFail,0) --设置任务完成参数为0
		SetMissionDataEx(sceneId,selfId,MDEX_WISHES_DAYTIME,GetDayTime())
		x808131_NotifyFailTips(sceneId,selfId,"接受任务：一千零一个愿望") --字典内不存在这个字典，只能用文字代替了。
		x808131_NotifyFailTips(sceneId,selfId,"#{SQXY_09061_12}")
		--问路
		CallScriptFunction(SCENE_SCRIPT_ID,"AskThePos",sceneId, selfId, x808131_g_SignPost.sceneNum, x808131_g_SignPost.x, x808131_g_SignPost.z, x808131_g_SignPost.tip )
	else
		x808131_NotifyFailTips( sceneId, selfId, "#{SQXY_09061_9}")
		return
	end
end

--**********************************
--放弃任务
--**********************************
function x808131_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	local res = DelMission(sceneId,selfId,x808131_g_MissionId)
	if res > 0 then
		--任务放弃了，他今天没做任务，所以清除任务时间记录必须清除
		SetMissionDataEx(sceneId,selfId,MDEX_WISHES_DAYTIME,0)
		--放弃了还要清理次数
		SetMissionDataEx(sceneId,selfId,MDEX_WISHES_COUNT,0)
		--去除问路标记
		CallScriptFunction(SCENE_SCRIPT_ID,"DelSignpost",sceneId, selfId, x808131_g_SignPost.sceneNum, x808131_g_SignPost.x, x808131_g_SignPost.z, x808131_g_SignPost.tip )
	end
end
--**********************************
--继续
--**********************************
function x808131_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x808131_g_MissionName)
		AddText(sceneId,x808131_g_MissionComplete)
		for i, item in x808131_g_ItemBonus do
			AddItemBonus( sceneId,item.id, item.num )
		end
    EndEvent()
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x808131_g_ScriptId,x808131_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x808131_CheckSubmit(sceneId,selfId)
	--检测任务是否可以提交
	local nWishCount = GetMissionDataEx(sceneId,selfId,MDEX_WISHES_COUNT)
	local nMisIndex = GetMissionIndexByID(sceneId,selfId,x808131_g_MissionId)
	local Isok = GetMissionParam(sceneId,selfId,nMisIndex,x808131_g_IsMissionOkFail)
	if nWishCount < 5 or Isok < 1 then
		return 0
	end
	return 1
end

--**********************************
--提交任务
--**********************************
function x808131_OnSubmit( sceneId, selfId, targetId,selectRadioId )
	if x808131_CheckSubmit(sceneId,selfId) > 0 then
		--任务完成，检测背包空间
    	BeginAddItem(sceneId)
			AddItem(sceneId,20502010,1)
		if EndAddItem(sceneId,selfId) <= 0 then
			x808131_NotifyFailTips(sceneId,selfId,"#{SQXY_09061_35}")
			return
		end
		if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
			x808131_NotifyFailTips(sceneId,selfId,"#{SQXY_09061_35}")
			return
		end
		--给物品
		local nPos = TryRecieveItem( sceneId,selfId,20502010,1)
		if nPos == -1 then
			return
		end
		LuaFnItemBind(sceneId,selfId,nPos) --绑定许愿果，禁止一切白嫖行为！！！！！
		--忘记了一个逻辑，个人许愿次数数据完成之后清空掉
		SetMissionDataEx(sceneId,selfId,MDEX_WISHES_COUNT,0)
		--任务完成
		DelMission(sceneId,selfId,x808131_g_MissionId)
		MissionCom(sceneId,selfId,x808131_g_MissionId)
		x808131_NotifyFailTips(sceneId,selfId,"完成任务：一千零一个愿望")
		x808131_NotifyFailTips(sceneId,selfId,"#{SQXY_09061_36}")
		--周活跃数据埋点
		LuaFnFinishZhouHuoYueMission(sceneId,selfId,2)
	else
		x808131_NotifyFailBox(sceneId,selfId,targetId,"#{SQXY_09061_19}")
		return
	end
end
--**********************************
-- 使用愿灵泉
--**********************************
function x808131_OnUseItem(sceneId,selfId)
	--备注下，因为任务信息等各种数据都定义在这里，所以将愿灵泉的使用逻辑集中到这里统一完成，方便后期管理
	if IsHaveMission(sceneId,selfId,x808131_g_MissionId) <= 0 then --字典没数据啊，没有任何提示了就，任务不接不让用。
		return 0
	end
	if sceneId ~= x808131_g_SignPost.sceneNum then
		x808131_NotifyFailTips(sceneId,selfId,"#{SQXY_09061_14}")
		return 0
	end
	--双人坐骑状态下
	if LuaFnGetDRideFlag(sceneId, selfId) ~= 0  then
		x808131_NotifyFailTips(sceneId,selfId,"#{SQXY_09061_15}")
		return 0
	end
	--坐骑状态下
	if LuaFnIsModelOrMount(sceneId,selfId) == 1 then
		x808131_NotifyFailTips(sceneId,selfId,"#{SQXY_09061_15}")
		return 0
	end
	--变身状态下
	if LuaFnIsModelOrMount(sceneId,selfId) == 2 then
		x808131_NotifyFailTips(sceneId,selfId,"#{SQXY_09061_16}")
		return 0
	end
	return 1
end
--**********************************
--道具改变
--**********************************
function x808131_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x808131_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x808131_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end