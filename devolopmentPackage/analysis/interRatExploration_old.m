function interRatExploration_old(ratsComp, plt)

%to do:
% restructure the ratStruct by session for multiple per rat!

% rats = ["Rio", "Tio", "Romo", "Roble"];
% for i = 1:size(rats, 2)
%   fprintf(rats(1,i))
%   ratRegress.(str2char(rats(1,i)));
% end


% cleaner way of doing it
% Gather the slopes from all the rats
% assumes that each rat has the same number of recordings
namefields = fieldnames(ratsComp.ratRegress);
%slopes = nan(1, numel(namefields));
for i = 1:numel(namefields)
  namefieldsfields(i,:) = fieldnames(ratsComp.ratRegress.(namefields{i}))';
end

for k = 1:numel(namefields)
  for i = 1:size(namefieldsfields,2)
      slopes(k,i) = ratsComp.ratRegress.(namefields{k}).(char(namefieldsfields(k,i))).pd.B(1);
  end
end


%slopes(1,i) = ratRegress.(namefields{i}).pd.B(1); 
slopesPrime = reshape(slopes, [1,numel(slopes)]);

fprintf(['The mean of the slopes is: ', num2str(mean(slopesPrime)), ' (n = ', num2str(numel(namefields)),')\n']);

if plt
  histogram(slopesPrime)
  title(['Slope of wave offset, mean: ', num2str(mean(slopesPrime)), ' (n = ', num2str(numel(namefields)),')']);
end


% slope of offset scatter plot
y = [1 2 3 4];
%figure; scatter(slopesPrime, y)

numSess = 2;
numAnimal = 4;
slopesP = reshape(slopesPrime, [numSess,numAnimal])';
slopesP = slopesP * -1; % bring them back positive
sPAvg = mean(slopesP');
sPError = std(slopesP') / sqrt(numSess);

y = [1 2 3 4];
sze = []; c = [1,2,3,5];
figure; scatter(y,sPAvg,sze,c,'filled');
axis([0,4.5,0,.4]); hold on;
err = sPError;
errorbar(y, x, err, 'LineStyle', 'none');
set(gca,'xtick',0:4);
title('Average Theta Shift Slopes');
xlabel('Animal'); ylabel('Slope');
end



