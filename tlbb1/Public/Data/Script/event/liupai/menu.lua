-- 门派流派主菜单

x292000_g_ScriptId	= 292000
--目标NPC
x292000_g_NpcInfo	= {
	[MP_SHAOLIN] = {sceneId=9, name={[1]="玄阅", [2]="玄篱"}},
	[MP_MINGJIAO] = {sceneId=11, name={[1]="莫思归", [2]="林焱"}},
	[MP_GAIBANG] = {sceneId=10, name={[1]="杜少康", [2]="路老大"}},
	[MP_WUDANG] = {sceneId=12, name={[1]="碧落散人", [2]="逐浪散人"}},
	[MP_EMEI] = {sceneId=15, name={[1]="聚落花", [2]="苏戈"}},
	[MP_XINGSU] = {sceneId=16, name={[1]="蒿莱子", [2]="莲舟子"}},
	[MP_DALI] = {sceneId=13, name={[1]="本喜", [2]="本然"}},
	[MP_TIANSHAN] = {sceneId=17, name={[1]="吴森森", [2]="吴淼淼"}},
	[MP_XIAOYAO] = {sceneId=14, name={[1]="艾凉河", [2]="秦烟萝"}},
	[MP_MANTUO] = {sceneId=1283, name={[1]="嵇聆风", [2]="嵇扶光"}}, --替代2022
	[MP_ERENGU] = {sceneId=504, name={[1]="山姥", [2]="山人木"}},
}
x292000_g_NpcTips	= {
	[MP_SHAOLIN] = {tips={[1]="#{TFYD_210729_543}", [2]="#{TFYD_210729_542}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TFYD_210729_547}", [2]="#{TFYD_210729_546}"}},
	[MP_GAIBANG] = {tips={[1]="#{TFYD_210729_545}", [2]="#{TFYD_210729_544}"}},
	[MP_WUDANG] = {tips={[1]="#{TFYD_210729_548}", [2]="#{TFYD_210729_549}"}},
	[MP_EMEI] = {tips={[1]="#{TFYD_210729_555}", [2]="#{TFYD_210729_554}"}},
	[MP_XINGSU] = {tips={[1]="#{TFYD_210729_556}", [2]="#{TFYD_210729_557}"}},
	[MP_DALI] = {tips={[1]="#{TFYD_210729_550}", [2]="#{TFYD_210729_551}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TFYD_210729_558}", [2]="#{TFYD_210729_559}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TFYD_210729_552}", [2]="#{TFYD_210729_553}"}},
	[MP_MANTUO] = {tips={[1]="#{MPSD_220622_50}", [2]="#{MPSD_220622_51}"}},
	[MP_ERENGU] = {tips={[1]="#{ERMP_240620_20}", [2]="#{ERMP_240620_19}"}},
}
x292000_g_AboutLiupai	= {
	[MP_SHAOLIN] = "#{TalentSL_20210804_01}",
	[MP_MINGJIAO] = "#{TalentMJ_20210804_01}",
	[MP_GAIBANG] = "#{TalentGB_20210804_01}",
	[MP_WUDANG] = "#{TalentWD_20210804_01}",
	[MP_EMEI] = "#{TalentEM_20210804_01}",
	[MP_XINGSU] = "#{TalentXX_20210804_01}",
	[MP_DALI] = "#{TalentTL_20210804_01}",
	[MP_TIANSHAN] = "#{TalentTS_20210804_01}",
	[MP_XIAOYAO] = "#{TalentXY_20210804_01}",
	[MP_MANTUO] = "#{TalentMT_20220621_03}",
	[MP_ERENGU] = "#{TalentER_20240802_03}",
}
x292000_g_TalentTypes	= {
	[MP_SHAOLIN] = {tips={[1]="#{TalentSL_20210804_03}", [2]="#{TalentSL_20210804_05}"}},
	[MP_MINGJIAO] = {tips={[1]="#{TalentMJ_20210804_03}", [2]="#{TalentMJ_20210804_05}"}},
	[MP_GAIBANG] = {tips={[1]="#{TalentGB_20210804_03}", [2]="#{TalentGB_20210804_05}"}},
	[MP_WUDANG] = {tips={[1]="#{TalentWD_20210804_03}", [2]="#{TalentWD_20210804_05}"}},
	[MP_EMEI] = {tips={[1]="#{TalentEM_20210804_03}", [2]="#{TalentEM_20210804_05}"}},
	[MP_XINGSU] = {tips={[1]="#{TalentXX_20210804_03}", [2]="#{TalentXX_20210804_05}"}},
	[MP_DALI] = {tips={[1]="#{TalentTL_20210804_03}", [2]="#{TalentTL_20210804_05}"}},
	[MP_TIANSHAN] = {tips={[1]="#{TalentTS_20210804_03}", [2]="#{TalentTS_20210804_05}"}},
	[MP_XIAOYAO] = {tips={[1]="#{TalentXY_20210804_03}", [2]="#{TalentXY_20210804_05}"}},
	[MP_MANTUO] = {tips={[1]="#{TalentMT_20220621_01}", [2]="#{TalentMT_20220621_02}"}},
	[MP_ERENGU] = {tips={[1]="#{TalentER_20240802_01}", [2]="#{TalentER_20240802_02}"}},
}
x292000_g_TalentTitle	= {
	[MP_SHAOLIN] = {1053,1054},
	[MP_MINGJIAO] =  {1055,1056},
	[MP_GAIBANG] =  {1057,1058},
	[MP_WUDANG] =  {1059,1060},
	[MP_EMEI] =  {1061,1062},
	[MP_XINGSU] =  {1063,1064},
	[MP_DALI] =  {1065,1066},
	[MP_TIANSHAN] =  {1067,1068},
	[MP_XIAOYAO] = {1069,1070},
	[MP_MANTUO] = {1205,1206},
	[MP_ERENGU] = {1371,1370},
}
--前置任务 借香一缕悟如是
x292000_g_PreMissionId = 2024
--引导选择任务 化文入武择所向
x292000_g_SelectMissionId = 2025
--引导学习任务 详参武道得真传
x292000_g_LevelupMissionId = 2027
--当前的最大层数
x292000_g_maxlayer = 4;
--可操作最低等级
x292000_g_MinLevel = 60
--
x292000_g_Talent_Studyup_Info =
{
	[0] =
	{
		[1] = {instrct = "#{TalentSL_20210804_02}",icon="set:Talent image:Talent_SLLH",
				 [1] = {23}, [2] = {24,-1,25},[3] = {26,27,28},[4] = {29,30,-1}, [5] = {31,32,33}},
		[2] = {instrct = "#{TalentSL_20210804_04}",icon="set:Talent image:Talent_SLJG", 
					[1] = {34},[2] = {35,-1,36}, [3] = {37,38,39}, [4] = {40,-1,41},[5] = {42,43,44}},
		[3] = {instrct = "#{TalentSL_20210804_02}",icon="set:Talent image:Talent_SLLH",
				 [1] = {23}, [2] = {199,-1,200},[3] = {201,202,203},[4] = {204,-1,205}, [5] = {206,207,208}},
		[4] = {instrct = "#{TalentSL_20210804_04}",icon="set:Talent image:Talent_SLJG", 
					[1] = {34},[2] = {209,-1,210}, [3] = {211,212,213}, [4] = {214,-1,215},[5] = {216,217,218}},
		[5] = {instrct = "#{TalentSL_20210804_02}",icon="set:Talent image:Talent_SLLH",
				 [1] = {23}, [2] = {421,-1,422},[3] = {423,424,425},[4] = {426,-1,427}, [5] = {428,429,430}},
		[6] = {instrct = "#{TalentSL_20210804_04}",icon="set:Talent image:Talent_SLJG", 
					[1] = {34},[2] = {431,-1,432}, [3] = {433,434,435}, [4] = {436,-1,437},[5] = {438,439,440}},
		[7] = {instrct = "#{TalentSL_20210804_02}",icon="set:Talent image:Talent_SLLH",
				 [1] = {23}, [2] = {683,-1,684},[3] = {685,686,687},[4] = {688,-1,689}, [5] = {690,691,692}},
		[8] = {instrct = "#{TalentSL_20210804_04}",icon="set:Talent image:Talent_SLJG", 
					[1] = {34},[2] = {693,-1,694}, [3] = {695,696,697}, [4] = {698,-1,699},[5] = {700,701,702}}
	},
	[1] =
	{
		[1] = {instrct = "#{TalentMJ_20210804_02}",icon="set:Talent image:Talent_MJTL", 
				[1] = {45}, [2] = {46,-1,47},[3] = {48,49,50},[4] = {51,-1,52}, [5] = {53,54,55}},
		[2] = {instrct = "#{TalentMJ_20210804_04}",icon="set:Talent image:Talent_MJXL", 
				[1] = {56},[2] = {57,-1,58}, [3] = {59,60,61}, [4] = {62,-1,63},[5] = {64,65,66}},
		[3] = {instrct = "#{TalentMJ_20210804_02}",icon="set:Talent image:Talent_MJTL", 
				[1] = {45}, [2] = {219,-1,220},[3] = {221,222,223},[4] = {224,-1,225}, [5] = {226,227,228}},
		[4] = {instrct = "#{TalentMJ_20210804_04}",icon="set:Talent image:Talent_MJXL", 
				[1] = {56},[2] = {229,-1,230}, [3] = {231,232,233}, [4] = {234,-1,235},[5] = {236,237,238}},
		[5] = {instrct = "#{TalentMJ_20210804_02}",icon="set:Talent image:Talent_MJTL", 
				[1] = {45}, [2] = {441,-1,442},[3] = {443,444,445},[4] = {446,-1,447}, [5] = {448,449,450}},
		[6] = {instrct = "#{TalentMJ_20210804_04}",icon="set:Talent image:Talent_MJXL", 
				[1] = {56},[2] = {451,-1,452}, [3] = {453,454,455}, [4] = {456,-1,457},[5] = {458,459,460}},
		[7] = {instrct = "#{TalentMJ_20210804_02}",icon="set:Talent image:Talent_MJTL", 
				[1] = {45}, [2] = {703,-1,704},[3] = {705,706,707},[4] = {708,-1,709}, [5] = {710,711,712}},
		[8] = {instrct = "#{TalentMJ_20210804_04}",icon="set:Talent image:Talent_MJXL", 
				[1] = {56},[2] = {713,-1,714}, [3] = {715,716,717}, [4] = {718,-1,719},[5] = {720,721,722}}
	},	
	[2] =
	{
		[1] = {instrct = "#{TalentGB_20210804_02}",icon="set:Talent image:Talent_GBJK", 
				 [1] = {1}, [2] = {2,-1,3},[3] = {4,5,6},[4] = {7,8,-1}, [5] = {9,10,11}},
		[2] = {instrct = "#{TalentGB_20210804_04}",icon="set:Talent image:Talent_GBXX", 
				[1] = {12},[2] = {13,-1,14}, [3] = {15,16,17}, [4] = {18,-1,19},[5] = {20,21,22}},
		[3] = {instrct = "#{TalentGB_20210804_02}",icon="set:Talent image:Talent_GBJK", 
				 [1] = {1}, [2] = {239,-1,240},[3] = {241,242,243},[4] = {244,-1,245}, [5] = {246,247,248}},
		[4] = {instrct = "#{TalentGB_20210804_04}",icon="set:Talent image:Talent_GBXX", 
				[1] = {12},[2] = {249,-1,250}, [3] = {251,252,253}, [4] = {254,-1,255},[5] = {256,257,258}},
		[5] = {instrct = "#{TalentGB_20210804_02}",icon="set:Talent image:Talent_GBJK", 
				 [1] = {1}, [2] = {461,-1,462},[3] = {463,464,465},[4] = {466,-1,467}, [5] = {468,469,470}},
		[6] = {instrct = "#{TalentGB_20210804_04}",icon="set:Talent image:Talent_GBXX", 
				[1] = {12},[2] = {471,-1,472}, [3] = {473,474,475}, [4] = {476,-1,477},[5] = {478,479,480}},
		[7] = {instrct = "#{TalentGB_20210804_02}",icon="set:Talent image:Talent_GBJK", 
				 [1] = {1}, [2] = {723,-1,724},[3] = {725,726,727},[4] = {728,-1,729}, [5] = {730,731,732}},
		[8] = {instrct = "#{TalentGB_20210804_04}",icon="set:Talent image:Talent_GBXX", 
				[1] = {12},[2] = {733,-1,734}, [3] = {735,736,737}, [4] = {738,-1,739},[5] = {740,741,742}}
	},
	[3] =
	{
		[1] = {instrct = "#{TalentWD_20210804_02}",icon="set:Talent2 image:Talent_WDPX", 
				[1] = {67}, [2] = {68,-1,69},[3] = {70,71,72},[4] = {73,-1,74}, [5] = {75,76,77}},
		[2] = {instrct = "#{TalentWD_20210804_04}",icon="set:Talent2 image:Talent_WDZX", 
				[1] = {78},[2] = {79,-1,80}, [3] = {81,82,83}, [4] = {84,-1,85},[5] = {86,87,88}},
		[3] = {instrct = "#{TalentWD_20210804_02}",icon="set:Talent2 image:Talent_WDPX", 
				[1] = {67}, [2] = {259,-1,260},[3] = {261,262,263},[4] = {264,-1,265}, [5] = {266,267,268}},
		[4] = {instrct = "#{TalentWD_20210804_04}",icon="set:Talent2 image:Talent_WDZX", 
				[1] = {78},[2] = {269,-1,270}, [3] = {271,272,273}, [4] = {274,-1,275},[5] = {276,277,278}},
		[5] = {instrct = "#{TalentWD_20210804_02}",icon="set:Talent2 image:Talent_WDPX", 
				[1] = {67}, [2] = {481,-1,482},[3] = {483,484,485},[4] = {486,-1,487}, [5] = {488,489,490}},
		[6] = {instrct = "#{TalentWD_20210804_04}",icon="set:Talent2 image:Talent_WDZX", 
				[1] = {78},[2] = {491,-1,492}, [3] = {493,494,495}, [4] = {496,-1,497},[5] = {498,499,500}},
		[7] = {instrct = "#{TalentWD_20210804_02}",icon="set:Talent2 image:Talent_WDPX", 
				[1] = {67}, [2] = {743,-1,744},[3] = {745,746,747},[4] = {748,-1,749}, [5] = {750,751,752}},
		[8] = {instrct = "#{TalentWD_20210804_04}",icon="set:Talent2 image:Talent_WDZX", 
				[1] = {78},[2] = {753,-1,754}, [3] = {755,756,757}, [4] = {758,-1,759},[5] = {760,761,762}}
	},
	[4] =
	{
		[1] = {instrct = "#{TalentEM_20210804_02}",icon="set:Talent image:Talent_EMQF", 
					[1] = {89}, [2] = {90,-1,91},[3] = {92,93,94},[4] = {95,96,-1}, [5] = {97,98,99}},
		[2] = {instrct = "#{TalentEM_20210804_04}",icon="set:Talent image:Talent_EMQY", 
					[1] = {100},[2] = {101,-1,102}, [3] = {103,104,105}, [4] = {106,-1,107},[5] = {108,109,110}},
		[3] = {instrct = "#{TalentEM_20210804_02}",icon="set:Talent image:Talent_EMQF", 
					[1] = {89}, [2] = {279,-1,280},[3] = {281,282,283},[4] = {284,-1,285}, [5] = {286,287,288}},
		[4] = {instrct = "#{TalentEM_20210804_04}",icon="set:Talent image:Talent_EMQY", 
					[1] = {100},[2] = {289,-1,290}, [3] = {291,292,293}, [4] = {294,-1,295},[5] = {296,297,298}},
		[5] = {instrct = "#{TalentEM_20210804_02}",icon="set:Talent image:Talent_EMQF", 
					[1] = {89}, [2] = {501,-1,502},[3] = {503,504,505},[4] = {506,-1,507}, [5] = {508,509,510}},
		[6] = {instrct = "#{TalentEM_20210804_04}",icon="set:Talent image:Talent_EMQY", 
					[1] = {100},[2] = {511,-1,512}, [3] = {513,514,515}, [4] = {516,-1,517},[5] = {518,519,520}},
		[7] = {instrct = "#{TalentEM_20210804_02}",icon="set:Talent image:Talent_EMQF", 
					[1] = {89}, [2] = {763,-1,764},[3] = {765,766,767},[4] = {768,-1,769}, [5] = {770,771,772}},
		[8] = {instrct = "#{TalentEM_20210804_04}",icon="set:Talent image:Talent_EMQY", 
					[1] = {100},[2] = {773,-1,774}, [3] = {775,776,777}, [4] = {778,-1,779},[5] = {780,781,782}}
	},
	[5] =
	{
		[1] = {instrct = "#{TalentXX_20210804_02}",icon="set:Talent2 image:Talent_XXHM", 
					[1] = {111}, [2] = {112,-1,113},[3] = {114,115,116},[4] = {117,-1,118}, [5] = {119,120,121}},
		[2] = {instrct = "#{TalentXX_20210804_04}",icon="set:Talent2 image:Talent_XXJE", 
					[1] = {122},[2] = {123,-1,124}, [3] = {125,126,127}, [4] = {128,-1,129},[5] = {130,131,132}},
		[3] = {instrct = "#{TalentXX_20210804_02}",icon="set:Talent2 image:Talent_XXHM", 
					[1] = {111}, [2] = {299,-1,300},[3] = {301,302,303},[4] = {304,-1,305}, [5] = {306,307,308}},
		[4] = {instrct = "#{TalentXX_20210804_04}",icon="set:Talent2 image:Talent_XXJE", 
					[1] = {122},[2] = {309,-1,310}, [3] = {311,312,313}, [4] = {314,-1,315},[5] = {316,317,318}},
		[5] = {instrct = "#{TalentXX_20210804_02}",icon="set:Talent2 image:Talent_XXHM", 
					[1] = {111}, [2] = {521,-1,522},[3] = {523,524,525},[4] = {526,-1,527}, [5] = {528,529,530}},
		[6] = {instrct = "#{TalentXX_20210804_04}",icon="set:Talent2 image:Talent_XXJE", 
					[1] = {122},[2] = {531,-1,532}, [3] = {533,534,535}, [4] = {536,-1,537},[5] = {538,539,540}},
		[7] = {instrct = "#{TalentXX_20210804_02}",icon="set:Talent2 image:Talent_XXHM", 
					[1] = {111}, [2] = {783,-1,784},[3] = {785,786,787},[4] = {788,-1,789}, [5] = {790,791,792}},
		[8] = {instrct = "#{TalentXX_20210804_04}",icon="set:Talent2 image:Talent_XXJE", 
					[1] = {122},[2] = {793,-1,794}, [3] = {795,796,797}, [4] = {798,-1,799},[5] = {800,801,802}}
	},
	[6] =
	{
		[1] = {instrct = "#{TalentTL_20210804_02}",icon="set:Talent image:Talent_TLLW", 
					[1] = {133}, [2] = {134,-1,135},[3] = {136,137,138},[4] = {139,-1,140}, [5] = {141,142,143}},
		[2] = {instrct = "#{TalentTL_20210804_04}",icon="set:Talent image:Talent_TLPT", 
					[1] = {144},[2] = {145,-1,146}, [3] = {147,148,149}, [4] = {150,-1,151},[5] = {152,153,154}},
		[3] = {instrct = "#{TalentTL_20210804_02}",icon="set:Talent image:Talent_TLLW", 
					[1] = {133}, [2] = {319,-1,320},[3] = {321,322,323},[4] = {324,-1,325}, [5] = {326,327,328}},
		[4] = {instrct = "#{TalentTL_20210804_04}",icon="set:Talent image:Talent_TLPT", 
					[1] = {144},[2] = {329,-1,330}, [3] = {331,332,333}, [4] = {334,-1,335},[5] = {336,337,338}},
		[5] = {instrct = "#{TalentTL_20210804_02}",icon="set:Talent image:Talent_TLLW", 
					[1] = {133}, [2] = {541,-1,542},[3] = {543,544,545},[4] = {546,-1,547}, [5] = {548,549,550}},
		[6] = {instrct = "#{TalentTL_20210804_04}",icon="set:Talent image:Talent_TLPT", 
					[1] = {144},[2] = {551,-1,552}, [3] = {553,554,555}, [4] = {556,-1,557},[5] = {558,559,560}},
		[7] = {instrct = "#{TalentTL_20210804_02}",icon="set:Talent image:Talent_TLLW", 
					[1] = {133}, [2] = {803,-1,804},[3] = {805,806,807},[4] = {808,-1,809}, [5] = {810,811,812}},
		[8] = {instrct = "#{TalentTL_20210804_04}",icon="set:Talent image:Talent_TLPT", 
					[1] = {144},[2] = {813,-1,814}, [3] = {815,816,817}, [4] = {818,-1,819},[5] = {820,821,822}}
	},
	[7] =
	{
		[1] = {instrct = "#{TalentTS_20210804_02}",icon="set:Talent2 image:Talent_TSNS", 
					 [1] = {155}, [2] = {156,-1,157},[3] = {158,159,160},[4] = {161,-1,162}, [5] = {163,164,165}},
		[2] = {instrct = "#{TalentTS_20210804_04}",icon="set:Talent2 image:Talent_TSXY", 
						[1] = {166},[2] = {167,-1,168}, [3] = {169,170,171}, [4] = {172,-1,173},[5] = {174,175,176}},
		[3] = {instrct = "#{TalentTS_20210804_02}",icon="set:Talent2 image:Talent_TSNS", 
					 [1] = {155}, [2] = {339,-1,340},[3] = {341,342,343},[4] = {344,-1,345}, [5] = {346,347,348}},
		[4] = {instrct = "#{TalentTS_20210804_04}",icon="set:Talent2 image:Talent_TSXY", 
						[1] = {166},[2] = {349,-1,350}, [3] = {351,352,353}, [4] = {354,-1,355},[5] = {356,357,358}},
		[5] = {instrct = "#{TalentTS_20210804_02}",icon="set:Talent2 image:Talent_TSNS", 
					 [1] = {155}, [2] = {561,-1,562},[3] = {563,564,565},[4] = {566,-1,567}, [5] = {568,569,570}},
		[6] = {instrct = "#{TalentTS_20210804_04}",icon="set:Talent2 image:Talent_TSXY", 
						[1] = {166},[2] = {571,-1,572}, [3] = {573,574,575}, [4] = {576,-1,577},[5] = {578,579,580}},
		[7] = {instrct = "#{TalentTS_20210804_02}",icon="set:Talent2 image:Talent_TSNS", 
					 [1] = {155}, [2] = {823,-1,824},[3] = {825,826,827},[4] = {828,-1,829}, [5] = {830,831,832}},
		[8] = {instrct = "#{TalentTS_20210804_04}",icon="set:Talent2 image:Talent_TSXY", 
						[1] = {166},[2] = {833,-1,834}, [3] = {835,836,837}, [4] = {838,-1,839},[5] = {840,841,842}}
	},
	[8] =
	{
		[1] = {instrct = "#{TalentXY_20210804_02}",icon="set:Talent2 image:Talent_XYYX", 
					[1] = {177}, [2] = {178,-1,179},[3] = {180,181,182},[4] = {183,-1,184}, [5] = {185,186,187}},
		[2] = {instrct = "#{TalentXY_20210804_04}",icon="set:Talent2 image:Talent_XYMG", 
					[1] = {188},[2] = {189,-1,190}, [3] = {191,192,193}, [4] = {194,-1,195},[5] = {196,197,198}},
		[3] = {instrct = "#{TalentXY_20210804_02}",icon="set:Talent2 image:Talent_XYYX", 
					[1] = {177}, [2] = {359,-1,360},[3] = {361,362,363},[4] = {364,-1,365}, [5] = {366,367,368}},
		[4] = {instrct = "#{TalentXY_20210804_04}",icon="set:Talent2 image:Talent_XYMG", 
					[1] = {188},[2] = {369,-1,370}, [3] = {371,372,373}, [4] = {374,-1,375},[5] = {376,377,378}},
		[5] = {instrct = "#{TalentXY_20210804_02}",icon="set:Talent2 image:Talent_XYYX", 
					[1] = {177}, [2] = {581,-1,582},[3] = {583,584,585},[4] = {586,-1,587}, [5] = {588,589,590}},
		[6] = {instrct = "#{TalentXY_20210804_04}",icon="set:Talent2 image:Talent_XYMG", 
					[1] = {188},[2] = {591,-1,592}, [3] = {593,594,595}, [4] = {596,-1,597},[5] = {598,599,600}},
		[7] = {instrct = "#{TalentXY_20210804_02}",icon="set:Talent2 image:Talent_XYYX", 
					[1] = {177}, [2] = {843,-1,844},[3] = {845,846,847},[4] = {848,-1,849}, [5] = {850,851,852}},
		[8] = {instrct = "#{TalentXY_20210804_04}",icon="set:Talent2 image:Talent_XYMG", 
					[1] = {188},[2] = {853,-1,854}, [3] = {855,856,857}, [4] = {858,-1,859},[5] = {860,861,862}}
	},
	[10] =
	{
		[1] = {instrct = "#{TalentMT_20220621_04}",icon="set:Talent2 image:Talent_MTWL",
					[1] = {379}, [2] = {380,-1,381},[3] = {382,383,384},[4] = {385,-1,386}, [5] = {387,388,389}},
		[2] = {instrct = "#{TalentMT_20220621_05}",icon="set:Talent2 image:Talent_MTZM",
					[1] = {390},[2] = {391,-1,392}, [3] = {393,394,395}, [4] = {396,-1,397},[5] = {398,399,400}},
		[3] = {instrct = "#{TalentMT_20220621_04}",icon="set:Talent2 image:Talent_MTWL", 
					[1] = {379}, [2] = {401,-1,402},[3] = {403,404,405},[4] = {406,-1,407}, [5] = {408,409,410}},
		[4] = {instrct = "#{TalentMT_20220621_05}",icon="set:Talent2 image:Talent_MTZM", 
					[1] = {390},[2] = {411,-1,412}, [3] = {413,414,415}, [4] = {416,-1,417},[5] = {418,419,420}},
		[5] = {instrct = "#{TalentMT_20220621_04}",icon="set:Talent2 image:Talent_MTWL", 
					[1] = {379}, [2] = {601,-1,602},[3] = {603,604,605},[4] = {606,-1,607}, [5] = {608,609,610}},
		[6] = {instrct = "#{TalentMT_20220621_05}",icon="set:Talent2 image:Talent_MTZM", 
					[1] = {390},[2] = {611,-1,612}, [3] = {613,614,615}, [4] = {616,-1,617},[5] = {618,619,620}},
		[7] = {instrct = "#{TalentMT_20220621_04}",icon="set:Talent2 image:Talent_MTWL", 
					[1] = {379}, [2] = {863,-1,864},[3] = {865,866,867},[4] = {868,-1,869}, [5] = {870,871,872}},
		[8] = {instrct = "#{TalentMT_20220621_05}",icon="set:Talent2 image:Talent_MTZM", 
					[1] = {390},[2] = {873,-1,874}, [3] = {875,876,877}, [4] = {878,-1,879},[5] = {880,881,882}}			
					
					
					
					
	},
	[11] =
	{
		[1] = {instrct = "#{TalentER_20240802_04}",icon="set:Talent3 image:Talent_ERGSH",
					[1] = {621}, [2] = {622,-1,623},[3] = {624,625,626},[4] = {627,-1,628}, [5] = {629,630,631}},
		[2] = {instrct = "#{TalentER_20240802_05}",icon="set:Talent3 image:Talent_ERGPM",
					[1] = {632},[2] = {633,-1,634}, [3] = {635,636,637}, [4] = {638,-1,639},[5] = {640,641,642}},
		[3] = {instrct = "#{TalentER_20240802_04}",icon="set:Talent3 image:Talent_ERGSH",
					[1] = {621}, [2] = {643,-1,644},[3] = {645,646,647},[4] = {648,-1,649}, [5] = {650,651,652}},
		[4] = {instrct = "#{TalentER_20240802_05}",icon="set:Talent3 image:Talent_ERGPM",
					[1] = {632},[2] = {653,-1,654}, [3] = {655,656,657}, [4] = {658,-1,659},[5] = {660,661,662}},
		[5] = {instrct = "#{TalentER_20240802_04}",icon="set:Talent3 image:Talent_ERGSH",
					[1] = {621}, [2] = {663,-1,664},[3] = {665,666,667},[4] = {668,-1,669}, [5] = {670,671,672}},
		[6] = {instrct = "#{TalentER_20240802_05}",icon="set:Talent3 image:Talent_ERGPM",
					[1] = {632},[2] = {673,-1,674}, [3] = {675,676,677}, [4] = {678,-1,679},[5] = {680,681,682}},
		[7] = {instrct = "#{TalentER_20240802_04}",icon="set:Talent3 image:Talent_ERGSH",
					[1] = {621}, [2] = {883,-1,884},[3] = {885,886,887},[4] = {888,-1,889}, [5] = {890,891,892}},
		[8] = {instrct = "#{TalentER_20240802_05}",icon="set:Talent3 image:Talent_ERGPM",
					[1] = {632},[2] = {893,-1,894}, [3] = {895,896,897}, [4] = {898,-1,899},[5] = {900,901,902}}
	},
}
--重习武道费用
x292000_g_CostPreStudy = 100000
--武道归元令
x292000_g_SwitchItem = 38002405
--更换流派后最低要求等待时间
x292000_g_SwitchDelayTime = 72 * 60 * 60
--武道任务表
x292000_g_TianFuYinDaoMission = {
	2021,2022,2023,2024,2025,2026,2027,2079,2080,2210,2211
}
--**********************************
--程序回调
--频次检测在程序已做
--**********************************
function x292000_OnSectOper( sceneId, selfId, nOperate,nSectId)
	if nOperate ~= 0 then
		return
	end
	if GetLevel(sceneId,selfId) < x292000_g_MinLevel then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_09}" ) --等级不足60级，无法开始武道修行。
		return
	end
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if sceneId ~= x292000_g_NpcInfo[nCurMenPai].sceneId then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_10}" ) --少侠当前不在正确的场景，无法进行此操作。
		return
	end
	
	--TalentMP_20210804_12	请先完成%s0流派引导任务。
	if IsMissionHaveDone(sceneId,selfId,x292000_g_SelectMissionId) <= 0 then
    	x292000_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{TalentMP_20210804_12}","#{TFYD_210729_308}") )
		-- return
	end
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	if nSectType == -1 then
		x292000_NotifyTip( sceneId, selfId, ScriptGlobal_Format("#{TalentMP_20210804_12}","#{TFYD_210729_308}") )
		return
	end
	local nCheck,nMaxlevel,nLayer,nMenPaiId,limittype,lparam1,lparam2,szName = LuaFnEnumSectInfoBySectId(nSectId);
	if nCheck <= 0 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_28}" )
		return
	end
	local bhave,level = LuaFnHasSect(sceneId,selfId,nSectId);
	if level ~= nil and level >= nMaxlevel then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_29}" )
		return
	end
	if bhave == nil or bhave == 0 then
		level = 0;
	end
	--这里根据layer对sect的类别做一个归类
	local totallevel = LuaFnGetSectTotalLevel(sceneId,selfId)
	if nLayer >= 1 and nLayer <= 5 then
		--一重
		if totallevel >= 20 then
			x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_29} " )
			return
		end
	elseif nLayer >= 6 and nLayer <= 9 then
		--二重
		if totallevel >= 40 then
			x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_29}" )
			return
		end
	elseif nLayer >= 10 and nLayer <= 13 then
		--三重
		if totallevel >= 60 then
			x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_29}" )
			return
		end
	elseif nLayer >= 14 and nLayer <= 17 then  
		--四重
		if totallevel >= 80 then
			x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_29}" )
			return
		end
	else
		--可能是数据异常
		return
	end
	--修行互斥
	local Mutex = x292000_MutexSectID(sceneId,selfId,nSectId)
	if Mutex == 0 then
		return
	end		
	--判断前置条件
	if limittype > 0 then
		local bhave2,level2 = LuaFnHasSect(sceneId,selfId,limittype);
		if bhave2 == nil or level2 == nil or level2 < lparam1 then
			local _,_,_,_,_,_,_,szLimitName = LuaFnEnumSectInfoBySectId(limittype);
			x292000_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{TalentMP_20210804_23}",szLimitName,tostring(lparam1)))
			return
		end
	end
	if lparam2 > 0 then
		if lparam2 > totallevel then
			x292000_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{TalentMP_20210804_24}",x292000_g_TalentTypes[nCurMenPai].tips[nSectType + 1],tostring(lparam2)))
			return
		end
	end
	local nLevelPoint = {0,0,0,0,0}
	nLevelPoint[1],nLevelPoint[2],nLevelPoint[3],nLevelPoint[4],nLevelPoint[5] = LuaFnEnumSectLevelInfoBySectId(nSectId)
	--需要的武道点检查
	local nPoint = LuaFnGetSectPoint(sceneId,selfId)
	if nPoint < nLevelPoint[level + 1] then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_31}" )
		return
	end
	--扣除武道点
	LuaFnSetSectPoint(sceneId,selfId,nPoint - nLevelPoint[level + 1])
	local nUsedPoint = GetMissionDataEx(sceneId,selfId,MDEX_SECT_LEARNED_POINT);
	nUsedPoint = nUsedPoint + nLevelPoint[level + 1]
	SetMissionDataEx(sceneId,selfId,MDEX_SECT_LEARNED_POINT,nUsedPoint);
	--升级武道
	LuaFnSectLevelUp(sceneId,selfId,nSectId)
	--任务提示
	if IsHaveMission(sceneId,selfId,x292000_g_LevelupMissionId) > 0 then
		--设置两个标记用以任务跟踪显示
		local nMisIndex = GetMissionIndexByID( sceneId, selfId, x292000_g_LevelupMissionId )	
		if GetMissionParam(sceneId,selfId,nMisIndex,1) == 0 then
			SetMissionByIndex( sceneId, selfId, nMisIndex, 0,1 )
			SetMissionByIndex( sceneId, selfId, nMisIndex, 1,1 )
			x292000_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{TFYD_210729_520}","#{TFYD_210729_454}") )
		end
	end
	--特效
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
	--武道引导任务状态更新
	CallScriptFunction(893242,"UpdateMissionState",sceneId,selfId)
	
	x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_30}" )
