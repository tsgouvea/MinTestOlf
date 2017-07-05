function sma = stateMatrix(TaskParameters)

sma = NewStateMatrix();
sma = AddState(sma, 'Name', 'state_0',...
    'Timer', 0,...
    'StateChangeConditions', {'Tup', 'setValve'},...
    'OutputActions', {});
sma = AddState(sma, 'Name', 'setValve',...
    'Timer', 0,...
    'StateChangeConditions', {'Tup', 'flow20'},...
    'OutputActions', {'SoftCode',0});

sma = AddState(sma, 'Name', 'flow20',...
    'Timer', TaskParameters.GUI.odorDur,...
    'StateChangeConditions', {'Tup', 'flow40'},...
    'OutputActions', {'SoftCode',20});
sma = AddState(sma, 'Name', 'flow40',...
    'Timer', TaskParameters.GUI.odorDur,...
    'StateChangeConditions', {'Tup', 'flow60'},...
    'OutputActions', {'SoftCode',40});
sma = AddState(sma, 'Name', 'flow60',...
    'Timer', TaskParameters.GUI.odorDur,...
    'StateChangeConditions', {'Tup', 'flow80'},...
    'OutputActions', {'SoftCode',60});
sma = AddState(sma, 'Name', 'flow80',...
    'Timer', TaskParameters.GUI.odorDur,...
    'StateChangeConditions', {'Tup', 'exit'},...
    'OutputActions', {'SoftCode',80});
end