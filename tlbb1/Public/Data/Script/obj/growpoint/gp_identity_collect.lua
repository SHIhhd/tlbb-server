-- 新身份系统 各身份采集点和采集规则

-- 脚本号
x890350_g_ScriptId = 890350

-- 生长点信息
x890350_g_GPInfo = {}

-- 随机因子
x890350_g_RandNum = 100

--1-4级的材料采集需要15点神功值，丰产需要30点。
--4-6级的材料采集需要20点神功值，丰产需要40点。
--7-8级的材料采集需要25点神功值，丰产需要50点。
--9-10级的材料采集需要30点神功值，丰产需要60点。

x890350_g_GPInfo[820] = {name = "香蒲",mainId = 21000004,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=1,ibPowerCost = 15,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[821] = {name = "芝兰",mainId = 21000005,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=4,ibPowerCost = 20,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[822] = {name = "血茯苓",mainId = 21000006,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=7,ibPowerCost = 25,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[823] = {name = "粳稻",mainId = 21000000,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=1,ibPowerCost = 15,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[824] = {name = "茭白",mainId = 21000001,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=4,ibPowerCost = 20,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[825] = {name = "盈月笋",mainId = 21000002,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=7,ibPowerCost = 25,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[826] = {name = "青铜",mainId = 21000008,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=1,ibPowerCost = 15,isRich=0,aOdds1=25,associatedId={21000028,21000029,21000030,21000031},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[827] = {name = "玄铁",mainId = 21000009,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=4,ibPowerCost = 20,isRich=0,aOdds1=25,associatedId={21000032,21000033,21000034,21000035},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[828] = {name = "锻月银",mainId = 21000010,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=7,ibPowerCost = 25,isRich=0,aOdds1=25,associatedId={21000036,21000037,21000038,21000039},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[829] = {name = "桦枝",mainId = 21000016,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=1,ibPowerCost = 15,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[830] = {name = "霜竹",mainId = 21000017,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=4,ibPowerCost = 20,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[831] = {name = "贞云松",mainId = 21000018,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=7,ibPowerCost = 25,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[832] = {name = "香蒲·丰产",mainId = 21000004,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=1,ibPowerCost = 15,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[833] = {name = "香蒲·丰产",mainId = 21000004,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=1,ibPowerCost = 15,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[834] = {name = "芝兰·丰产",mainId = 21000005,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=4,ibPowerCost = 20,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[835] = {name = "血茯苓·丰产",mainId = 21000006,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=7,ibPowerCost = 25,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[836] = {name = "粳稻·丰产",mainId = 21000000,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=1,ibPowerCost = 15,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[837] = {name = "粳稻·丰产",mainId = 21000000,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=1,ibPowerCost = 15,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[838] = {name = "茭白·丰产",mainId = 21000001,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=4,ibPowerCost = 20,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[839] = {name = "盈月笋·丰产",mainId = 21000002,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=7,ibPowerCost = 25,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[840] = {name = "青铜·丰产",mainId = 21000008,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=1,ibPowerCost = 15,isRich=1,aOdds1=25,associatedId={21000028,21000029,21000030,21000031},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[841] = {name = "青铜·丰产",mainId = 21000008,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=1,ibPowerCost = 15,isRich=1,aOdds1=25,associatedId={21000028,21000029,21000030,21000031},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[842] = {name = "玄铁·丰产",mainId = 21000009,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=4,ibPowerCost = 20,isRich=1,aOdds1=25,associatedId={21000032,21000033,21000034,21000035},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[843] = {name = "锻月银·丰产",mainId = 21000010,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=7,ibPowerCost = 25,isRich=1,aOdds1=25,associatedId={21000036,21000037,21000038,21000039},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[844] = {name = "桦枝·丰产",mainId = 21000016,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=1,ibPowerCost = 15,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[845] = {name = "桦枝·丰产",mainId = 21000016,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=1,ibPowerCost = 15,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000044,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[846] = {name = "霜竹·丰产",mainId = 21000017,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=4,ibPowerCost = 20,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[847] = {name = "贞云松·丰产",mainId = 21000018,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=7,ibPowerCost = 25,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[848] = {name = "芝兰",mainId = 21000005,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=4,ibPowerCost = 20,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[849] = {name = "血茯苓",mainId = 21000006,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=7,ibPowerCost = 25,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[850] = {name = "彼岸灵花",mainId = 21000007,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=9,ibPowerCost = 30,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=15,associatedId2=21000047,aOdds3=8,associatedId3=21000048}
x890350_g_GPInfo[851] = {name = "茭白",mainId = 21000001,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=4,ibPowerCost = 20,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[852] = {name = "盈月笋",mainId = 21000002,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=7,ibPowerCost = 25,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[853] = {name = "流华松露",mainId = 21000003,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=9,ibPowerCost = 30,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=15,associatedId2=21000047,aOdds3=8,associatedId3=21000048}
x890350_g_GPInfo[854] = {name = "玄铁",mainId = 21000009,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=4,ibPowerCost = 20,isRich=0,aOdds1=25,associatedId={21000032,21000033,21000034,21000035},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[855] = {name = "锻月银",mainId = 21000010,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=7,ibPowerCost = 25,isRich=0,aOdds1=25,associatedId={21000036,21000037,21000038,21000039},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[856] = {name = "霄华鎏金",mainId = 21000011,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=9,ibPowerCost = 30,isRich=0,aOdds1=25,associatedId={21000040,21000041,21000042,21000043},aOdds2=15,associatedId2=21000047,aOdds3=8,associatedId3=21000048}
x890350_g_GPInfo[857] = {name = "霜竹",mainId = 21000017,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=4,ibPowerCost = 20,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[858] = {name = "贞云松",mainId = 21000018,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=7,ibPowerCost = 25,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[859] = {name = "怀雅檀木",mainId = 21000019,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=9,ibPowerCost = 30,isRich=0,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=15,associatedId2=21000047,aOdds3=8,associatedId3=21000048}
x890350_g_GPInfo[860] = {name = "芝兰·丰产",mainId = 21000005,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=4,ibPowerCost = 20,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[861] = {name = "血茯苓·丰产",mainId = 21000006,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=7,ibPowerCost = 25,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[862] = {name = "彼岸灵花·丰产",mainId = 21000007,IdentityId = IDENTITY_PHARMACY_IDX,abilityId = ABILITY_IDENTITY_LIANYAO,needLv=9,ibPowerCost = 30,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=15,associatedId2=21000047,aOdds3=8,associatedId3=21000048}
x890350_g_GPInfo[863] = {name = "茭白·丰产",mainId = 21000001,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=4,ibPowerCost = 20,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[864] = {name = "盈月笋·丰产",mainId = 21000002,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=7,ibPowerCost = 25,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[865] = {name = "流华松露·丰产",mainId = 21000003,IdentityId = IDENTITY_COOKING_IDX,abilityId = ABILITY_IDENTITY_ZHISHAN,needLv=9,ibPowerCost = 30,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=15,associatedId2=21000047,aOdds3=8,associatedId3=21000048}
x890350_g_GPInfo[866] = {name = "玄铁·丰产",mainId = 21000009,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=4,ibPowerCost = 20,isRich=1,aOdds1=25,associatedId={21000032,21000033,21000034,21000035},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[867] = {name = "锻月银·丰产",mainId = 21000010,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=7,ibPowerCost = 25,isRich=1,aOdds1=25,associatedId={21000036,21000037,21000038,21000039},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[868] = {name = "霄华鎏金·丰产",mainId = 21000011,IdentityId = IDENTITY_ATTACKEQUIP_IDX,abilityId = ABILITY_IDENTITY_ZHUQI,needLv=9,ibPowerCost = 30,isRich=1,aOdds1=25,associatedId={21000040,21000041,21000042,21000043},aOdds2=15,associatedId2=21000047,aOdds3=8,associatedId3=21000048}
x890350_g_GPInfo[869] = {name = "霜竹·丰产",mainId = 21000017,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=4,ibPowerCost = 20,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000045,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[870] = {name = "贞云松·丰产",mainId = 21000018,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=7,ibPowerCost = 25,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=33,associatedId2=21000046,aOdds3=-1,associatedId3=-1}
x890350_g_GPInfo[871] = {name = "怀雅檀木·丰产",mainId = 21000019,IdentityId = IDENTITY_ENGINEER_IDX,abilityId = ABILITY_IDENTITY_JIQIAO,needLv=9,ibPowerCost = 30,isRich=1,aOdds1=-1,associatedId={-1,-1,-1,-1},aOdds2=15,associatedId2=21000047,aOdds3=8,associatedId3=21000048}

x890350_g_NoLevelTips = {
	[IDENTITY_COOKING_IDX] = {
		[1] = "#{SFCJ_240110_5}",
		[4] = "#{SFCJ_240110_6}",
		[7] = "#{SFCJ_240110_7}",
		[9] = "#{SFCJ_240110_8}",
	},
	[IDENTITY_PHARMACY_IDX] = {
		[1] = "#{SFCJ_240110_9}",
		[4] = "#{SFCJ_240110_10}",
		[7] = "#{SFCJ_240110_11}",
		[9] = "#{SFCJ_240110_12}",
	},
	[IDENTITY_ATTACKEQUIP_IDX] = {
		[1] = "#{SFCJ_240110_13}",
		[4] = "#{SFCJ_240110_14}",
		[7] = "#{SFCJ_240110_15}",
		[9] = "#{SFCJ_240110_16}",
	},
	[IDENTITY_ENGINEER_IDX] = {
		[1] = "#{SFCJ_240110_17}",
		[4] = "#{SFCJ_240110_18}",
		[7] = "#{SFCJ_240110_19}",
		[9] = "#{SFCJ_240110_20}",
	},
}

-- 长生长点
function x890350_OnCreate( sceneId, growPointType, x, y )
	local GPInfo = x890350_g_GPInfo[growPointType]
	if not GPInfo then
		return
	end

	-- 每个生长点最少能得到一个物品，这里直接放入 itembox 中一个
	local itemBox = ItemBoxEnterScene( x, y, growPointType, sceneId, QUALITY_MUST_BE_CHANGE,1, GPInfo.mainId )
	print( sceneId .. " 号场景 (" .. x .. ", " .. y .. ") 处长出一个盟会采集物。("..GPInfo.mainId.." 归属盟会:"..GPInfo.IdentityId..")" )
	-- 丰产物品是双倍
	if GPInfo.isRich == 1 then
		AddItemToBox( sceneId, itemBox, QUALITY_MUST_BE_CHANGE,1, GPInfo.mainId )
	end
	
	-- 加入额外产品1-四选一
	if GPInfo.aOdds1 > 0 and random( x890350_g_RandNum ) <= GPInfo.aOdds1 then
		local nRandIndex = random(1,4)
		AddItemToBox( sceneId, itemBox, QUALITY_MUST_BE_CHANGE,1, GPInfo.associatedId[nRandIndex] )
	end
	-- 加入额外产品2
	if GPInfo.aOdds2 > 0 and random( x890350_g_RandNum ) <= GPInfo.aOdds2 and GPInfo.associatedId2 ~= -1 then
		local nRandIndex = random(1,4)
		AddItemToBox( sceneId, itemBox, QUALITY_MUST_BE_CHANGE,1, GPInfo.associatedId2 )
	end
	-- 加入额外产品3
	if GPInfo.aOdds3 > 0 and random( x890350_g_RandNum ) <= GPInfo.aOdds3 and GPInfo.associatedId3 ~= -1 then
		local nRandIndex = random(1,4)
		AddItemToBox( sceneId, itemBox, QUALITY_MUST_BE_CHANGE,1, GPInfo.associatedId3 )
	end

end

-- 点击生长点时
function x890350_OnOpen( sceneId, selfId, targetId )
	local growPointType = LuaFnGetItemBoxGrowPointType( sceneId, targetId )
	local GPInfo = x890350_g_GPInfo[growPointType]
	if not GPInfo then
		return OR_INVALID_TARGET
	end
	
	-- 检查有无江湖身份
	local nCurIdentityId = LuaFnGetIBIdentityId(sceneId,selfId)
	if nCurIdentityId == 0 then
		return OR_NO_IBIDENTITY_ID
	end
	
	if nCurIdentityId ~= GPInfo.IdentityId then
		return OR_CANT_CAIJI_IN_IDENTITY
	end
	
	-- 检查相应技能等级
	local AbilityLevel = QueryHumanAbilityLevel( sceneId, selfId, GPInfo.abilityId )
	if AbilityLevel < GPInfo.needLv then
		if x890350_g_NoLevelTips[GPInfo.IdentityId] ~= nil and x890350_g_NoLevelTips[GPInfo.IdentityId][GPInfo.needLv] ~= nil then
			x890350_NotifyTips( sceneId, selfId,x890350_g_NoLevelTips[GPInfo.IdentityId][GPInfo.needLv])
		end
		return OR_CANT_CAIJI_LOW_LEVEL
	end

	--检查神工值
	if LuaFnGetIBPower( sceneId, selfId ) < GPInfo.ibPowerCost then
		return OR_CANT_CAIJI_NO_IBPOWER
	end
	
	--当前不能是隐身状态
	if LuaFnIsConceal(sceneId,activatorId) ~= 0 then
		x890350_NotifyTips( sceneId, selfId,"#{SFCJ_240110_25}")
		return OR_ERROR
	end

	return OR_OK
end

-- 进度条走完了
function x890350_OnProcOver( sceneId, selfId, targetId )
	local growPointType = LuaFnGetItemBoxGrowPointType( sceneId, targetId )
	local GPInfo = x890350_g_GPInfo[growPointType]
	if not GPInfo then
		return OR_INVALID_TARGET
	end

	--消耗神工值
	local curIBPower = LuaFnGetIBPower( sceneId, selfId )
	curIBPower = curIBPower - GPInfo.ibPowerCost
	if curIBPower < 0 then
		curIBPower = 0
	end
	LuaFnSetIBPower( sceneId, selfId, curIBPower )
	--告知消耗量
	x890350_NotifyTips( sceneId, selfId, ScriptGlobal_Format("#{SFCJ_240110_23}",tostring(GPInfo.ibPowerCost)) )

	return OR_OK
end

-- 箱子捡完了，回收
function x890350_OnRecycle( sceneId, selfId, targetId)
	local growPointType = LuaFnGetItemBoxGrowPointType( sceneId, targetId )
	local GPInfo = x890350_g_GPInfo[growPointType]
	if not GPInfo then
		return 1
	end

	--统计数据
	LuaFnAuditAbility(sceneId, selfId, GPInfo.abilityId, -1, -1)
	-- 增加熟练度
	CallScriptFunction( ABILITYLOGIC_ID, "GainExperience", sceneId, selfId, GPInfo.abilityId, GPInfo.needLv )
	--返回1，生长点回收
	return 1
end

function x890350_NotifyTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

function x890350_OnTickCreateFinish( sceneId, growPointType, tickCount )
end
