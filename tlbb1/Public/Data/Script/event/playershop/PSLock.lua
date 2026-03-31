-- 商店锁定状态

-- 脚本号
x701800_g_ScriptId = 701800

-- 锁定状态
x701800_g_STATUS_LOCKED = 0;
x701800_g_STATUS_UNLOCKED = 1;
x701800_g_STATUS_UNLOCKING = 2;

--标志当前是珍兽界面还是物品界面
x701800_g_STALL_ITEM = 0;
x701800_g_STALL_PET  = 1;

--**********************************
-- 设置商店锁定状态
--**********************************
function x701800_SetLock(sceneId, selfId, nStallObj, bLock)
	if nStallObj ~= x701800_g_STALL_ITEM and nStallObj ~= x701800_g_STALL_PET then
		return
	end
	--要锁定店铺
	if bLock == 1 then
		local nCurSataus = GetPlayerShopLockStatus(sceneId,selfId,nStallObj)
		if nCurSataus ~= x701800_g_STATUS_UNLOCKED and nCurSataus ~= x701800_g_STATUS_UNLOCKING then
			return
		end
		--店铺进入锁定状态
		SetPlayerShopLockStatus(sceneId,selfId,nStallObj,x701800_g_STATUS_LOCKED)
		--盘出限制已经激活
		x701800_ShowTips(sceneId, selfId, "#{SDS_90511_12}")
	else
		local nCurSataus = GetPlayerShopLockStatus(sceneId,selfId,nStallObj)
		if nCurSataus ~= x701800_g_STATUS_LOCKED then
			return
		end
		--进入正在解锁状态
		SetPlayerShopLockStatus(sceneId,selfId,nStallObj,x701800_g_STATUS_UNLOCKING)
		--剩余工作交给程序执行
	end
	local nCurSataus = GetPlayerShopLockStatus(sceneId,selfId,nStallObj)
	local nUnLockTime = GetPlayerShopUnLockTime(sceneId,selfId,nStallObj)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,nCurSataus)
		UICommand_AddInt(sceneId,nUnLockTime)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 701800)	
end

--**********************************
-- 提示信息
--**********************************
function x701800_ShowTips(sceneId, selfId, tipMsg)
	BeginEvent(sceneId);
		AddText(sceneId, tipMsg);
	EndEvent(sceneId);
	DispatchMissionTips(sceneId, selfId);
end
