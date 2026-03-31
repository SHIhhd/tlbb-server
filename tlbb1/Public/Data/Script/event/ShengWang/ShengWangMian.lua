--万事阁主功能
--脚本号
x890063_g_ScriptId = 890063
x890063_g_MinLevel = 85

x890063_g_Camp = {
	--白溪湖
	[1] = {
		tarName = "墨知愁",
		join_tips = "#{SWXT_221213_109}"
	},
	--蜀南竹海
	[2] = {
		tarName = "江行云",
		join_tips = "#{SWXT_221213_110}"
	},
	--西凉枫林
	[3] = {
		tarName = "阮枫眠",
		join_tips = "#{SWXT_221213_111}"
	},
}
--任务集合
x890063_g_ShengWangAll_MissionCount = 3		--角色能接取的最大任务数量
x890063_g_ShengWangAll_MissionRealCount = 6
x890063_g_ShengWangAll_MissionInfo = {
	--阵营1
	[1] = {
			[1]={missionid=2130, name="#{SWXT_221213_142}",des="#{SWXT_221213_144}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=613,posX=130,posZ=190,NPCname="墨如",AcceptTimeParam=5},
			[2]={missionid=2131, name="#{SWXT_221213_145}",des="#{SWXT_221213_146}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=613,posX=130,posZ=190,NPCname="墨如",AcceptTimeParam=5},
			[3]={missionid=2132, name="#{SWXT_221213_147}",des="#{SWXT_221213_149}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=613,posX=125,posZ=178,NPCname="墨晓清",AcceptTimeParam=5},
			[4]={missionid=2133, name="#{SWXT_221213_150}",des="#{SWXT_221213_151}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=613,posX=63,posZ=53,NPCname="墨知愁",AcceptTimeParam=5},
			[5]={missionid=2134, name="#{SWXT_221213_152}",des="#{SWXT_221213_153}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=613,posX=63,posZ=53,NPCname="墨知愁",AcceptTimeParam=5},
			[6]={missionid=2135, name="#{SWXT_221213_154}",des="#{SWXT_221213_155}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=613,posX=63,posZ=53,NPCname="墨知愁",AcceptTimeParam=5},
			[7]={missionid=2136, name="#{SWXT_221213_156}",des="#{SWXT_221213_157}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=613,posX=63,posZ=53,NPCname="墨知愁",AcceptTimeParam=5},
			[8]={missionid=2155, name="#{SWXT_221213_158}",des="#{SWXT_221213_160}",grade="set:ShengWang01 image:ShengWangAll_KunNan",bonus=25,scene=613,posX=130,posZ=190,NPCname="墨如",AcceptTimeParam=3},
		},
	--阵营2
	[2] = {
			[1]={missionid=2137, name="#{SWXT_221213_161}",des="#{SWXT_221213_162}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=614,posX=62,posZ=199,NPCname="墨忆",AcceptTimeParam=5},
			[2]={missionid=2138, name="#{SWXT_221213_163}",des="#{SWXT_221213_164}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=614,posX=70,posZ=37,NPCname="墨星翁",AcceptTimeParam=5},
			[3]={missionid=2139, name="#{SWXT_221213_165}",des="#{SWXT_221213_166}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=614,posX=69,posZ=142,NPCname="墨北辰",AcceptTimeParam=5},
			[4]={missionid=2140, name="#{SWXT_221213_167}",des="#{SWXT_221213_168}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=614,posX=37,posZ=119,NPCname="江行云",AcceptTimeParam=5},
			[5]={missionid=2141, name="#{SWXT_221213_169}",des="#{SWXT_221213_170}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=614,posX=56,posZ=198,NPCname="墨思思",AcceptTimeParam=5},
			[6]={missionid=2142, name="#{SWXT_221213_171}",des="#{SWXT_221213_172}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=614,posX=37,posZ=119,NPCname="江行云",AcceptTimeParam=5},
			[7]={missionid=2143, name="#{SWXT_221213_173}",des="#{SWXT_221213_174}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=614,posX=37,posZ=119,NPCname="江行云",AcceptTimeParam=5},
			[8]={missionid=2156, name="#{SWXT_221213_175}",des="#{SWXT_221213_176}",grade="set:ShengWang01 image:ShengWangAll_KunNan",bonus=25,scene=614,posX=70,posZ=37,NPCname="墨星翁",AcceptTimeParam=3},
		},
	--阵营3
	[3] = {
			[1]={missionid=2144, name="#{SWXT_221213_177}",des="#{SWXT_221213_178}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=615,posX=54,posZ=58,NPCname="墨离",AcceptTimeParam=5},
			[2]={missionid=2145, name="#{SWXT_221213_179}",des="#{SWXT_221213_180}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=615,posX=75,posZ=60,NPCname="墨回",AcceptTimeParam=5},
			[3]={missionid=2146, name="#{SWXT_221213_181}",des="#{SWXT_221213_182}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=615,posX=65,posZ=52,NPCname="阮枫眠",AcceptTimeParam=5},
			[4]={missionid=2147, name="#{SWXT_221213_183}",des="#{SWXT_221213_184}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=615,posX=54,posZ=58,NPCname="墨离",AcceptTimeParam=5},
			[5]={missionid=2148, name="#{SWXT_221213_185}",des="#{SWXT_221213_186}",grade="set:ShengWang01 image:ShengWangAll_JianDan",bonus=10,scene=615,posX=65,posZ=52,NPCname="阮枫眠",AcceptTimeParam=5},
			[6]={missionid=2149, name="#{SWXT_221213_187}",des="#{SWXT_221213_188}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=615,posX=65,posZ=52,NPCname="阮枫眠",AcceptTimeParam=5},
			[7]={missionid=2150, name="#{SWXT_221213_189}",des="#{SWXT_221213_190}",grade="set:ShengWang01 image:ShengWangAll_PuTong",bonus=15,scene=615,posX=62,posZ=52,NPCname="阮枫眠",AcceptTimeParam=5},
			[8]={missionid=2157, name="#{SWXT_221213_191}",des="#{SWXT_221213_192}",grade="set:ShengWang01 image:ShengWangAll_KunNan",bonus=25,scene=615,posX=54,posZ=58,NPCname="墨离",AcceptTimeParam=3},
		},
}
--声望生活技能配置
x890063_g_ShengWangLifeAbility = {
	--天鉴铸法·无忌
	[1] = {
		abilityId = ABILITY_TJZF_WUJI,
		idPrescription = {
			1154,
			1155,
			1160,
			1161,
			1166,
			1167,
			1172,
			1173,
			1178,
			1179,
			1184,
			1185,
		}
	},
	--天鉴铸法·守心
	[2] = {
		abilityId = ABILITY_TJZF_SHOUXIN,
		idPrescription = {
			1156,
			1157,
			1162,
			1163,
			1168,
			1169,
			1174,
			1175,
			1180,
			1181,
			1186,
			1187,
		}
	},
	--天鉴铸法·破阵
	[3] = {
		abilityId = ABILITY_TJZF_POZHEN,
		idPrescription = {
			1158,
			1159,
			1164,
			1165,
			1170,
			1171,
			1176,
			1177,
			1182,
			1183,
			1188,
			1189,
		}
	},
}
--**********************************
--商会物品购买
--**********************************
function x890063_YBbuyitem( sceneId, selfId,targetId,npcCampId,buyItemId )
	if GetLevel(sceneId,selfId) < x890063_g_MinLevel then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_78}")
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_79}")
		return
	end
	if x890063_g_Camp[npcCampId] == nil or GetName(sceneId,targetId) ~= x890063_g_Camp[npcCampId].tarName then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_80}")
		return
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId ~= npcCampId then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_81}")
		return
	end
	local nItemNum,strItemName,nCost,nWeekLimied,bBindItem = LuaFnGetShengWangYBShopData(nCampId, buyItemId)
	if nItemNum <= 0 then
		return
	end
	if nWeekLimied > 0 then
		local nCurBuyCount = LuaFnGetShengWangYBShopBuyCount(sceneId,selfId,buyItemId)
		if nCurBuyCount >= nWeekLimied then
			x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_82}")
			return
		end
	end
	local nCurYuanBao = YuanBao(sceneId,selfId,targetId,3,0)
	if nCost > nCurYuanBao then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_97}")
		return
	end
	--检测背包空间是否足够
	BeginAddItem(sceneId)
	if bBindItem == 1 then
		AddBindItem(sceneId,buyItemId, nItemNum)
	else
		AddItem(sceneId,buyItemId, nItemNum)
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--扣除元宝
	if LuaFnCostYuanBao(sceneId,selfId,nCost,890063,"YBbuyitem",buyItemId, nItemNum) ~= 1 then
		return
	end
	--添加物品
	AddItemListToHuman(sceneId,selfId)
	--增加购买数量
	LuaFnAddShengWangYBShopBuyCount(sceneId,selfId,buyItemId, nItemNum)
	--SWXT_221213_84	#H您成功兑换了%s0个%s1。	
	x890063_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{SWXT_221213_84}",tostring(nItemNum),strItemName))
	--更新页面
	LuaFnUpdateShengWangAllPage(sceneId,selfId,targetId,npcCampId,3)
end
--**********************************
--密库物品购买
--**********************************
function x890063_buyitem(  sceneId, selfId,targetId,npcCampId,buyItemId )
	if GetLevel(sceneId,selfId) < x890063_g_MinLevel then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_78}")
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_79}")
		return
	end
	if x890063_g_Camp[npcCampId] == nil or GetName(sceneId,targetId) ~= x890063_g_Camp[npcCampId].tarName then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_80}")
		return
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId ~= npcCampId then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_81}")
		return
	end
	local nItemNum,strItemName,nCost,nWeekLimied,bBindItem = LuaFnGetShengWangShopData(nCampId, buyItemId)
	if nItemNum <= 0 then
		return
	end
	if nWeekLimied > 0 then
		local nCurBuyCount = LuaFnGetShengWangShopBuyCount(sceneId,selfId,buyItemId)
		if nCurBuyCount >= nWeekLimied then
			x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_82}")
			return
		end
	end
	local nCurPoint = LuaFnGetShengWangPoint(sceneId,selfId)
	if nCost > nCurPoint then
		x890063_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{SWXT_221213_83}",tostring(nCost)))
		return
	end
	--检测背包空间是否足够
	BeginAddItem(sceneId)
	if bBindItem == 1 then
		AddBindItem(sceneId,buyItemId, nItemNum)
	else
		AddItem(sceneId,buyItemId, nItemNum)
	end
	if EndAddItem(sceneId,selfId) <= 0 then
		return
	end
	--扣除代币
	LuaFnSetShengWangPoint(sceneId,selfId,nCurPoint-nCost)
	--添加物品
	AddItemListToHuman(sceneId,selfId)
	--增加购买数量
	LuaFnAddShengWangShopBuyCount(sceneId,selfId,buyItemId, nItemNum)
	--SWXT_221213_84	#H您成功兑换了%s0个%s1。	
	x890063_NotifyTips(sceneId,selfId,ScriptGlobal_Format("#{SWXT_221213_84}",tostring(nItemNum),strItemName))
	--更新页面
	LuaFnUpdateShengWangAllPage(sceneId,selfId,targetId,npcCampId,2)
end

--**********************************
--学习生活技能
--**********************************
function x890063_LearnLifeAbility( sceneId, selfId,npcCampId )
	if x890063_g_ShengWangLifeAbility[npcCampId] == nil then
		return
	end
	--提示学会
	x890063_NotifyTips(sceneId,selfId,"#{SZXT_221216_76}")
	--技能提升到1
	SetHumanAbilityLevel(sceneId,selfId,x890063_g_ShengWangLifeAbility[npcCampId].abilityId,1)
	--学习对应配方
	for i = 1,getn(x890063_g_ShengWangLifeAbility[npcCampId].idPrescription) do
		SetPrescription( sceneId, selfId, x890063_g_ShengWangLifeAbility[npcCampId].idPrescription[i], 1 )
	end
end
--**********************************
--加入阵营
--**********************************
function x890063_JoinCamp( sceneId, selfId, targetId,npcCampId )
	if GetLevel(sceneId,selfId) < x890063_g_MinLevel then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_7}")
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_8}")
		return
	end
	if x890063_g_Camp[npcCampId] == nil or GetName(sceneId,targetId) ~= x890063_g_Camp[npcCampId].tarName then
		return
	end
	local nCampId = LuaFnGetShengWangId(sceneId,selfId)
	if nCampId ~= 0 then
		x890063_NotifyTips(sceneId,selfId,"#{SWXT_221213_108}")
		return
	end
	LuaFnSetShengWangId(sceneId,selfId,npcCampId)
	--随机任务x3
	for i = 1,x890063_g_ShengWangAll_MissionRealCount do	
		LuaFnSetShengWangMissionIndex(sceneId,selfId,i - 1,0)
		LuaFnSetShengWangMissionDoneFlag(sceneId,selfId,i - 1,0)
	end
	for i = 1,x890063_g_ShengWangAll_MissionCount - 1 do		
		local nMissionId = random(1,getn(x890063_g_ShengWangAll_MissionInfo[npcCampId]) - 1);
		while LuaFnHaveShengWangMissionIndex(sceneId,selfId,nMissionId) == 1 do
			nMissionId = random(1,getn(x890063_g_ShengWangAll_MissionInfo[npcCampId]) - 1);
		end
		LuaFnSetShengWangMissionIndex(sceneId,selfId,i - 1,nMissionId)
		LuaFnSetShengWangMissionIndex(sceneId,selfId,i - 1 + 3,nMissionId)
	end
	--第三个任务默认为困难
	local nDifficultMissionIdx = getn(x890063_g_ShengWangAll_MissionInfo[npcCampId])
	LuaFnSetShengWangMissionIndex(sceneId,selfId,x890063_g_ShengWangAll_MissionCount - 1,nDifficultMissionIdx)
	LuaFnSetShengWangMissionIndex(sceneId,selfId,x890063_g_ShengWangAll_MissionRealCount - 1,nDifficultMissionIdx)
	--更新页面
	LuaFnOpenShengWangAllPage(sceneId,selfId,targetId,npcCampId,1)
	x890063_NotifyTips(sceneId,selfId,x890063_g_Camp[npcCampId].join_tips)
end
--**********************************
-- 玩家登录
--**********************************
function x890063_OnPlayerLogin(sceneId,selfId)
	
end
--**********************************
-- 屏幕中间提示
--**********************************
function x890063_NotifyTips(sceneId,selfId,tips)
	BeginEvent(sceneId)
		AddText(sceneId,tips);
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--对话框提示
--**********************************
function x890063_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end