end
--**********************************
--武道ID互斥
--**********************************
function x292000_MutexSectID(sceneId,selfId,nSectId)
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	if nSectType == -1 then
		return 0
	end
	--根据点数算出来该展示哪一页了
	local totallevel = LuaFnGetSectTotalLevel(sceneId,selfId)
	local showlayer = floor(totallevel/20);
	if showlayer >= x292000_g_maxlayer then
		showlayer = x292000_g_maxlayer -1	--防止第二层点满了的情况
	end
	local nMenPai = GetMenPai(sceneId,selfId)
	local tList = x292000_g_Talent_Studyup_Info[nMenPai][nSectType + 1 + showlayer * 2]
	if tList == nil then
		return 1
	end
	local nInfoTable = {}
	local nIndex = 0
	--遍历第2层到第5层
	for i = 2,5 do
		for j = 1,getn(tList[i]) do
			if tList[i][j] > 0 then
				if tList[i][j] == nSectId then
					nIndex = i
					break
				end
			end
		end
	end
	for i,v in tList[nIndex] do
		if v > 0 and v ~= nSectId then
			local bhave,level = LuaFnHasSect(sceneId,selfId,v);
			if bhave ~= nil and bhave > 0 then
				local _,_,_,_,_,_,_,szName = LuaFnEnumSectInfoBySectId(v);
				
				x292000_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{TalentMP_20210804_22}",szName) )
				return 0
			end
		end
	end
	return 1
