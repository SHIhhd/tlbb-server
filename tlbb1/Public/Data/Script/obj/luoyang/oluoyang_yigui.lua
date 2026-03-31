--脚本号
x000161_g_scriptId = 000161
x000161_g_Box = {{Capacity=5,Cost=1000000,Next=10},
			{Capacity=10,Cost=1500000,Next=15},
			{Capacity=15,Cost=2000000,Next=20},
			{Capacity=20,Cost=2500000,Next=25},
			{Capacity=25,Cost=3000000,Next=30}
}

x000161_g_StrDictionary = 
{
	{numtext = "#{YG_20100809_15}", notok = "#{YG_20100809_20}", tips = "#{YG_20100809_19}", countnews = "#{YG_20100809_42}", flag = 1, dressnum = 5, titleid = 1004},
	{numtext = "#{YG_20100809_16}", notok = "#{YG_20100809_22}", tips = "#{YG_20100809_21}", countnews = "#{YG_20100809_43}", flag = 1, dressnum = 10, titleid = 1005},
	{numtext = "#{YG_20100809_17}", notok = "#{YG_20100809_24}", tips = "#{YG_20100809_23}", countnews = "#{YG_20100809_44}", flag = 1, dressnum = 15, titleid = 1006},
	{numtext = "#{YG_20100809_18}", notok = "#{YG_20100809_26}", tips = "#{YG_20100809_25}", countnews = "#{YG_20100809_45}", flag = 2, dressnum = 15, titleid = 1007},
	{numtext = "#{CYJKC_130305_02}", notok = "#{CYJKC_130305_09}", tips = "绮罗万华", countnews = "#{CYJKC_130305_11}", flag = 1, dressnum = 20, titleid = 1008},
	{numtext = "#{CYJKC_130305_03}", notok = "#{CYJKC_130305_10}", tips = "云绒巧纳", countnews = "#{CYJKC_130305_12}", flag = 2, dressnum = 20, titleid = 1009},
	{numtext = "#{CYJKC_130305_04}", notok = "#{CYJKC_130305_14}", tips = "星缎锦绣", countnews = "#{CYJKC_130305_13}", flag = 1, dressnum = 25, titleid = 1010},
	{numtext = "#{CYJKC_130305_05}", notok = "#{CYJKC_130305_16}", tips = "月纨华素", countnews = "#{CYJKC_130305_15}", flag = 2, dressnum = 25, titleid = 1011},
	{numtext = "#{CYJKC_130305_06}", notok = "#{CYJKC_130305_18}", tips = "金缕流光", countnews = "#{CYJKC_130305_17}", flag = 1, dressnum = 30, titleid = 1012},
	{numtext = "#{CYJKC_130305_07}", notok = "#{CYJKC_130305_21}", tips = "仙袂玉裘", countnews = "#{CYJKC_130305_20}", flag = 2, dressnum = 30, titleid = 1013}
}
--**********************************
--事件交互入口
--**********************************
function x000161_OnDefaultEvent( sceneId, selfId, targetId)
	BeginEvent(sceneId)  
		AddText(sceneId, "#{YG_20100809_01}")
--        AddNumText(sceneId, 1,"#{YG_20100809_02}", 6, -1)
--		--衣柜储纳
--		local CurrentRentIndex = GetFashionDepotRentIndex(sceneId, selfId)
--		local BoxNum = x000161_FindBoxNum( sceneId, selfId,targetId,CurrentRentIndex )
--		if BoxNum ~= 0 then
--			AddNumText(sceneId, 2,"#{YG_20100809_03}", 6, -1)
--		end
		AddNumText(sceneId, 3,"#{YG_20100809_04}", 6, -1)
		AddNumText(sceneId, 4,"#{GXHDZ_141121_102}", 11, -1)
		EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x000161_OnEventRequest( sceneId, selfId, targetId, eventId )
	if eventId==1 then
		--打开衣柜
--		LuaFnOpenPlayerFashionDepot(sceneId,selfId,targetId)
	elseif eventId==2 then
		--增加衣柜容量
