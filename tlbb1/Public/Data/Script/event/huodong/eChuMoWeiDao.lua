--MisDescBegin
--脚本号
x808135_g_ScriptId = 808135

--任务NPC
x808135_g_AccomplishNPC_Name="梁道士"
--上一个任务的ID
--g_MissionIdPre =

--任务号
x808135_g_MissionId = 1158

--任务归类
x808135_g_MissionKind = 12

--任务等级
x808135_g_MissionLevel = 10000

--是否是精英任务
x808135_g_IfMissionElite = 0

--任务文本描述
x808135_g_MissionName="#{ZXCM_090602_17}"

--任务目标
x808135_g_MissionTarget="%f"

x808135_g_StrForePart 				= 4

--用来保存字符串格式化的数据

x808135_g_FormatList = {"#{ZXCM_090602_30}%s#{ZXCM_090602_31}%s#{ZXCM_090602_32}",
	}

x808135_g_StrList = {
	--1-->14
	"雁南", --怪物等级30-36   30-40
	"龙泉", --怪物等级35-41   30-40
	"苍山", --怪物等级40-46   41-50
	"雁北", --怪物等级45-51   41-50
	"石林", --怪物等级55-61   51-60
	"武夷", --怪物等级50-56   51-60
	"梅岭", --怪物等级65-71   61-70
	"草原", --怪物等级60-66   61-70
	"辽西", --怪物等级75-81   71-80
	"玉溪", --怪物等级70-76   71-80
	"南诏", --怪物等级84-89   81-90
	"南海", --怪物等级80-85   81-90
	"琼州", --怪物等级92-97   91-119
	"琼州", --怪物等级92-97   91-119
	--15-->28
	"秦家寨亲兵",
	"龙泉豹",
	"狼族头人",
	"红枫蜘蛛",
	"棕熊",
	"树甲哨兵",
	"红袍蜘蛛",
	"弯刀马匪",
	"白狼王",
	"偃师护法",
	"丛林蜂",
	"南海海盗",
	"鳄鱼帮杀手",
	"南海盗神",
 }
x808135_g_BonusEXP_List = {
0,0,0,0,0,0,0,0,0,0,                                              
0,0,0,0,0,0,0,0,0,0,          
0,0,0,0,0,0,0,0,0,
126150,130300,134474,138564,142784,147029,151297,155479,159795,164133,245746,
252138,258454,264914,271409,277827,284391,290989,297509,304176,310878,
317500,324270,331075,337914,344672,351580,358523,365383,372394,379440,
386403,393517,400666,407731,414948,422200,429367,436688,444043,451433,
458736,466195,473688,481093,488655,496251,503759,511424,519123,526733,
534501,542303,550140,557887,565792,573732,581581,589590,597633,605584,
613696,621842,629895,638110,646360,654515,662834,671187,679574,679574,
679574,679574,679574,679574,679574,679574,679574,679574,679574,679574,
679574,679574,679574,679574,679574,679574,679574,679574,679574,        
}
--任务奖励
x808135_g_Custom	= {{id="已经驱逐",num=20}}
x808135_g_IsMissionOkFail = 1		--变量的第0位
--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x808135_OnDefaultEvent( sceneId, selfId, targetId )
	if IsHaveMission(sceneId,selfId,x808135_g_MissionId) > 0 then
		local misIndex = GetMissionIndexByID(sceneId, selfId, x808135_g_MissionId)--得到任务在20个任务中的序列号
		local bDone = x808135_CheckSubmit(sceneId,selfId)
		if bDone == 1 then
			x808135_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
			SetMissionByIndex(sceneId,selfId,misIndex,0,2)
			return
		end
		if bDone == 2 then
			x808135_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
			SetMissionByIndex(sceneId,selfId,misIndex,0,2)
			return
		end
		if bDone == 3 then
			BeginEvent(sceneId)
				AddText( sceneId,"#{ZXCM_090602_20}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		BeginEvent(sceneId)
			AddText(sceneId,x808135_g_MissionName)
			AddText(sceneId,"#{ZXCM_090602_20}")
		EndEvent()
		DispatchMissionContinueInfo(sceneId,selfId,targetId,x808135_g_ScriptId,x808135_g_MissionId)
	--满足任务接收条件
	elseif x808135_CheckAccept(sceneId,selfId) > 0 then
		--发送任务接受时显示的信息
		BeginEvent(sceneId)
			AddText(sceneId,x808135_g_MissionName)
			AddText(sceneId,"#{ZXCM_090602_18}")
		EndEvent( )
		DispatchMissionInfo(sceneId,selfId,targetId,x808135_g_ScriptId,x808135_g_MissionId)
	end
end

--**********************************
--列举事件
--**********************************
function x808135_OnEnumerate( sceneId, selfId, targetId)
	--如果已接此任务
	if IsHaveMission(sceneId,selfId,x808135_g_MissionId) > 0 then
	    AddNumText(sceneId, x808135_g_ScriptId, x808135_g_MissionName,4,-1);
	--满足任务接收条件
	elseif x808135_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId, x808135_g_ScriptId, x808135_g_MissionName, 3, -1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x808135_CheckAccept(sceneId,selfId)
	local nWeek = GetTodayWeek();
	local nTime = GetHour() * 100 + GetMinute()
	--需要一个判断，判断玩家当前任务到第几环了，防止其余人卡任务，每周只能完成一次。
	local nMissionCount = GetMissionDataEx(sceneId,selfId,MDEX_ZHONGXIACHUMO)
	if nWeek ~= 3 then
		return 0
	end
	if nTime < 1900 or nTime > 2200 then
		return 0
	end
	--证明今天任务已经做满了
	if nMissionCount == 3 then
		return 0
	end
	return 1
end

--**********************************
--接受
--**********************************
function x808135_OnAccept( sceneId, selfId )
	if x808135_CheckAccept(sceneId,selfId) == 0 then
		return
	end
	-- 加入任务到玩家列表
	local ret = AddMission( sceneId,selfId, x808135_g_MissionId, x808135_g_ScriptId, 1, 0, 0 )
	if ret <= 0 then
		x808135_NotifyTips(sceneId,selfId,"#{ZXCM_090602_09}")
		return
	end
	--获取接受玩家任务的等级
	local playerlv = GetLevel(sceneId,selfId)
	local mapname,mapmonster,idx;
	if playerlv >= 30 and playerlv <= 40 then
		idx = random(1,2)
	elseif playerlv >= 41 and playerlv <= 50 then
		idx = random(3,4)
	elseif playerlv >= 51 and playerlv <= 60 then
		idx = random(5,6)
	elseif playerlv >= 61 and playerlv <= 70 then
		idx = random(7,8)
	elseif playerlv >= 71 and playerlv <= 80 then
		idx = random(9,10)
	elseif playerlv >= 81 and playerlv <= 90 then
		idx = random(11,12)
	elseif playerlv >= 91 then
		idx = random(13,14)
	end
	local misIndex = GetMissionIndexByID(sceneId, selfId, x808135_g_MissionId)--得到任务在20个任务中的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,x808135_g_StrForePart,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x808135_g_StrForePart+1,idx - 1)
	SetMissionByIndex(sceneId,selfId,misIndex,x808135_g_StrForePart+2,(idx - 1) + 14)
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)
	SetMissionByIndex(sceneId,selfId,misIndex,x808135_g_IsMissionOkFail,0)
