--生长点
--长春石
--脚本号292002

--每次打开必定获得的产品-初级长春玉
x292002_g_MainItemId = 20600000
--需要分山锄
x292002_g_NeedItem = 38002771
--生成函数开始************************************************************************
--每个ItemBox中最多10个物品
function	x292002_OnCreate(sceneId,growPointType,x,y)
	--放入ItemBox同时放入一个物品
	ItemBoxEnterScene(x,y,growPointType,sceneId,QUALITY_MUST_BE_CHANGE,1,x292002_g_MainItemId)	
end
--生成函数结束**********************************************************************


--打开前函数开始&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
function	x292002_OnOpen(sceneId,selfId,targetId)
	if LuaFnGetAvailableItemCount(sceneId,selfId,x292002_g_NeedItem) < 0 then
		x292002_NotifyMsg( sceneId, selfId, "#{CJWK_221220_56}")
		return OR_U_CANNT_DO_THIS_RIGHT_NOW
	end
	return OR_OK
end
--打开前函数结束&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&


--回收函数开始########################################################################
function	x292002_OnRecycle(sceneId,selfId,targetId)
	--返回1，生长点回收
	return 1
end
--回收函数结束########################################################################



--打开后函数开始@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
function	x292002_OnProcOver(sceneId,selfId,targetId)
	LuaFnDelAvailableItem(sceneId,selfId,x292002_g_NeedItem,1)
	return 0
end
--打开后函数结束@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

function x292002_OnTickCreateFinish( sceneId, growPointType, tickCount )
end
--**********************************
--信息提示
--**********************************
function x292002_NotifyMsg( sceneId, selfId, msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

