--MisDescBegin
--脚本号
x890166_g_ScriptId = 890166

--任务号
x890166_g_MissionId = 2173

--交任务npc
x890166_g_Position_X=65--完成任务NPC属性
x890166_g_Position_Z=52
x890166_g_SceneID=1294
x890166_g_AccomplishNPC_Name="阮枫眠"

--任务NPC属性
x890166_g_AcceptNpcInfo_1	= {name="墨知愁", sceneId=1292}	--势力1
x890166_g_AcceptNpcInfo_2	= {name="江行云", sceneId=1293}	--势力2
x890166_g_AcceptNpcInfo_3	= {name="阮枫眠", sceneId=1294}	--势力3

--目标NPC
x890166_g_AcceptNpcInfo	= {
	[1] = {name="墨知愁", sceneId=1292, posx=63, posz=53,  npctext = "#{ZXJQ_221225_228}",},
	[2] = {name="江行云", sceneId=1293, posx=37, posz=119, npctext = "#{ZXJQ_221225_233}",},
	[3] = {name="阮枫眠", sceneId=1294, posx=65, posz=52,  npctext = "#{ZXJQ_221225_238}",},
}

--前置任务
x890166_g_PreMissionId = 2172
x890166_g_PreMissionName="#{ZXJQ_221225_216}" --主线任务十二：再探长春谷

--任务归类
x890166_g_MissionKind = 9

--任务等级
x890166_g_MissionLevel = 85

--是否是精英任务
x890166_g_IfMissionElite = 0

--任务名
x890166_g_MissionName="#{ZXJQ_221225_239}" --主线任务十三：发狂的野兽
x890166_g_MissionTarget="#{ZXJQ_221225_246}" --前往阮枫眠处，击杀身侧野兽。
x890166_g_IsMissionOkFail=0
x890166_g_Custom = {{id = "击杀偃甲灰熊", num = 1}} --替代
x890166_g_ContinueInfo = ""
x890166_g_MissionComplete = "#{ZXJQ_221225_251}" --你已经知道了？

x890166_g_AccomplishNpcInfo	= {name="阮枫眠", sceneId=1294}

--MisDescEnd
