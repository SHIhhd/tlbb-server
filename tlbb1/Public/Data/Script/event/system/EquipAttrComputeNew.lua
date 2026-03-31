--===================================================
-- 人物装备属性计算 EQUIP_COMPUTE
-- @雪舞制作 2025-12-20 V1.2
--===================================================

--**********************************
--刷新人物属性函数
--**********************************
function x866010_StartComputeHumanData(sceneId,selfId,Update)
	if sceneId < 0 or selfId < 14999 or selfId > 29999 then
		return
	end
	if LuaFnIsObjValid(sceneId,selfId) ~= 1 or LuaFnIsCanDoScriptLogic(sceneId,selfId) ~= 1 then 
		return
	end
	
	-- 怪物图鉴属性结算
	local A = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
	A[1], A[2], A[3], A[4], A[5], A[6], A[7], A[8], A[9], A[10], A[11], A[12], A[13], A[14], A[15], A[16], A[17], A[18], A[19], A[20], A[21], A[22], A[23], A[24], A[25], A[26], A[27], A[28], A[29], A[30], A[31], A[32] = CallScriptFunction(912217,"MonsterBookMain",sceneId,selfId,0,0,0,0,3)


	local nLevel = GetLevel(sceneId,selfId)		
	local WJInfo = {0,0,0,0,0,0,0,0,0}
	WJInfo[1],WJInfo[2],WJInfo[3],WJInfo[4],WJInfo[5],WJInfo[6],WJInfo[7],WJInfo[8],WJInfo[9] = CallScriptFunction(502161,"GetDfengAttr",sceneId,selfId)

	--**********************************
	--基础属性
	--**********************************
	local STR,SPR,CON,INT,DEX,HP,MP,HP_PERSENT = 0,0,0,0,0,0,0,0
	
	--百分比血上限
	HP_PERSENT = 0
	--血量：
	HP  = A[1]
	--蓝量：
	MP  = A[2]
	--力量：
	STR = A[3] + A[8] + WJInfo[6]
	--灵气：
	SPR = A[4] + A[8] + WJInfo[7]
	--体力：
	CON = A[5] + A[8] + WJInfo[5]
	--定力：
	INT = A[6] + A[8] + WJInfo[8]
	--身法：
	DEX = A[7] + A[8] + WJInfo[9]
	
	--**********************************
	--二级属性
	--**********************************
	local AttackPhysics,AttackMagic,DefencePhysics,DefenceMagic,Hit,Miss,CriticalAttack,CriticalDefence = 0,0,0,0,0,0,0,0
	--外功攻击：
	AttackPhysics 	= A[9] + WJInfo[1]
	--内功攻击：
	AttackMagic 	= A[10] + WJInfo[3]
	--外功防御：
	DefencePhysics 	= A[11] + WJInfo[2]
	--内功防御：
	DefenceMagic 	= A[12] + WJInfo[4]
	--命中：
	Hit 			= A[14]
	--闪避：
	Miss 			= A[13]
	--会心攻击：
	CriticalAttack 	= A[15]
	--会心防御：
	CriticalDefence = A[16]
	
	--**********************************
	--冰火玄毒属性：属性攻击
	--**********************************
	local IceAttack,FireAttack,LightAttack,PosionAttack = 0,0,0,0
	IceAttack 		= A[17]
	FireAttack 		= A[18]
	LightAttack 	= A[19]
	PosionAttack 	= A[20]
	
	--**********************************
	--冰火玄毒属性：属性抗
	--**********************************
	local IceDefence,FireDefence,LightDefence,PosionDefence = 0,0,0,0
	IceDefence 		= A[21]
	FireDefence 	= A[22]
	LightDefence 	= A[23]
	PosionDefence 	= A[24]

	--**********************************
	--属性减抗
	--**********************************
	local IceSubDefence,FireSubDefence,LightSubDefence,PosionSubDefence = 0,0,0,0
	IceSubDefence 		= A[25] 	
	FireSubDefence 		= A[26]
	LightSubDefence 	= A[27] 		
	PosionSubDefence 	= A[28] 	
	
	--**********************************
	--属性减抗下限
	--**********************************
	local IceSubDefenceLimit,FireSubDefenceLimit,LightSubDefenceLimit,PosionSubDefenceLimit = 0,0,0,0
	IceSubDefenceLimit = A[29] 
	FireSubDefenceLimit = A[30] 
	LightSubDefenceLimit = A[31] 
	PosionSubDefenceLimit = A[32] 
	
	--**********************************
	--GM隐藏属性加成 (MDEX)
	--通过GM工具SetMissionDataEx写入的额外属性
	--**********************************
	HP              = HP              + GetMissionDataEx(sceneId,selfId,MDEX_MAX_HP)
	MP              = MP              + GetMissionDataEx(sceneId,selfId,MDEX_MAX_MP)
	STR             = STR             + GetMissionDataEx(sceneId,selfId,MDEX_STR)
	SPR             = SPR             + GetMissionDataEx(sceneId,selfId,MDEX_SPR)
	CON             = CON             + GetMissionDataEx(sceneId,selfId,MDEX_CON)
	INT             = INT             + GetMissionDataEx(sceneId,selfId,MDEX_INT)
	DEX             = DEX             + GetMissionDataEx(sceneId,selfId,MDEX_DEX)
	AttackPhysics   = AttackPhysics   + GetMissionDataEx(sceneId,selfId,MDEX_WG)
	DefencePhysics  = DefencePhysics  + GetMissionDataEx(sceneId,selfId,MDEX_WF)
	AttackMagic     = AttackMagic     + GetMissionDataEx(sceneId,selfId,MDEX_NG)
	DefenceMagic    = DefenceMagic    + GetMissionDataEx(sceneId,selfId,MDEX_NF)
	Miss            = Miss            + GetMissionDataEx(sceneId,selfId,MDEX_MISS)
	Hit             = Hit             + GetMissionDataEx(sceneId,selfId,MDEX_HIT)
	CriticalAttack  = CriticalAttack  + GetMissionDataEx(sceneId,selfId,MDEX_HUIXINGONG)
	CriticalDefence = CriticalDefence + GetMissionDataEx(sceneId,selfId,MDEX_HUIXINFANG)
	IceAttack       = IceAttack       + GetMissionDataEx(sceneId,selfId,MDEX_ICE_ATTR)
	FireAttack      = FireAttack      + GetMissionDataEx(sceneId,selfId,MDEX_FIRE_ATTR)
	LightAttack     = LightAttack     + GetMissionDataEx(sceneId,selfId,MDEX_LIGHT_ATTR)
	PosionAttack    = PosionAttack    + GetMissionDataEx(sceneId,selfId,MDEX_POSION_ATTR)
	IceDefence      = IceDefence      + GetMissionDataEx(sceneId,selfId,MDEX_ICE_DEC)
	FireDefence     = FireDefence     + GetMissionDataEx(sceneId,selfId,MDEX_FIRE_DEC)
	LightDefence    = LightDefence    + GetMissionDataEx(sceneId,selfId,MDEX_LIGHT_DEC)
	PosionDefence   = PosionDefence   + GetMissionDataEx(sceneId,selfId,MDEX_POSION_DEC)
	IceSubDefence       = IceSubDefence       + GetMissionDataEx(sceneId,selfId,MDEX_ICE_SUB_DEC)
	FireSubDefence      = FireSubDefence      + GetMissionDataEx(sceneId,selfId,MDEX_FIRE_SUB_DEC)
	LightSubDefence     = LightSubDefence     + GetMissionDataEx(sceneId,selfId,MDEX_LIGHT_SUB_DEC)
	PosionSubDefence    = PosionSubDefence    + GetMissionDataEx(sceneId,selfId,MDEX_POSION_SUB_DEC)
	IceSubDefenceLimit      = IceSubDefenceLimit      + GetMissionDataEx(sceneId,selfId,MDEX_ICE_SUB_LIMIT)
	FireSubDefenceLimit     = FireSubDefenceLimit     + GetMissionDataEx(sceneId,selfId,MDEX_FIRE_SUB_LIMIT)
	LightSubDefenceLimit    = LightSubDefenceLimit    + GetMissionDataEx(sceneId,selfId,MDEX_LIGHT_SUB_LIMIT)
	PosionSubDefenceLimit   = PosionSubDefenceLimit   + GetMissionDataEx(sceneId,selfId,MDEX_POSION_SUB_LIMIT)
	HP_PERSENT      = HP_PERSENT      + GetMissionDataEx(sceneId,selfId,MDEX_MAX_HP_PERSENT)
	
	--穿刺属性(新增，原结算无此项)
	local ChuanCiDamage = GetMissionDataEx(sceneId,selfId,MDEX_CHUANCI_SH)
	local ChuanCiReduce = GetMissionDataEx(sceneId,selfId,MDEX_CHUANCI_JM)
	
	--**********************************
	--引擎计算部分
	--**********************************
	--百分比增加血上限
	SetMissionDataEx(sceneId,selfId,SYS_MAX_HP_PERSENT,HP_PERSENT)
	--血上限
	SetMissionDataEx(sceneId,selfId,SYS_MAX_HP,HP)	
	--气上限
	SetMissionDataEx(sceneId,selfId,SYS_MAX_MP,MP)	
	
	--一级属性
	SetMissionDataEx(sceneId,selfId,SYS_STR,STR)
	SetMissionDataEx(sceneId,selfId,SYS_SPR,SPR)
	SetMissionDataEx(sceneId,selfId,SYS_CON,CON)
	SetMissionDataEx(sceneId,selfId,SYS_INT,INT)
	SetMissionDataEx(sceneId,selfId,SYS_DEX,DEX)
	
	--二级属性
	SetMissionDataEx(sceneId,selfId,SYS_WG,AttackPhysics)
	SetMissionDataEx(sceneId,selfId,SYS_WF,DefencePhysics)
	SetMissionDataEx(sceneId,selfId,SYS_NG,AttackMagic)
	SetMissionDataEx(sceneId,selfId,SYS_NF,DefenceMagic)
	SetMissionDataEx(sceneId,selfId,SYS_MISS,Miss)
	SetMissionDataEx(sceneId,selfId,SYS_HIT,Hit)
	SetMissionDataEx(sceneId,selfId,SYS_HUIXINGONG,CriticalAttack)
	SetMissionDataEx(sceneId,selfId,SYS_HUIXINFANG,CriticalDefence)
	
	--属性攻击
	SetMissionDataEx(sceneId,selfId,SYS_ICE_ATTR,IceAttack)
	SetMissionDataEx(sceneId,selfId,SYS_FIRE_ATTR,FireAttack)
	SetMissionDataEx(sceneId,selfId,SYS_LIGHT_ATTR,LightAttack)
	SetMissionDataEx(sceneId,selfId,SYS_POSION_ATTR,PosionAttack)
	
	--属性减免 抗性
	SetMissionDataEx(sceneId,selfId,SYS_ICE_DEC,IceDefence)
	SetMissionDataEx(sceneId,selfId,SYS_FIRE_DEC,FireDefence)
	SetMissionDataEx(sceneId,selfId,SYS_LIGHT_DEC,LightDefence)
	SetMissionDataEx(sceneId,selfId,SYS_POSION_DEC,PosionDefence)
	
	--减抗
	SetMissionDataEx(sceneId,selfId,SYS_ICE_SUB_DEC,IceSubDefence)
	SetMissionDataEx(sceneId,selfId,SYS_FIRE_SUB_DEC,FireSubDefence)
	SetMissionDataEx(sceneId,selfId,SYS_LIGHT_SUB_DEC,LightSubDefence)
	SetMissionDataEx(sceneId,selfId,SYS_POSION_SUB_DEC,PosionSubDefence)
	
	--减抗下限
	SetMissionDataEx(sceneId,selfId,SYS_ICE_SUB_LIMIT,IceSubDefenceLimit)
	SetMissionDataEx(sceneId,selfId,SYS_FIRE_SUB_LIMIT,FireSubDefenceLimit)
	SetMissionDataEx(sceneId,selfId,SYS_LIGHT_SUB_LIMIT,LightSubDefenceLimit)
	SetMissionDataEx(sceneId,selfId,SYS_POSION_SUB_LIMIT,PosionSubDefenceLimit)
	
	--穿刺攻击
	LuaFnSetChuanCi(sceneId,selfId,0,ChuanCiDamage)
	--穿刺减免
	LuaFnSetChuanCi(sceneId,selfId,1,ChuanCiReduce)
	
	--GM超级属性
	if GetMissionFlag(sceneId,selfId,MF_GM_ATTRMAX) == 1 then
		x866010_GM_ATTRMAX(sceneId,selfId)
	end
	
	--刷新引擎人物结算属性
	if Update ~= nil then
		LuaFnRefreshEngine( sceneId, selfId )
	end
	
	--刷新角色评分
	-- x866010_LuaFnGetEquipGride(sceneId,selfId)	
