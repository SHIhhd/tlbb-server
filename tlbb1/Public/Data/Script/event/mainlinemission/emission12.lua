--MisDescBegin
--脚本号
x890165_g_ScriptId = 890165

--任务号
x890165_g_MissionId = 2172

--任务NPC属性
x890165_g_AcceptNpcInfo_1	= {name="墨知愁", sceneId=1292}	--势力1
x890165_g_AcceptNpcInfo_2	= {name="江行云", sceneId=1293}	--势力2
x890165_g_AcceptNpcInfo_3	= {name="阮枫眠", sceneId=1294}	--势力3

--目标NPC
x890165_g_AcceptNpcInfo	= {
	[1] = {name="墨知愁", sceneId=1292, posx=63, posz=53,  npctext = "#{ZXJQ_221225_207}", AccEpttext = "#{ZXJQ_221225_220}"},
	[2] = {name="江行云", sceneId=1293, posx=37, posz=119, npctext = "#{ZXJQ_221225_409}", AccEpttext = "#{ZXJQ_221225_472}"},
	[3] = {name="阮枫眠", sceneId=1294, posx=65, posz=52,  npctext = "#{ZXJQ_221225_410}", AccEpttext = "#{ZXJQ_221225_473}"},
}

--前置任务
x890165_g_PreMissionId = 2171
x890165_g_PreMissionName="#{ZXJQ_221225_190}" --主线任务十一：周常引导

--任务归类
x890165_g_MissionKind = 9

--任务等级
x890165_g_MissionLevel = 85

--是否是精英任务
x890165_g_IfMissionElite = 0

--任务名
x890165_g_MissionName="#{ZXJQ_221225_216}" --主线任务十二：再探长春谷
x890165_g_MissionTarget="#{ZXJQ_221225_222}" --前往长春谷二层，击杀XX怪，收集10个偃甲碎片。
x890165_g_IsMissionOkFail=0
x890165_g_Custom = {{id = "击杀灵猊，并获得灵猊转轴", num = 2}} --替代
x890165_g_ContinueInfo = ""
x890165_g_MissionComplete = "#{ZXJQ_221225_227}" --少侠，我看你这次好像收获不少。


--MisDescEnd
