function [h,figData] = plotCycleTriggeredAvg(root)

%!! Figure out which channel to do the calculations on (Reference?)

cycles = find(root.user_def.cycles(1,:));
badCycles = root.user_def.cleanData_inds2cut(cycles);
cycles(badCycles) = [];


cycleTs=root.b_ts(cycles); %finds all theta cycles
% finds bad theta cycles
epochSize = 0.100; %sets epoch size
epochs = [cycleTs-epochSize cycleTs+epochSize]; % grabs epochs 
root.epoch = epochs; 

root.b_myvar = root.user_def.lfp_origData'; % time across rows
epchData = root.myvar;
% drop short epochs and trim long epochs until all are the same length
nSamp = cellfun(@(c) length(c), epchData,'uni',1);
epchLength = root.user_def.lfp_fs * 2 * epochSize;
shortEpochs = nSamp < epchLength; epchData(shortEpochs) = [];
epchData = cellfun(@(c) c(1:epchLength,:),epchData,'uni',0);

% now compute the mean wave
epchData = cat(3,epchData{:});
avgThetaWave = mean(epchData,3);

h = figure;
[tPts,nElecs] = size(avgThetaWave);
t = linspace(-epochSize,epochSize,epchLength);
lfp_ = avgThetaWave' / (-1 * 2.5 * rms(avgThetaWave(:)));
offsets = repmat([1:nElecs]',1,tPts);
lfp_ = lfp_ + offsets;

plot(t,lfp_,'k'); axis ij;
%Change axis to reflect proper channels

xlabel('Time') %!! Is this correct? or should it be phase?
ylabel('Channel') % !! What about the axis though...
title('Averaged Waves')
ltr = text(0.02,0.98,'C','Units', 'Normalized', 'VerticalAlignment', 'Top');
s = ltr.FontSize;
ltr.FontSize = 12;
grid on

%Save and reorrient 
figData.CTA.avgThetaWave = avgThetaWave';
figData.CTA.lfp_ = lfp_;
figData.CTA.t = t;
root.user_def.atw = avgThetaWave';