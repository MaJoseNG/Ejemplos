function [LatLoad, NodeLateralDisp] = plotGlobalResponse(datafolder)
    
    NodeDisp = importdata(fullfile(datafolder,'NODE_DISP.out'));
    Node1Reac = importdata(fullfile(datafolder,'REACTIONS_1.out'));
    Node2Reac = importdata(fullfile(datafolder,'REACTIONS_2.out'));
    Node3Reac = importdata(fullfile(datafolder,'REACTIONS_3.out'));
    
    LatLoad = Node1Reac(:,2)+Node2Reac(:,2)+Node3Reac(:,2);    %[N]
    NodeLateralDisp = NodeDisp(:,2);                           %[mm]
end