--		x000161_BuyFashionSize( sceneId, selfId, targetId )
	elseif eventId==3 then
		--领取称号
		BeginEvent(sceneId)
			for i,data in x000161_g_StrDictionary do
				AddNumText(sceneId,x000161_g_scriptId,data.numtext,6,i + 100)
			end
			EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif eventId==4 then
		BeginEvent(sceneId)     
			AddText(sceneId, "#{GXHDZ_141121_103}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
--	elseif eventId==5 then
--		if LuaFnCheckPhoneMibaoAndMinorPasswd(sceneId, selfId, 1) == 0 then
--			return
--		end
--		--得到当前银行的存储格数
--		local CurrentRentIndex = GetFashionDepotRentIndex(sceneId, selfId)
--		--查找存储箱序号
--		local BoxNum = x000161_FindBoxNum( sceneId, selfId, targetId, CurrentRentIndex )
--		-- 得到金币和交子的数目
--		if (GetMoney ( sceneId, selfId ) + GetMoneyJZ ( sceneId, selfId )) >= x000161_g_Box[BoxNum].Cost then
--			-- 使用带优先级的金钱消耗函数
--			LuaFnCostMoneyWithPriority (sceneId,selfId,x000161_g_Box[BoxNum].Cost)
--			-- 增加存储箱并提示
--			SetFashionDepotRentIndex( sceneId, selfId, x000161_g_Box[BoxNum].Next )
--			--打开衣柜
--			LuaFnOpenPlayerFashionDepot(sceneId,selfId,targetId)
--			
--		else
--			x000161_NotifyTip( sceneId, selfId, "#{YG_20100809_41}"  )
--		end
	elseif GetNumText() >= 100 and GetNumText() <= 110 then
		x000161_AwardFashionTitle(sceneId,selfId,GetNumText())
	end
end
--**********************************
--储衣柜称号领取
--**********************************
function x000161_AwardFashionTitle(sceneId,selfId,nIndex)
	local nSelect = -1
	local szName = GetName(sceneId,selfId)
	if nIndex < 10 then
		nSelect = mod(nIndex,10)
	else
		nSelect = mod(nIndex,100)
	end
	if nSelect < 1 or nSelect > 10 then
		return
	end
	local Fashiontable = x000161_g_StrDictionary[nSelect]
	if not Fashiontable or Fashiontable == nil then
		return
	end
	local nItemNum,nItemDiffClass = LuaFnGetFashionItemCountInDepot(sceneId,selfId)
	if Fashiontable.flag == 1 then
		if nItemNum < Fashiontable.dressnum then
			x000161_NotifyTip(sceneId,selfId,Fashiontable.notok)
			return
		end
	else
		if nItemDiffClass < Fashiontable.dressnum then
			x000161_NotifyTip(sceneId,selfId,Fashiontable.notok)
			return
		end
	end
	--满足以上条件给称号
	--检测是否拥有本称号
	local retCanAddTitle = LuaFnCanAddTitle(sceneId,selfId,Fashiontable.titleid)
	if retCanAddTitle == 0 then
		x000161_NotifyTip(sceneId,selfId,"#{YG_20100809_32}")
		return
	end
	if retCanAddTitle == -1 then
		x000161_NotifyTip(sceneId,selfId,"#{YG_20100809_32}")
		return
	end
	--称号检测完毕，发放新的称号
	LuaFnAwardCharTitle(sceneId,selfId,Fashiontable.titleid)
	LuaFnSetCurTitleById(sceneId,selfId,Fashiontable.titleid)
	LuaFnDispatchAllTitle(sceneId,selfId)
	--发送醒目提示
	if nSelect < 5 then
		x000161_NotifyTip(sceneId,selfId,Fashiontable.tips)
	else
		x000161_NotifyTip(sceneId,selfId,ScriptGlobal_Format("#{CYJKC_130305_08}",Fashiontable.tips))
	end
	--发送公告
	AddGlobalCountNews(sceneId,ScriptGlobal_Format(Fashiontable.countnews,szName))
end

--**********************************
--增加衣柜储物间
--**********************************
function x000161_BuyFashionSize( sceneId, selfId, targetId )
	if LuaFnCheckPhoneMibaoAndMinorPasswd(sceneId, selfId, 1) == 0 then
		return
	end
	local CurrentRentIndex = GetFashionDepotRentIndex(sceneId, selfId)
	--查找存储箱序号
	local BoxNum = x000161_FindBoxNum( sceneId, selfId,targetId,CurrentRentIndex )
	if BoxNum == 0 then
		x000161_NotifyTip( sceneId, selfId, "#{YG_20100809_14}" )
		return
	end
	
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,x000161_g_scriptId)
		UICommand_AddInt(sceneId,targetId)
		UICommand_AddInt(sceneId,5)
		UICommand_AddString(sceneId,"OnEventRequest")
		UICommand_AddString(sceneId,ScriptGlobal_Format("#{YG_20100809_13}",tostring(x000161_g_Box[BoxNum].Cost)))			
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 24)
end
--**********************************
--计算衣柜储物间
--**********************************
function x000161_FindBoxNum( sceneId, selfId,targetId,Capacity )
	--得到储物柜序号
	for i, findBox in x000161_g_Box do
		if findBox.Capacity == Capacity then
			return i
		end
	end

	return 0
end
--**********************************
--对话窗口信息提示
--**********************************
function x000161_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end


--**********************************
--醒目提示
--**********************************
function x000161_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--关闭对话框
--**********************************
function x000161_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end