end
--**********************************
--更换流派
--**********************************
function x292000_SwitchTalent( sceneId, selfId, targetId,nTalentType)
	if GetLevel(sceneId,selfId) < x292000_g_MinLevel then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_44}" )
		return
	end
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	if nSectType == -1 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_45}" )
		return
	end
	--是否有武道任务
	for i = 1,getn(x292000_g_TianFuYinDaoMission) do
		if IsHaveMission(sceneId,selfId,x292000_g_TianFuYinDaoMission[i]) > 0 then
			x292000_NotifyTip( sceneId, selfId, "#{TalentMP_20210804_64}" ) --您正在进行武道流派修炼任务，无法改换，请放弃或完成该任务后重新尝试。
			return
		end
	end
	--是否未到更换时间
	local nCurTime = LuaFnGetCurrentTime()
	local nSelfTime = GetMissionDataEx(sceneId,selfId,MDEX_LAST_SWITCH_TALENT)
	--暂时屏蔽切换等待时间
--	if nSelfTime > nCurTime then
--		local nTime = nSelfTime - nCurTime
--		local nLeftHour = 0;
--		local nLeftMint = 0
--		if nTime > 60 * 60 then
--			nLeftHour = floor(nTime / (60 * 60))
--			nLeftMint = floor((nTime - (nLeftHour * 60 * 60)) / 60)
--		else
--			nLeftMint = floor(nTime / 60)
--		end
--		x292000_NotifyTip( sceneId, selfId,ScriptGlobal_Format("#{TalentMP_20210804_39}",tostring(nLeftHour),tostring(nLeftMint)) )
--		return
--	end
	--检查有无流派任务
	if CallScriptFunction(891272, "CheckAccept",sceneId, selfId) ~= 1 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_64}" ) --您正在进行武道流派修炼任务，无法改换，请放弃或完成该任务后重新尝试。
		return
	end
	
	local nCurMenPai = GetMenPai(sceneId,selfId)
	local nTalentType = -1
	local nNpcMenPai = -1
	for key, value in x292000_g_NpcInfo do
		for i = 1, getn(value.name) do
			if value.name[i] == GetName(sceneId,targetId) then
				nTalentType = i
				nNpcMenPai = key
				break
			end
		end
	end
	if nSectType == nTalentType - 1 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_46}" )
		return
	end
	if LuaFnGetAvailableItemCount(sceneId,selfId,x292000_g_SwitchItem) < 1 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_47}" )
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_40}" )
		return
	end
	--删除道具
	LuaFnDelAvailableItem(sceneId,selfId,x292000_g_SwitchItem,1)
	--返武道点
	local nUsedPoint = GetMissionDataEx(sceneId,selfId,MDEX_SECT_LEARNED_POINT);
	local nPoint = LuaFnGetSectPoint(sceneId,selfId)
	LuaFnSetSectPoint(sceneId,selfId,nPoint + nUsedPoint)
	SetMissionDataEx(sceneId,selfId,MDEX_SECT_LEARNED_POINT,0);
	--设置冷却时间
	SetMissionDataEx(sceneId,selfId,MDEX_LAST_SWITCH_TALENT,nCurTime + x292000_g_SwitchDelayTime)
	--更换流派称号
	LuaFnDeleteTitleByID(sceneId,selfId,x292000_g_TalentTitle[nCurMenPai][nSectType + 1])
	
	if LuaFnCanAddTitle(sceneId,selfId,x292000_g_TalentTitle[nCurMenPai][nSectType + 1]) ~= 0 then
		LuaFnAwardCharTitle( sceneId, selfId, x292000_g_TalentTitle[nCurMenPai][nTalentType])
		LuaFnSetCurTitleById( sceneId, selfId, x292000_g_TalentTitle[nCurMenPai][nTalentType])
		LuaFnDispatchAllTitle(sceneId, selfId)
	end
	--加入新的流派
	LuaFnJoinSect(sceneId,selfId,nTalentType - 1)
	--打开升级界面
	LuaFnOpenSectLevelUp(sceneId,selfId,targetId)
	--特效
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
	
	x292000_NotifyTip( sceneId, selfId,  ScriptGlobal_Format("#{TalentMP_20210804_48}",x292000_g_TalentTypes[nCurMenPai].tips[nTalentType]))
