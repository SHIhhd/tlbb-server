--草原 BOSS群刷新脚本

--脚本号
x810003_g_ScriptId	= 810003

--刷新方式为:
--激活此脚本时定点刷出10个BOSS....

--需要刷出的BOSS的数据表....
--BOSS的MonsterID不能重复....在场景中同一时刻同一个MonsterID的怪只能存在一个....有了就不刷了....
x810003_g_BossData = {

	-- ID						BOSS的 monster id
	-- Title				BOSS的称号....
	-- PosX					坐标
	-- PosY					坐标
	-- BaseAI				BOSS的BaseAI....
	-- ExtAIScript	BOSS的扩展AI....
	-- ScriptID			BOSS的脚本ID....
	-- NeedCreate		都填1....

	{ ID=9130, Title="妙手空空", PosX=77,  PosY=124, BaseAI=29, ExtAIScript=256, ScriptID=-1, NeedCreate=1 },
	{ ID=9131, Title="妙手走卒", PosX=44,  PosY=72,  BaseAI=29, ExtAIScript=256, ScriptID=-1, NeedCreate=1 },
	{ ID=9132, Title="妙手走卒", PosX=83,  PosY=66,  BaseAI=29, ExtAIScript=256, ScriptID=-1, NeedCreate=1 },
	{ ID=9133, Title="妙手走卒", PosX=100, PosY=90,  BaseAI=29, ExtAIScript=256, ScriptID=-1, NeedCreate=1 },
	{ ID=9134, Title="妙手走卒", PosX=58,  PosY=121, BaseAI=29, ExtAIScript=256, ScriptID=-1, NeedCreate=1 },
	{ ID=9135, Title="妙手走卒", PosX=167, PosY=63,  BaseAI=29, ExtAIScript=256, ScriptID=-1, NeedCreate=1 },
	{ ID=9136, Title="妙手走卒", PosX=280, PosY=284, BaseAI=29, ExtAIScript=256, ScriptID=-1, NeedCreate=1 },
	{ ID=9137, Title="妙手走卒", PosX=64,  PosY=253, BaseAI=29, ExtAIScript=256, ScriptID=-1, NeedCreate=1 },
	{ ID=9138, Title="妙手走卒", PosX=190, PosY=49,  BaseAI=29, ExtAIScript=256, ScriptID=-1, NeedCreate=1 },
	{ ID=9139, Title="妙手走卒", PosX=276, PosY=127, BaseAI=29, ExtAIScript=256, ScriptID=-1, NeedCreate=1 },
}


--**********************************
--脚本入口函数
--**********************************
function x810003_OnDefaultEvent( sceneId, actId, iNoticeType, param2, param3, param4, param5 )
	--检测数据合法性
	if actId == -1 or GetScenePreActiveActivityId(sceneId) ~= actId then
		return
	end
	--开启活动....
	StartOneActivity( sceneId, actId, 180*1000, iNoticeType )

	--BOSS数据表为空就不刷BOSS....
	if getn(x810003_g_BossData) < 1 then
		return
	end

	--重置Boss重建状态....
	for _, Data in x810003_g_BossData do
		Data.NeedCreate = 1
	end

	--遍历场景中所有的怪....更新BOSS重建状态....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		local MosDataID = GetMonsterDataID( sceneId, MonsterId )
		x810003_CurSceneHaveMonster( sceneId, MosDataID )
	end

	--重建需要重建的BOSS....
	for _, BossData in x810003_g_BossData do
		if BossData.NeedCreate == 1 then
			MstId = LuaFnCreateMonster(sceneId, BossData.ID, BossData.PosX, BossData.PosY, BossData.BaseAI, BossData.ExtAIScript, BossData.ScriptID )
			SetCharacterTitle(sceneId, MstId, BossData.Title)
		end
	end

end

--**********************************
--心跳函数
--**********************************
function x810003_OnTimer( sceneId, actId, uTime )

	--检测活动是否过期
	if CheckActiviyValidity( sceneId, actId ) == 0 then
		StopOneActivity( sceneId, actId )
	end

end

--**********************************
--用于更新重建状态....
--**********************************
function x810003_CurSceneHaveMonster( sceneId, DataID )

	for i, Data in x810003_g_BossData do
		if DataID == Data.ID then
			x810003_g_BossData[i].NeedCreate = 0
			break
		end
	end

end