end

--**********************************
--放弃
--**********************************
function x808135_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
	DelMission( sceneId, selfId, x808135_g_MissionId )
end

--**********************************
--继续
--**********************************
function x808135_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x808135_CheckSubmit(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId,selfId,x808135_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,0)
	local nWeek = GetTodayWeek();
	local nTime = GetHour() * 100 + GetMinute()
	if nWeek ~= 3 then
		return 1
	end
	if nTime > 2200 then
		return 2
	end
	if param == 0 or param == 2 then
		return 3
	end
	return 4
end

--**********************************
--提交
--**********************************
function x808135_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	-- 安全性检测
	-- 1、检测玩家是不是有这个任务
	if IsHaveMission(sceneId,selfId,x808135_g_MissionId) <= 0 then
		return
	end
	-- 2、任务过期
	if x808135_CheckSubmit(sceneId,selfId) == 1 then
		x808135_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
		return
	end
	-- 3、任务过期
	if x808135_CheckSubmit(sceneId,selfId) == 2 then
		x808135_NotifyTips(sceneId,selfId,"#{ZXCM_090602_15}")
		return
	end
	-- 4、未完成任务或者失败了
	if x808135_CheckSubmit(sceneId,selfId) == 3 then
		return
	end
	-- 3、任务过期情况检测，测试阶段暂时不加
	DelMission( sceneId,selfId, x808135_g_MissionId)
	--设置任务已经被完成过
	MissionCom( sceneId,selfId, x808135_g_MissionId)
	local playerlv = GetLevel(sceneId,selfId)
	LuaFnAddExp(sceneId,selfId,floor(x808135_g_BonusEXP_List[playerlv] / 2)) --第二阶段任务，不给那么高。
	--设置任务当前完成阶段
	SetMissionDataEx(sceneId,selfId,MDEX_ZHONGXIACHUMO,2)
	x808135_NotifyTips(sceneId,selfId,"#{ZXCM_090602_16}")
end

--**********************************
--杀死怪物或玩家
--**********************************
function x808135_OnKillObject( sceneId, selfId, objdataId ,objId )
	local misIndex = GetMissionIndexByID(sceneId,selfId,x808135_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,x808135_g_StrForePart + 2)
	if GetName(sceneId,objId) == x808135_g_StrList[param + 1] then
		-- 看有没有这个任务
		if IsHaveMission(sceneId, selfId, x808135_g_MissionId) > 0 then
			local misIndex = GetMissionIndexByID(sceneId,selfId,x808135_g_MissionId)
			local nKillNum = GetMissionParam(sceneId,selfId,misIndex,x808135_g_IsMissionOkFail)
			if nKillNum < x808135_g_Custom[1].num then
				if nKillNum == x808135_g_Custom[1].num - 1 then
					SetMissionByIndex(sceneId,selfId,misIndex,0,1)
				end
				SetMissionByIndex(sceneId,selfId,misIndex,1,nKillNum+1)
				BeginEvent(sceneId)
					strText = "#{ZXCM_090602_19} "..GetMissionParam(sceneId,selfId,misIndex,x808135_g_IsMissionOkFail).."/"..x808135_g_Custom[1].num
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x808135_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x808135_OnItemChanged( sceneId, selfId, itemdataId )
end
--**********************************
-- 屏幕中间提示
--**********************************
function x808135_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end