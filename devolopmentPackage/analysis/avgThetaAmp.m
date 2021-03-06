  m   function avgThetaAmp(root, epochSize, plt)

%plot(root.user_def.theta_amp);
epochSize = 0.100;

cycles = find(root.user_def.cycles(1,:));
badCycles = root.user_def.cleanData_inds2cut(cycles);
cycles(badCycles) = [];


cycleTs=root.b_ts(cycles); %finds all theta cycles
% finds bad theta cycles
%epochSize = 0.100; %sets epoch size (moved to function argument)
epochs = [cycleTs-epochSize cycleTs+epochSize]; % grabs epochs 
root.epoch = epochs; 

root.b_myvar = root.user_def.theta_amp'; % time across rows
epchData = root.myvar; 

% drop short epochs and trim long epochs until all are the same length
nSamp = cellfun(@(c) length(c), epchData,'uni',1);
epchLength = root.user_def.lfp_fs * 2 * epochSize;
shortEpochs = nSamp < epchLength; epchData(shortEpochs) = [];
epchData = cellfun(@(c) c(1:epchLength,:),epchData,'uni',0);

% now compute the mean wave
epchData = cat(3,epchData{:});
avgThetaAmp = mean(epchData,3);

[tPts,nElecs] = size(avgThetaAmp);
t = linspace(-epochSize,epochSize,epchLength);
%lfp_ = avgThetaAmp' / (-1 * 2.5 * rms(avgThetaAmp(:)));
lfp_ = avgThetaAmp';
offsets = repmat([1:nElecs]',1,tPts);
lfp_ = lfp_ + offsets;


h = figure;
plot(t,lfp_,'k'); axis ij;
%Change axis to reflect proper channels



atw = CTA.avgThetaWave;


grid on
end