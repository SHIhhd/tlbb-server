--三生石
x300086_g_scriptId = 300086
x300086_g_MissionId = 1165
--**********************************
--事件交互入口
--**********************************
function x300086_OnDefaultEvent( sceneId, selfId, bagIndex)
	if bagIndex < 0 then
		return
	end
	local nItemId = LuaFnGetItemTableIndexByIndex(sceneId,selfId,bagIndex)
	--获取有缘人的名字
	local _,Creator = LuaFnGetItemCreator(sceneId,selfId,bagIndex)
	--这个情况一般不会出现
	if Creator == nil then
		return
	end
	if nItemId < 40004472 or nItemId > 40004487 then
		return
	end
	local nStory = "#{QSJS_0090702_3}#r"
	local nstoryidx = 1
	local DestName = Creator
	local szName = GetName(sceneId,selfId)
	local misIndex = GetMissionIndexByID(sceneId, selfId, x300086_g_MissionId)--得到任务在20个任务中的序列号
	local param = GetMissionParam(sceneId,selfId,misIndex,0)
	local param_1 = GetMissionParam(sceneId,selfId,misIndex,1)
	if param == 0 and param_1 == 0 then
		SetMissionByIndex(sceneId,selfId,misIndex,0,1)
		SetMissionByIndex(sceneId,selfId,misIndex,1,1)
	end
	if nItemId >= 40004472 and nItemId <= 40004480 then
		nstoryidx = mod(nItemId - 1,10)
	else
		nstoryidx = mod(nItemId - 71,100)
	end

	-- nStory = nStory..storytbl[nstoryidx]
	-- BeginEvent(sceneId)
		-- AddText(sceneId,nStory)
	-- EndEvent(sceneId)
	-- DispatchEventList(sceneId,selfId,-1)
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x300086_IsSkillLikeScript( sceneId, selfId)
	return 0
end

function x300086_ShowNotice(sceneId,selfId,strNotice)
	BeginEvent(sceneId)
		AddText(sceneId,strNotice)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,-1)
end

function x300086_Notify( sceneId, selfId, strNotice)
	BeginEvent( sceneId )
		AddText( sceneId, strNotice )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )    
end
