--恶人谷NPC
--段延庆
--普通

x018036_g_ScriptId = 018036

--所拥有的事件ID列表
x018036_g_eventList = {228907,998353}

x018036_MenPaiPet =
{
	[1] = {["id"] = 3030, ["name"] = "狗", ["itemList"] = {{["id"] = 30601001,["num"] = 20 },{["id"] = 30602001,["num"] = 20}}},
	[2] = {["id"] = 3040, ["name"] = "刺猬", ["itemList"] = {{["id"] = 30601001,["num"] = 20}, {["id"] = 30604001, ["num"] = 20}}},
	[3] = {["id"] = 3050, ["name"] = "猴子", ["itemList"] = {{["id"] = 30601001, ["num"] = 20}, {["id"] = 30605001, ["num"] = 20}}},
}

--**********************************
--事件交互入口
--**********************************
function x018036_OnDefaultEvent( sceneId, selfId, targetId )
	local menpai = GetMenPai(sceneId, selfId)
	BeginEvent(sceneId)
		AddText(sceneId, "#{XKDRZ_240626_2}")
		if menpai == 9 then
			AddNumText(sceneId, x018036_g_ScriptId, "#G加入门派", 6, 0)
		end
		if menpai == 11 then
			if GetMissionDataEx(sceneId, selfId, 134) < 1 then
				AddNumText(sceneId, x018036_g_ScriptId, "领取装备", 4, 100)
			end
			if GetMissionDataEx(sceneId, selfId, 135) < 1 then
				AddNumText(sceneId, x018036_g_ScriptId, "领取珍兽", 4, 101)
			end
			if GetMissionDataEx(sceneId, selfId, 133) < 1 then
				AddNumText(sceneId, x018036_g_ScriptId, "领取门派时装", 4, 102)
			end
		end
		AddNumText(sceneId, x018036_g_ScriptId, "门派介绍", 8, 1)
		AddNumText(sceneId, x018036_g_ScriptId, "如何学习门派技能", 8, 6)
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x018036_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nMenPai = GetMenPai(sceneId, selfId)
	if GetNumText() == 0 then
		if nMenPai ~= 9 then
			x018036_MsgBox(sceneId, selfId, targetId, "   你已经拜入了其他门派。")
			return
		end
		if nMenPai == 11 then
			x018036_MsgBox(sceneId, selfId, targetId, "#{event_erengu_0001}")
			return
		end
		BeginEvent(sceneId)
		AddText(sceneId, " #{XKDRZ_240619_38}")
		AddNumText(sceneId, x018036_g_ScriptId, "我确定要拜入恶人谷", 6, 3)
		AddNumText(sceneId, x018036_g_ScriptId, "我暂时还不想拜入门派", 8, 1000)
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	elseif GetNumText() == 1 then
		x018036_MsgBox(sceneId, selfId, targetId, " #{XKDRZ_240626_13}")
	elseif GetNumText() == 6 then
		x018036_MsgBox(sceneId, selfId, targetId, " #{XKDRZ_240626_14}")
	elseif GetNumText() == 3 then
		if GetLevel(sceneId, selfId) < 10 then
			x018036_MsgBox(sceneId, selfId, targetId, "少侠还是等到10级之后再来拜师学艺吧！")
			return
		end
		BeginAddItem(sceneId)
		AddItem(sceneId, 10125941, 1)
		AddItem(sceneId, 30501001, 20)
		ret = EndAddItem(sceneId, selfId)
		if not ret then
			x018036_MsgBox(sceneId, selfId, targetId, "  你的背包空间不够了，整理后再来找我。")
			return
		end
		if GetMenPai(sceneId, selfId) == 9 then
			LuaFnJoinMenpai(sceneId, selfId, 11)
			LuaFnSetXinFaLevel(sceneId, selfId, 81, 10)
			LuaFnSetXinFaLevel(sceneId, selfId, 82, 1)
			LuaFnSetXinFaLevel(sceneId, selfId, 83, 1)
			LuaFnSetXinFaLevel(sceneId, selfId, 84, 10)
			LuaFnSetXinFaLevel(sceneId, selfId, 85, 10)
			LuaFnSetXinFaLevel(sceneId, selfId, 86, 1)
			AddItemListToHuman(sceneId, selfId)
			notify_tips(sceneId, selfId, "你已经加入恶人谷！")
			notify_tips(sceneId, selfId, "你获得了" .. GetItemName(10125941) .. "。")
			notify_tips(sceneId, selfId, "得到20枚门派召集令。")
			
			-- 取消武道引导任务,设置完成指定任务ID
			MissionCom( sceneId, selfId, 2024 )
			MissionCom( sceneId, selfId, 2025 )
			MissionCom( sceneId, selfId, 2027 )

		end
	elseif GetNumText() == 100 then
		if GetMissionDataEx(sceneId, selfId, 134) > 0 then
			x018036_MsgBox(sceneId, selfId, targetId, "你已经领取过了。")
			return
		end
		if nMenPai == 9 then
			x018036_MsgBox(sceneId, selfId, targetId, "  你还没有加入门派")
			return
		end
		if nMenPai ~= 11 then
			x018036_MsgBox(sceneId, selfId, targetId, "  你不是本门弟子！")
			return
		end
		BeginAddItem(sceneId)
		AddItem(sceneId, 10437009, 1)
		AddItem(sceneId, 10443410, 1)
		ret = EndAddItem(sceneId, selfId)
		if not ret then
			x018036_MsgBox(sceneId, selfId, targetId, "  你的背包空间不够了，整理后再来找我。")
			return
		end
		AddItemListToHuman(sceneId, selfId)
		notify_tips(sceneId, selfId, "你获得了" .. GetItemName(10437009) .. "。")
		notify_tips(sceneId, selfId, "你获得了" .. GetItemName(10443410) .. "。")
		SetMissionDataEx(sceneId, selfId, 134, GetDayTime(sceneId))
	elseif GetNumText() == 101 then
		if GetMissionDataEx(sceneId, selfId, 135) > 0 then
			x018036_MsgBox(sceneId, selfId, targetId, "你已经领取过了。")
			return
		end
		if nMenPai == 9 then
			x018036_MsgBox(sceneId, selfId, targetId, "  你还没有加入门派")
			return
		end
		if nMenPai ~= 11 then
			x018036_MsgBox(sceneId, selfId, targetId, "  你不是本门弟子！")
			return
		end
		local nRandom = random(1, getn(x018036_MenPaiPet))
		local itemList = x018036_MenPaiPet[nRandom]["itemList"]
		if not itemList then
			return
		end
		BeginAddItem(sceneId)
		for i, item in itemList do
			AddItem(sceneId, item["id"], item["num"])
		end
		ret = EndAddItem(sceneId, selfId)
		if not ret then
			x018036_MsgBox(sceneId, selfId, targetId, "    在送你珍兽时，同时还要给你珍兽玩具与珍兽的食品，请在物品背包中留出两个空格，再来找我。")
			return
		end
		Isok, petGUID_H, petGUID_L = LuaFnCreatePetToHuman(sceneId, selfId, x018036_MenPaiPet[nRandom]["id"], 1)
		if not Isok then
			x018036_MsgBox(sceneId, selfId, targetId, "  你已经不能携带更多的宠物了。你可以选择放生宠物来空出一个宠物栏位。\n  打开宠物介面，选择宠物清单中你要丢弃的宠物，点击放生就可以放弃此宠物了。")
			return
		end
		notify_tips(sceneId, selfId, "你获得了一只" .. x018036_MenPaiPet[nRandom]["name"] .. "。")
		x018036_MsgBox(sceneId, selfId, targetId, "  看看你的宠物栏，你得到了宠物奖励。")
		AddItemListToHuman(sceneId, selfId)
		SetMissionDataEx(sceneId, selfId, 135, GetDayTime(sceneId))
	elseif GetNumText() == 102 then
		if GetMissionDataEx(sceneId, selfId, 133) > 0 then
			x018036_MsgBox(sceneId, selfId, targetId, "    您已经领取过门派时装，无法再次领取。")
			return
		end
		if GetItemCount(sceneId, selfId, 10125941) > 0 then
			x018036_MsgBox(sceneId, selfId, targetId, "    您身上已经有了门派时装，无法再次领取。")
			return
		end
		BeginAddItem(sceneId)
		AddItem(sceneId, 10125941, 1)
		ret = EndAddItem(sceneId, selfId)
		if not ret then
			x018036_MsgBox(sceneId, selfId, targetId, "  你的背包空间不够了，整理后再来找我。")
			return
		end
		notify_tips(sceneId, selfId, "你获得了" .. GetItemName(10125941) .. "。")
		AddItemListToHuman(sceneId, selfId)
		SetMissionDataEx(sceneId, selfId, 133, GetDayTime(sceneId))
	elseif GetNumText() == 1000 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId, selfId, 1000)
	end
end

--**********************************
--消息框
--**********************************
function x018036_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent(sceneId)
	AddText(sceneId, msg)
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
end
