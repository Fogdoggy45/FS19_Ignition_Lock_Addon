ignitionLockSupport = {}

addModEventListener(ignitionLockSupport);

function ignitionLockSupport:loadMap(name)
    Enterable.onRegisterActionEvents = Utils.appendedFunction(Enterable.onRegisterActionEvents, ignitionLockSupport.registerActionEvents);
end

function ignitionLockSupport:registerActionEvents(isActiveForInput, isActiveForInputIgnoreSelection)
    if self.isClient then
        local spec = self.spec_motorized

        if isActiveForInputIgnoreSelection then
            local triggerKeyUp, triggerKeyDown, triggerAlways, isActive = false, true, false, true;
			InputBinding.registerActionEvent(g_inputBinding, InputAction["ilsMotorStart"], self, ignitionLockSupport.actionCallback, triggerKeyUp, triggerKeyDown, triggerAlways, isActive);
			InputBinding.registerActionEvent(g_inputBinding, InputAction["ilsMotorStop"], self, ignitionLockSupport.actionCallback, triggerKeyUp, triggerKeyDown, triggerAlways, isActive);
		end
    end
end

function ignitionLockSupport:actionCallback(actionName, keyStatus, callbackState, isAnalog, isMouse, deviceCategory)
    if not self:getIsAIActive() then
        local spec = self.spec_motorized
        if actionName == "ilsMotorStart" then
            if self:getCanMotorRun() then
                print("[IgnitionLockSupport] startMotor")
                self:startMotor()
            end
        elseif actionName == "ilsMotorStop" and spec.isMotorStarted then
            print("[IgnitionLockSupport] stopMotor")
            self:stopMotor()
        end
    end
end