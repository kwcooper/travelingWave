
% finds the corolation of each epoch theta wave to the average
% need to make sure the average isn't skewed for plotting
% need to adjust for the raw eeg

% (!) for romo let's just look at the first 4 channels


epch = CTA.epDat;
atw = CTA.avgThetaWave;
origData = root.user_def.lfp_origData;
cycles = root.user_def.cycles; % !/TD: Just the peaks? wb the troughs?


%nnz(cycles) % counts number of nonzero elements

%inds = nan(8,11000);

%Create a cell array to store the cycle indicies
for i = 1:size(cycles, 1)
  inds{i} = find(cycles(i,:));
end

% find cell bounds and resize all mats to match
[minSize, minIdx] = min(cellfun('size', inds, 2));
[maxSize, maxIdx] = max(cellfun('size', inds, 2));
fprintf(['Cutting ', num2str(maxSize - minSize), ' points.\n']);
for i = 1:size(inds, 2)
  inds{i} = inds{i}(1, 1:minSize);
end

% change orientation and convert to a mat
indsMat = cell2mat(inds');

%td: combine these
% Let's you scroll through the data to see what it looks like. 
figure;
fprintf('press enter to scan through data!\n');
for i = 1:100
  hold off;
  plot(indsMat(:,i),1:8, 'o');
  title(num2str(i));
  pause;
end

% plot the first set of points with the fitted slope
figure;
i = 1;
p = polyfit(1:size(indsMat(:,i), 1),indsMat(:,i)',1);
pv = polyval(p,1:size(indsMat(:,i), 1));
plot(1:size(indsMat(:,i), 1),indsMat(:,i)', 'o');
title(['slope', num2str(p(1))]);
hold on;
plot(1:size(indsMat(:,i), 1),pv);



% find the slope for each column



% View the phase offset per cycle
%plot(cycles(4:8,1:500)')


% l = [1:4; fliplr(1:4); 3:6]
% k = [3 2];
% 
% for i = 1:size(l,1)
%   r = xcorr2(k,l);
% end
% 
% 
% r = xcorr2(atw, origData(:,1:1000));
% plot(r')
% 
% 
% %for i = 1:size(origData,1)
% clear r
% for i = 1
%   r(i,:) = xcorr(atw(i,:), origData(i,:));
% end
% 
% for i = 1:size(epch, 3):
%   
% end


