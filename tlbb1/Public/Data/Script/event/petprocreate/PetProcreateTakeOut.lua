--珍兽繁殖(取珍兽)
--脚本号 （改成正确脚本号）

x800102_g_scriptId = 800102

function x800102_OnDefaultEvent( sceneId, selfId, targetId )
	--请求当前繁殖的类型
	LuaFnAskCurPetProcreateType( sceneId, selfId )
end

function x800102_OnEnumerate( sceneId, selfId, targetId )

	--（1）繁殖进程中，显示繁殖进度
	--		你的珍兽AAA与BBB的珍兽CCC正在快乐的嬉戏，再过D分钟，就能带着二代珍兽回到你身边。
	--（2）繁殖成功后，领取子珍兽
	AddNumText( sceneId, x800102_g_scriptId, "取出完成繁殖的珍兽", 6, x800102_g_scriptId )

end

--返回当前繁殖的类型
function x800102_OnRetPetProcreateType( sceneId, selfId, nType )
	--nType-> 0:没有正在繁殖的宝宝 1:组队 2:单人
	--并没有宝宝繁殖
	if nType == 0 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{DRFZZC_091013_28}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		return
	end
	if nType == 1 then
		local checkRet	= LuaFnCheckPetProcreateTakeOut( sceneId, selfId )
		if checkRet == 1 then
			LuaFnPetProcreateTakeOut( sceneId, selfId )
		end
	elseif nType == 2 then
		LuaFnPetProcreateSingleTakeOut( sceneId, selfId )
	end
end

