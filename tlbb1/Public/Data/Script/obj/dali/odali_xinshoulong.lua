--钱龙

--脚本号
x002031_g_scriptId = 002031

x002031_g_startTime = 09097 --活动开始时间
x002031_g_EndTime   = 09150 --活动结束时间

--所拥有的事件ID列表
x002031_g_eventList={210263,210259,210278,210267,050028,889054,889055,889056,889057}--210206,311100
x002031_g_DeliveryScript = 006668
x002031_g_DeliveryList = {1018870}
--侠客行令牌兑换奖励，客户端找不到脚本就做到这里把。
x002031_XiaKeXingTb = 
{
	[1] = {item = 30008016,needitem = 30503153,neednum = 5,desc = "#{LDX_100302_03}"},
	[2] = {item = 30008028,needitem = 30503153,neednum = 8,desc = "#{LDX_100302_04}"},
	[3] = {item = 20109008,needitem = 30503153,neednum = 13,desc = "#{LDX_100302_05}"},
	[4] = {item = 20109009,needitem = 30503153,neednum = 14,desc = "#{LDX_100302_06}"},
	[5] = {item = 30900006,needitem = 30503153,neednum = 14,desc = "#{LDX_100302_07}"},
	[6] = {item = 20109010,needitem = 30503153,neednum = 16,desc = "#{LDX_100302_08}"},
	[7] = {item = 30008034,needitem = 30503153,neednum = 16,desc = "#{LDX_100302_09}"},
	[8] = {item = 10124104,needitem = 30503153,neednum = 72,desc = "#{LDX_100302_10}"},
	[9] = {item = 10124317,needitem = 30503153,neednum = 76,desc = "#{LDX_100302_11}"},
	[10] = {item = 10141136,needitem = 30503153,neednum = 250,desc = "#{LDX_100302_12}"},
	[11] = {item = 10141140,needitem = 30503153,neednum = 250,desc = "#{LDX_100302_13}"}
}
--**********************************
--事件列表
--**********************************
function x002031_UpdateEventList( sceneId, selfId,targetId )
	
	local  PlayerName=GetName(sceneId,selfId)	
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "妹妹"
	else
		PlayerSex = "兄弟"
	end
	
	BeginEvent(sceneId)
	local curDayTime = GetDayTime()
	if curDayTime >= x002031_g_startTime and curDayTime <= x002031_g_EndTime then
		AddText(sceneId,"#{XFMTL_20090319_05}")
	else
		AddText(sceneId,"#{OBJ_dali_0013}"..PlayerName..PlayerSex.."不想一试身手吗？")		--#r  在下不才，却也有“江湖百晓生”的虚名，对古今天下江湖之事都略知一二，若有什么疑问，你可以尽管来找我。--#r  #r#r  “你问我答”－我来告诉你一些江湖事。  #r#r  “我问你答”－连续答对问题就资助你银两。
	end
	AddNumText( sceneId, x002031_g_scriptId, "#{LDX_100302_01}", 6, 799 )
	AddNumText( sceneId, x002031_g_scriptId, "#{LDX_100112_02}", 11, 999 )
	AddNumText( sceneId, x002031_g_scriptId, "#{LYXM_XML_2}", 11, 1000 )
	for i, Deliveryidx in x002031_g_DeliveryList do
		CallScriptFunction( x002031_g_DeliveryScript, "OnEnumerate",sceneId, selfId, targetId ,Deliveryidx)
	end
	for i, eventId in x002031_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002031_OnDefaultEvent( sceneId, selfId,targetId )
	x002031_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002031_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 799 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{LDX_100302_02}" )
			for i = 1,getn(x002031_XiaKeXingTb) do
				AddNumText( sceneId, x002031_g_scriptId,x002031_XiaKeXingTb[i].desc, 6, 800 + i )
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() >= 801 and GetNumText() <= 811 then
		BeginEvent(sceneId)
			if GetNumText() >= 901 and GetNumText() < 810 then
				AddText( sceneId,"#{LDX_100305_01}1".."#{LDX_100305_02}"..GetItemName(sceneId,x002031_XiaKeXingTb[mod(GetNumText(),10)].item).."#{LDX_100305_03}"..x002031_XiaKeXingTb[mod(GetNumText(),10)].neednum.."#{LDX_100305_04}")
			else
				AddText( sceneId,"#{LDX_100305_01}1".."#{LDX_100305_02}"..GetItemName(sceneId,x002031_XiaKeXingTb[mod(GetNumText(),100)].item).."#{LDX_100305_03}"..x002031_XiaKeXingTb[mod(GetNumText(),100)].neednum.."#{LDX_100305_04}")
			end
			AddNumText( sceneId, x002031_g_scriptId,"#{LDX_100302_15}", 6,GetNumText() + 100 )
			AddNumText( sceneId, x002031_g_scriptId,"#{LDX_100302_16}", 6,9999)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		--兑换奖励跳转
	elseif GetNumText() >= 901 and GetNumText() <= 911 then
		if GetNumText() >= 901 and GetNumText() < 910 then
			x002030_XiaKeXingReward(sceneId,selfId,targetId,mod(GetNumText(),10))
		else
			x002030_XiaKeXingReward(sceneId,selfId,targetId,mod(GetNumText(),100))
		end
	elseif GetNumText() == 999 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{LDX_100112_03}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 1000 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{LYXM_090824_5}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 9999 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId,1000)
	end
	--配表任务
	for i,Deliveryidx in x002031_g_DeliveryList do
		if eventId == x002031_g_DeliveryScript then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId ,Deliveryidx)
		end
	end
	for i, findId in x002031_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end
