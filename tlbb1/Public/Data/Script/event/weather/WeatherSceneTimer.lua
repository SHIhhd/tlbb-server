
--不老长春谷-场景播放烟花逻辑·程序相关
--脚本号
x998258_g_ScriptId	= 998258									
--**********************************
--脚本入口函数
--**********************************
function x998258_OnSceneTimer(sceneId)
	local randweather = random(10000);
	--设置天气变化
	if randweather < 5000 then
		LuaFnSetSceneWeather(sceneId, 4, 30 * 60 * 1000 );
	end
end