end
--**********************************
--选择流派
--**********************************
function x292000_SelectTalent( sceneId, selfId, targetId,nTalentType,bOk)
	if GetLevel(sceneId,selfId) < x292000_g_MinLevel then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_36}" )
		return
	end
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if sceneId ~= x292000_g_NpcInfo[nCurMenPai].sceneId then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_10}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_11}" )
		return
	end
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	if nSectType ~= -1 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_32}" )
		return
	end
	if bOk ~= 1 then
		BeginEvent(sceneId)
			AddText(sceneId,ScriptGlobal_Format("#{TalentMP_20210804_33}",x292000_g_TalentTypes[nCurMenPai].tips[nTalentType]))
			AddNumText(sceneId, x292000_g_ScriptId,"#{TalentMP_20210804_34}",6,3);
			AddNumText(sceneId, x292000_g_ScriptId,"#{TalentMP_20210804_35}",6,205);
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		--TalentMP_20210804_37	成功选择%s0流派，激活武道系统。
		x292000_NotifyTip( sceneId, selfId,  ScriptGlobal_Format("#{TalentMP_20210804_37}",x292000_g_TalentTypes[nCurMenPai].tips[nTalentType]))
		--任务提示
		if IsHaveMission(sceneId,selfId,x292000_g_SelectMissionId) > 0 then
			x292000_NotifyTip( sceneId, selfId,  "#{TFYD_210729_250}" )
			--设置两个标记用以任务跟踪显示
			local nMisIndex = GetMissionIndexByID( sceneId, selfId, x292000_g_SelectMissionId )	
			SetMissionByIndex( sceneId, selfId, nMisIndex, 0,1 )
			SetMissionByIndex( sceneId, selfId, nMisIndex, 1,1 )
		end
		--相关称号
		if LuaFnCanAddTitle(sceneId,selfId,x292000_g_TalentTitle[nCurMenPai][nTalentType]) ~= 0 then
			LuaFnAwardCharTitle( sceneId, selfId, x292000_g_TalentTitle[nCurMenPai][nTalentType])
			LuaFnSetCurTitleById( sceneId, selfId, x292000_g_TalentTitle[nCurMenPai][nTalentType])
			LuaFnDispatchAllTitle(sceneId, selfId)
		end
		--加入新的流派
		LuaFnJoinSect(sceneId,selfId,nTalentType - 1)
		--打开升级界面
		LuaFnOpenSectLevelUp(sceneId,selfId,targetId)
		--特效
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
	end