--**********************************
--侠客行令牌发放奖励
--**********************************
function x002030_XiaKeXingReward(sceneId,selfId,targetId,grade)
	local awardInfo = x002031_XiaKeXingTb[grade]
	if not awardInfo then
		return
	end
	if LuaFnGetAvailableItemCount(sceneId,selfId,awardInfo.needitem) < awardInfo.neednum then
		x002031_NotifyFailBox(sceneId,selfId,targetId,"#{LDX_100302_17}")
		return
	end
	if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 1 then
		x002031_NotifyFailBox( sceneId, selfId, targetId,"#{LDX_100302_18}")
		return
	end
	if LuaFnGetMaterialBagSpace( sceneId, selfId ) < 1 then
		x002031_NotifyFailBox( sceneId, selfId, targetId, "#{LDX_100302_18}")
		return
	end
	if LuaFnDelAvailableItem(sceneId,selfId,awardInfo.needitem,awardInfo.neednum) ~= 1 then
		x002031_NotifyFailBox( sceneId, selfId, targetId, "#{LDX_100302_17}")
		return
	end
	--发放物品
	LuaFnTryRecieveSingleItem(sceneId,selfId,awardInfo.item,QUALITY_MUST_BE_CHANGE,1)
	x002031_NotifyFailBox(sceneId,selfId,targetId,"#{LDX_100305_05}"..GetItemName(sceneId,awardInfo.item).."#{LDX_100305_06}")
	--发个公告
	local strText = format("#{_INFOUSR%s}#{LDX_100305_07}%s#{LDX_100305_08}", GetName(sceneId,selfId), GetItemName(sceneId,awardInfo.item))
	BroadMsgByChatPipe(sceneId,selfId,strText,4)
end
--**********************************
--接受此NPC的任务
--**********************************
function x002031_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	local ret = 0
	for i,Deliveryidx in x002031_g_DeliveryList do
		if missionScriptId == x002031_g_DeliveryScript then
			ret = CallScriptFunction( missionScriptId, "CheckAccept",sceneId, selfId ,Deliveryidx)
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId,Deliveryidx)
			end
		end
	end
	for i, findId in x002031_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId ,targetId,missionScriptId)
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x002031_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002031_g_eventList do
		if missionScriptId == findId then
			x002031_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002031_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	--配表任务
	for i,Deliveryidx in x002031_g_DeliveryList do
		if missionScriptId == x002031_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnContinue",sceneId, selfId ,targetId,Deliveryidx)
		end
	end
	for i, findId in x002031_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002031_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	--配表任务
	for i,Deliveryidx in x002031_g_DeliveryList do
		if missionScriptId == x002031_g_DeliveryScript then
			CallScriptFunction( missionScriptId, "OnSubmit",sceneId, selfId ,targetId,selectRadioId,Deliveryidx)
		end
	end
	for i, findId in x002031_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002031_OnDie( sceneId, selfId, killerId )
end


function x002031_NotifyFailBox(sceneId,selfId,targetId,msg)
	BeginEvent(sceneId)	
		AddText( sceneId,msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end