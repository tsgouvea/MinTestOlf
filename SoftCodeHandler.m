function SoftCodeHandler(softCode)
%soft codes 1-10 reserved for odor delivery
%soft code 11-20 reserved for PulsePal sound delivery

global BpodSystem
global TaskParameters

if BpodSystem.Data.Custom.OlfactometerStartup %if there has been a non-auditory trial and thus olfactometer initialized
    
    firstbank = ['Bank' num2str(TaskParameters.GUI.OdorA_bank)];
    secbank = ['Bank' num2str(TaskParameters.GUI.OdorB_bank)];
    
    if softCode == 0
        if ~BpodSystem.EmulatorMode
            CommandValve = Valves2EthernetString(firstbank, TaskParameters.GUI.Valve, secbank, TaskParameters.GUI.Valve); % softCode := desired valve number
            TCPWrite(BpodSystem.Data.Custom.OlfIp, 3336, CommandValve);
        end
    elseif softCode > 0
        nextTrial = numel(BpodSystem.Data.Custom.TrialNumber) + 2;
        OdorA_flow = softCode;
        OdorB_flow = 100 - OdorA_flow;
        if ~BpodSystem.EmulatorMode
            SetBankFlowRate(BpodSystem.Data.Custom.OlfIp, TaskParameters.GUI.OdorA_bank, OdorA_flow)
            SetBankFlowRate(BpodSystem.Data.Custom.OlfIp, TaskParameters.GUI.OdorB_bank, OdorB_flow)
        end
    end
    
end %if olfactometer initialized

end