end
--**********************************
--武道修行入口
--**********************************
function x292000_LearnTalent( sceneId, selfId, targetId,nTalentType)
	if GetLevel(sceneId,selfId) < x292000_g_MinLevel then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_09}" )
		return
	end
	local nCurMenPai = GetMenPai(sceneId,selfId)
	if sceneId ~= x292000_g_NpcInfo[nCurMenPai].sceneId then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_10}" )
		return
	end
	if IsInDist(sceneId,selfId,targetId,6) ~= 1 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_11}" )
		return
	end
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	if nSectType ~= nTalentType - 1 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_58}" )
		return
	end
	
	LuaFnOpenSectLevelUp(sceneId,selfId,targetId)
end
--**********************************
--任务入口函数
--**********************************
function x292000_OnDefaultEvent( sceneId, selfId, targetId,numText,scriptId)
	--下面的内容要在前置任务“借香一缕悟如是”完成后再显示
	if (IsMissionHaveDone(sceneId,selfId,x292000_g_PreMissionId) <= 0 ) then
		-- return
	end
	local nTalentType = -1
	local nCurMenPai = GetMenPai(sceneId,selfId)
	for i = 1,2 do
		if GetName(sceneId,targetId) == x292000_g_NpcInfo[nCurMenPai].name[i] then
			nTalentType = i
		end
	end
	if nTalentType == -1 then
		return
	end
	--选择流派
	if numText == 1 then
		x292000_SelectTalent( sceneId, selfId, targetId,nTalentType,0)
		return
	end
	--武道修行
	if numText == 2 then
		x292000_LearnTalent( sceneId, selfId, targetId,nTalentType)
		return
	end
	if numText == 100 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, nCurMenPai);
			UICommand_AddInt(sceneId, nTalentType);
			UICommand_AddInt(sceneId, targetId);
			EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 20210801)
		return
	end
	--选择流派[提交]
	if numText == 3 then
		x292000_SelectTalent( sceneId, selfId, targetId,nTalentType,1)
		return
	end
	--改换流派
	if numText == 4 then
		BeginEvent(sceneId)
			AddText(sceneId,ScriptGlobal_Format("#{TalentMP_20210804_41}",x292000_g_TalentTypes[nCurMenPai].tips[nTalentType]))
			AddNumText(sceneId, x292000_g_ScriptId,"#{TalentMP_20210804_42}",6,5);
			AddNumText(sceneId, x292000_g_ScriptId,"#{TalentMP_20210804_43}",6,205);
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	--改换流派[提交]
	if numText == 5 then
		x292000_SwitchTalent( sceneId, selfId, targetId,nTalentType)
		return
	end
	--武道重习
	if numText == 6 then
		x292000_PreReStudy( sceneId, selfId,  targetId )
		return
	end
	--武道重习[提交]
	if numText == 7 then
		x292000_PreReStudySubmit( sceneId, selfId,  targetId )
		return
	end
	--关于武道
	if numText == 200 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{TalentMP_20210804_08}")
			AddNumText(sceneId, x292000_g_ScriptId,"#{TalentMP_20210804_06}",11,201);
			AddNumText(sceneId, x292000_g_ScriptId,ScriptGlobal_Format("#{TalentMP_20210804_07}",format("#{_MENPAI%d}",nCurMenPai)),11,202);
			AddNumText(sceneId, x292000_g_ScriptId,"#{XLRW_210725_26}",11,204);
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	if numText == 201 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{TalentMP_20210804_65}")	
			AddNumText(sceneId,x292000_g_ScriptId,"#{TalentMP_20210804_71}",8,203)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if numText == 202 then
		BeginEvent(sceneId)
			AddText(sceneId,x292000_g_AboutLiupai[nCurMenPai])
			AddNumText(sceneId,x292000_g_ScriptId,"#{TalentMP_20210804_71}",8,203)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if numText == 203 then
		x292000_OnDefaultEvent( sceneId, selfId, targetId,200)
		return
	end
	if numText == 204 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{XLRW_210725_27}")		
			AddNumText(sceneId,x292000_g_ScriptId,"#{TalentMP_20210804_71}",8,203)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if numText == 205 then
		CallScriptFunction(scriptId, "OnDefaultEvent",sceneId, selfId,targetId)
		return
	end
