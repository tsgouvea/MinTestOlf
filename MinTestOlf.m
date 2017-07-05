function MinTestOlf
% Reproduction on Bpod of protocol used in the PatonLab, MATCHINGvFix

global BpodSystem
%% Task parameters
TaskParameters = BpodSystem.ProtocolSettings;
if isempty(fieldnames(TaskParameters))
    TaskParameters.GUI.OdorA_bank = 1;
    TaskParameters.GUI.OdorB_bank = 2;
    TaskParameters.GUI.Valve = 1;
    TaskParameters.GUI.odorDur = 2.5; % (s)
end
BpodParameterGUI('init', TaskParameters);
BpodSystem.SoftCodeHandlerFunction = 'SoftCodeHandler';

%% Main loop
RunSession = true;
iTrial = 1;

while RunSession
    TaskParameters = BpodParameterGUI('sync', TaskParameters);
    InitiateOlfactometer(iTrial);
    sma = stateMatrix(TaskParameters);
    SendStateMatrix(sma);
    RawEvents = RunStateMatrix;
    if ~isempty(fieldnames(RawEvents))
        BpodSystem.Data = AddTrialEvents(BpodSystem.Data,RawEvents);
        SaveBpodSessionData;
    end
    HandlePauseCondition; % Checks to see if the protocol is paused. If so, waits until user resumes.
    if BpodSystem.BeingUsed == 0
        return
    end
    iTrial = iTrial + 1;
end
end