end

--**********************************
--GM超级属性
--**********************************
function x866010_GM_ATTRMAX(sceneId,selfId)	
	SetMissionData(sceneId,selfId,SYS_MAX_HP,558000000)
	SetMissionData(sceneId,selfId,SYS_MAX_MP,500000)
	--一级属性
	SetMissionDataEx(sceneId,selfId,SYS_STR,1950)
	SetMissionDataEx(sceneId,selfId,SYS_SPR,1950)
	SetMissionDataEx(sceneId,selfId,SYS_CON,1950)
	SetMissionDataEx(sceneId,selfId,SYS_INT,1950)
	SetMissionDataEx(sceneId,selfId,SYS_DEX,1950)
	
	--属性攻击
	SetMissionDataEx(sceneId,selfId,SYS_ICE_ATTR,1988)
	SetMissionDataEx(sceneId,selfId,SYS_FIRE_ATTR,1988)
	SetMissionDataEx(sceneId,selfId,SYS_LIGHT_ATTR,1988)
	SetMissionDataEx(sceneId,selfId,SYS_POSION_ATTR,1988)	
	--属性减免
	SetMissionDataEx(sceneId,selfId,SYS_ICE_DEC,520)
	SetMissionDataEx(sceneId,selfId,SYS_FIRE_DEC,520)
	SetMissionDataEx(sceneId,selfId,SYS_LIGHT_DEC,520)
	SetMissionDataEx(sceneId,selfId,SYS_POSION_DEC,520)
	--减抗
	SetMissionDataEx(sceneId,selfId,SYS_ICE_SUB_DEC,512)
	SetMissionDataEx(sceneId,selfId,SYS_FIRE_SUB_DEC,512)
	SetMissionDataEx(sceneId,selfId,SYS_LIGHT_SUB_DEC,512)
	SetMissionDataEx(sceneId,selfId,SYS_POSION_SUB_DEC,512)
	--减抗下限
	SetMissionDataEx(sceneId,selfId,SYS_ICE_SUB_LIMIT,30)
	SetMissionDataEx(sceneId,selfId,SYS_FIRE_SUB_LIMIT,30)
	SetMissionDataEx(sceneId,selfId,SYS_LIGHT_SUB_LIMIT,30)
	SetMissionDataEx(sceneId,selfId,SYS_POSION_SUB_LIMIT,30)
end


--**********************************
-- 屏幕中间提示
--**********************************
function x866010_Tips(sceneId,selfId,msg)
	BeginEvent(sceneId)
		AddText(sceneId,msg);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end