end

--**********************************
--列举事件
--**********************************
function x292000_OnEnumerate( sceneId, selfId, targetId )

	local nTalentType = -1
	local nNpcMenPai = -1
	for key, value in x292000_g_NpcInfo do
		for i = 1, getn(value.name) do
			if value.name[i] == GetName(sceneId,targetId) then
				nTalentType = i
				nNpcMenPai = key
				break
			end
		end
	end
	if nTalentType == -1 or nNpcMenPai == - 1 then
		return
	end
		
	AddText(sceneId,x292000_g_NpcTips[nNpcMenPai].tips[nTalentType])
	--下面的内容要在前置任务“借香一缕悟如是”完成后再显示
	if (IsMissionHaveDone(sceneId,selfId,x292000_g_PreMissionId) <= 0 ) then
		-- return
	end

	local nCurMenPai = GetMenPai(sceneId,selfId)
	if nNpcMenPai ~= nCurMenPai then
		return
	end
	
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	--选择流派
	if nSectType == -1 then
		AddNumText(sceneId,x292000_g_ScriptId,ScriptGlobal_Format("#{TalentMP_20210804_01}",x292000_g_TalentTypes[nCurMenPai].tips[nTalentType]),6,1);
	end
	--武道修行
	AddNumText(sceneId,x292000_g_ScriptId,"#{TalentMP_20210804_02}",6,2);
	--武道重习
	AddNumText(sceneId,x292000_g_ScriptId,"#{TalentMP_20210804_04}",6,6);
	--更改流派
	if nSectType ~= -1 and nSectType ~= nTalentType - 1 then
		AddNumText(sceneId,x292000_g_ScriptId,ScriptGlobal_Format("#{TalentMP_20210804_03}",x292000_g_TalentTypes[nCurMenPai].tips[nTalentType]),6,4);
	end
	--流派浏览
	AddNumText(sceneId,x292000_g_ScriptId,"#{TalentMP_20210804_05}",6,100);
	--关于武道
	AddNumText(sceneId,x292000_g_ScriptId,"#{TalentMP_20210804_06}",11,200);
