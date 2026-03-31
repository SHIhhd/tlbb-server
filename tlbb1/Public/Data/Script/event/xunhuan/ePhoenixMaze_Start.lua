--**********************************
-- 凤凰陵墓活动启动
--**********************************
x050062_g_ScriptId	= 050062
--npc的id
x050062_g_ePhoenixMazeNpc = 13786
--npc调用的script
x050062_g_NpcScript = 50064
--要刷新的怪物坐标
x050062_g_scenePosInfoList = {
	{
		sceneId = 443,
		posList=
		{
			{x=102, z=119},{x=144, z=145},{x=234, z=199},{x=119, z=87},
			{x=87, z=135},{x=147, z=178},{x=192, z=167},{x=192, z=88},
			{x=86, z=148},{x=176, z=146},{x=233, z=119},{x=112, z=209},
			{x=83, z=174},{x=137, z=206},{x=171, z=94},{x=117, z=235},
			{x=84, z=197},{x=164, z=213},{x=162, z=118},{x=161, z=161},
			{x=113, z=209},{x=148, z=234},{x=170, z=196},{x=70, z=119},
			{x=125, z=167},{x=193, z=237},{x=183, z=120},{x=88, z=134},
			{x=126, z=156},{x=203, z=204},{x=130, z=113},{x=237, z=155},
		}
	},
}
--**********************************
-- 数据对比
--**********************************
function x050062_InList(Data,List)
    for i, Element in List do
        if Element == Data then
            return 1
        end
    end
    return 0    
end
--**********************************
-- 随机数据塞入
--**********************************
function x050062_GetValidIndex( PosList, IndexList )
    local PosListSize = getn(PosList)
    local IndexListSize = getn(IndexList)
    local i = 0
    local Data = 1
    while i < 50 do
        Data = random( PosListSize )
        local bInList = x050062_InList(Data,IndexList )
        if  0 == bInList  then
            i = 50
        end
        i = i + 1 --为防止死循环,当 i超过50时,将退出循环
    end
    IndexList[IndexListSize + 1] = Data
end
--**********************************
-- 循环执行随机数据塞入多少次
--**********************************
function x050062_CollectIndex( PosList, IndexList, IndexListSize )
    for i = 1,IndexListSize do
        x050062_GetValidIndex( PosList,IndexList )
    end
    
end
--**********************************
-- 生成摸金校尉
--**********************************
function x050062_GenObj( sceneId, PosList )
    local PosIndex = {}
    local IndexList = {}
    
    local IndexListSize = 20 --默认一波20只。
    x050062_CollectIndex( PosList,IndexList,IndexListSize )
    local IndexListSize = getn(IndexList)
    for i=1, IndexListSize do
        local this_x,this_z = x050062_Random_posdata(PosList[IndexList[i]].x, PosList[ IndexList[i] ].z, 0 )
		local MonsterId = LuaFnCreateMonster(sceneId,x050062_g_ePhoenixMazeNpc,this_x,this_z,3,-1,x050062_g_NpcScript)
		if MonsterId > -1 then --防止空参数。
			SetCharacterDieTime(sceneId,MonsterId,floor(20 * 60 * 1000)) --一波怪物的存在时间为20分钟，过时清除
		end
    end
end

--**********************************
--心跳函数
--**********************************
function x050062_OnTimer( sceneId, actId, uTime )
	--检测活动是否过期
	if CheckActiviyValidity( sceneId, actId ) == 0 then
		StopOneActivity(sceneId,actId)
	else
		for i, v in x050062_g_scenePosInfoList do
			if v.sceneId == sceneId then
				x050062_GenObj(sceneId,v.posList)
			end
		end
	end
end

--**********************************
--事件交互入口
--**********************************
function x050062_OnDefaultEvent( sceneId, actId, param1, param2, param3, param4, param5 )
	--检测数据合法性
	if actId == -1 or GetScenePreActiveActivityId(sceneId) ~= actId then
		return
	end
	StartOneActivity( sceneId, actId, floor(20 * 60 * 1000),param1)
	--活动开始时，回调一次，其余利用心跳回调。
	for i, v in x050062_g_scenePosInfoList do
		if v.sceneId == sceneId then
			x050062_GenObj(sceneId,v.posList)
		end
	end
end
--**********************************
-- 随机选取坐标
--**********************************
function x050062_Random_posdata(position_x,position_z,Range)
	local Variety_X,Variety_Z;
	if position_x > 2 then
		Variety_X = position_x
	end
 
	if position_z > 2 then
		Variety_Z = position_z
	end

 return Variety_X,Variety_Z
end