end
--**********************************
--接取任务
--**********************************
function x292000_OnAccept(sceneId,selfId,targetId)
	
end

--**********************************
--放弃
--**********************************
function x292000_OnAbandon( sceneId, selfId )

end

--**********************************
--提交
--**********************************
function x292000_OnSubmit( sceneId, selfId, targetId, selectRadioId )

end

--**********************************
--杀死怪物或玩家
--**********************************
function x292000_OnKillObject( sceneId, selfId, objdataId, objId )

end

--**********************************
--进入区域事件
--**********************************
function x292000_OnEnterZone( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x292000_OnItemChanged( sceneId, selfId, itemdataId )

end
--**********************************
--门派变更
--**********************************
function x292000_ChangeMenPai( sceneId, selfId,nCurMenPai,nNewMenPai )
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	if nSectType < 0 then
		return
	end
	--更换流派称号
	LuaFnDeleteTitleByID(sceneId,selfId,x292000_g_TalentTitle[nCurMenPai][nSectType + 1])
	if LuaFnCanAddTitle(sceneId,selfId,x292000_g_TalentTitle[nNewMenPai][nSectType + 1]) ~= 0 then
		LuaFnAwardCharTitle( sceneId, selfId, x292000_g_TalentTitle[nNewMenPai][nSectType + 1])
		LuaFnSetCurTitleById( sceneId, selfId, x292000_g_TalentTitle[nNewMenPai][nSectType + 1])
		LuaFnDispatchAllTitle(sceneId, selfId)
	end
	--武道重置
	x292000_ReStudyHandle( sceneId, selfId ,1)
end
--**********************************
--武道重置
--**********************************
function x292000_ReStudyHandle( sceneId, selfId , ChangeMenPai)
	local totallevel = LuaFnGetSectTotalLevel(sceneId,selfId)
	if totallevel <= 0 and ChangeMenPai == nil then
		return
	end
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	if nSectType < 0 then
		return
	end
	--返武道点
	local nUsedPoint = GetMissionDataEx(sceneId,selfId,MDEX_SECT_LEARNED_POINT);
	local nPoint = LuaFnGetSectPoint(sceneId,selfId)
	LuaFnSetSectPoint(sceneId,selfId,nPoint + nUsedPoint)
	SetMissionDataEx(sceneId,selfId,MDEX_SECT_LEARNED_POINT,0);
	--重置武道等级
	LuaFnResetSectLevel(sceneId,selfId)
	return nUsedPoint
end
--**********************************
--重习武道[提交]
--**********************************
function x292000_PreReStudySubmit( sceneId, selfId,  targetId )
	if GetLevel(sceneId,selfId) < x292000_g_MinLevel then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_49}" )
		return
	end
	local totallevel = LuaFnGetSectTotalLevel(sceneId,selfId)
	if totallevel <= 0 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_50}" )
		return
	end
	--消耗检测
	if GetMoney(sceneId,selfId)+GetMoneyJZ(sceneId, selfId) < x292000_g_CostPreStudy  then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_51}" )
		return
	end
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	
	local nTalentType = -1
	local nNpcMenPai = -1
	for key, value in x292000_g_NpcInfo do
		for i = 1, getn(value.name) do
			if value.name[i] == GetName(sceneId,targetId) then
				nTalentType = i
				nNpcMenPai = key
				break
			end
		end
	end
	if nSectType ~= nTalentType - 1 or nNpcMenPai == - 1 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_59}" )
		return
	end
	--扣钱
	LuaFnCostMoneyWithPriority(sceneId, selfId, x292000_g_CostPreStudy);
	--武道重置
	local nPointReturn = x292000_ReStudyHandle( sceneId, selfId )
	--TalentMP_20210804_55	成功返还%s0点武道领悟点数，请重新分配。	
	x292000_NotifyTip( sceneId, selfId,  ScriptGlobal_Format("#{TalentMP_20210804_55}",tostring(nPointReturn)) )
	--特效
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,0)
end

--**********************************
--重习武道
--**********************************
function x292000_PreReStudy( sceneId, selfId,  targetId )
	if GetLevel(sceneId,selfId) < x292000_g_MinLevel then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_49}" )
		return
	end
	local totallevel = LuaFnGetSectTotalLevel(sceneId,selfId)
	if totallevel <= 1 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_50}" )
		return
	end
	--消耗检测
	if GetMoney(sceneId,selfId)+GetMoneyJZ(sceneId, selfId) < x292000_g_CostPreStudy  then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_51}" )
		return
	end
	local nSectType = LuaFnGetSectType(sceneId,selfId)
	local nCurMenPai = GetMenPai(sceneId,selfId)
	
	local nTalentType = -1
	local nNpcMenPai = -1
	for key, value in x292000_g_NpcInfo do
		for i = 1, getn(value.name) do
			if value.name[i] == GetName(sceneId,targetId) then
				nTalentType = i
				nNpcMenPai = key
				break
			end
		end
	end
	if nSectType ~= nTalentType - 1 or nNpcMenPai == - 1 then
		x292000_NotifyTip( sceneId, selfId,  "#{TalentMP_20210804_59}" )
		return
	end
	--计算总共学习的点数
	local nUsedPoint = GetMissionDataEx(sceneId,selfId,MDEX_SECT_LEARNED_POINT);
	BeginEvent(sceneId)
		AddText(sceneId,ScriptGlobal_Format("#{TalentMP_20210804_52}",x292000_g_TalentTypes[nCurMenPai].tips[nSectType + 1],tostring(nUsedPoint)))
		AddNumText(sceneId, x292000_g_ScriptId,"#{TalentMP_20210804_42}",6,7);
		AddNumText(sceneId, x292000_g_ScriptId,"#{TalentMP_20210804_43}",6,205);
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	return
end

--**********************************
--显示其他预览
--**********************************
function x292000_ShowPreview( sceneId, selfId,  targetId,sectType )
	--		local menpai = Get_XParam_INT(0);
	--		local secttype = Get_XParam_INT(1);
	--		local targetobjId = Get_XParam_INT(2);
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId, GetMenPai(sceneId,selfId));
		UICommand_AddInt(sceneId, sectType);
		UICommand_AddInt(sceneId, targetId);
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 20210801)
end

--**********************************
--信息提示
--**********************************
function x292000_NotifyTip( sceneId, selfId,  msg )
	BeginEvent(sceneId)
		AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
