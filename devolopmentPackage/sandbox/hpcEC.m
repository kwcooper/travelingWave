
% hippocampus and ec data: Ronaldo

%
% ______HS1________    _______HS2_______    __________HS3________   
%8 7 5 6 11 12 14 13  31 32 30 29 4 3 1 2  20 19 21 22 27 28 26 25 

% ________________       _______________   _______________     
%35 61 42 47 51 54 56  34 60 43 48 52 55  39 33 59 44 49 53 

% ____________    ____________    _________
%38 64 58 45 50  15 37 63 57 46  40 36 62 41  

%%
clear all; 

sessions = {...
  'Ronaldo',  'CircleTrack_2018-06-18',  '2018-06-18_15-10-29', 'DualR', [], 1, 7, [60 600], [];...
  'ROnaldo',  'WmazeNoTask_2018-06-22',  '2018-06-22_19-38-24', 'noTask',[8 7 5 6 11 12 14 13 31 32 30 29 4 3 1 2 20 19 21 22 27 28 26 25 35 61 42 47 51 54 56 34 60 43 48 52 55 39 33 59 44 49 53 38 64 58 45 50 15 37 63 57 46 40 36 62 41], 1, 7, [60 600], []...
  };

sInd = 2;
  
metaData = struct;
metaData.Rat = sessions{sInd,1};
metaData.Session = sessions{sInd,2};
metaData.Recording = sessions{sInd,3};
metaData.chTxt = sessions{sInd,4};
metaData.chOrd = sessions{sInd,5};
metaData.ref = sessions{sInd,6};
metaData.trackRef = sessions{sInd,7};
metaData.filtParams = sessions{sInd, 8};
metaData.badEnds = sessions{sInd,9};


dataPath = fullfile(ratLibPath,metaData.Rat,metaData.Session,metaData.Recording); cd(dataPath);
 
% grab data
disp('Grabbing data...'); tic
fnames = dir(fullfile(dataPath,'100_CH*.continuous'));
[D, fs, fType] = kLoadIntanLFP(metaData.chOrd,dataPath,fnames);
metaData.fType = fType; 
toc

%% data preprocessing
 b_ts = linspace(0,size(D,2)/fs,size(D,2)+1); b_ts = b_ts(2:end)';
 root = CMBHOME.Session('name', metaData.Rat, 'epoch', [-inf inf], 'b_ts', b_ts);

 % store useful data in root
root.user_def.lfp_origData = D;
root.user_def.lfp_fs = fs;
root.user_def.metaData = metaData;


% struct to hold the various cannels for each region... this will need to
% be modified
layout.hpc = 1:24; % 8*3 = 24
layout.ec = 25:size(D,1); % rest
% by shank:
layout.hpcS1 = 1:8;
layout.hpcS2 = 9:16;
layout.hpcS3 = 17:24;
layout.ecL1 = 25:31;  %7
layout.ecL2 = 32:37;  %6
layout.ecL3 = 38:43;  %6
layout.ecL4 = 44:48;  %5
layout.ecL5 = 49:53;  %5
layout.ecL6 = 54:57;  %4


%% play with frequencies
os = 1000;
hpcSamp = D(layout.hpc(1:8:end),1+os:1000+os)';
%Grab frequencies of intrest -> add 3 not two gammas?
%             th     lg       mg
freqList = {[6 12],[25 60],[60 120]};
freqNames = {'th','lg','mg'};
theta = [freqList{1}];

figure; suptitle('Freq Bands')
for i = 1:size(freqList,2)
  subplot(size(freqList,2),1,i)
  plot(buttfilt(hpcSamp,freqList{i},fs,'bandpass',3))
  title(freqNames{i})
end

figure; suptitle('Hilbert')
for i = 1:size(freqList,2)
  subplot(size(freqList,2),1,i)
  plot(abs(hilbert(buttfilt(hpcSamp,freqList{i},fs,'bandpass',3))))
  title(freqNames{i})
end

%% play with power spectrum -> kramer 2013
x = D(layout.hpc(1),1+os:10000+os);
dt = 1/fs;
T = size(x,2) / 500;

xf = fft(x);                       % Compute the Fourier transform of x.
Sxx = (2*dt^2)/T * xf .* conj(xf); % Compute the power spectrum.
Sxx = Sxx(1:length(x)/2+1);        % Ignore negative frequencies.
df = 1/max(T);                     % Determine the frequency resolution.
fNQ = 1/dt/2;                      % Determine the Nyquist frequency.
faxis = (0:df:fNQ);                % Construct the frequency axis.
figure; plot(faxis, Sxx)        
xlim([0 100])                     
xlabel('Frequency [Hz]');
ylabel('Power')                    
title('Ronaldo CH1 2s Power Spectrum')

figure; plot(faxis, 10*log10(Sxx)) % Plot power versus frequency on decibel scale.
xlim([0 100])                      
xlabel('Frequency [Hz]');
ylabel('Power')                    
title('Ronaldo CH1 2s Power Spectrum')

%%
% Read (Pereda et al., 2005; Greenblatt et al., 2012) for general multi-channel material
% Coherence lit -> Read (Engel et al., 2001)



% td: average fft across trials or across time? 

%% Data exploration

% each hpc shank has 8 channels 
hpcD = D(layout.hpc,:);
ecD = D(layout.ec,:);

%grab a couple hpc channels for viewing
hpcS = D(layout.hpc(1:4:end),:);
hpcS_P = spreadLFP(hpcS(:,1:1000),5);
figure; plot(hpcS_P');


% where did i go wrong on my time calc?
% the disp lfp does not mach channel 1 in the ss
% is open ephys filtered? 

numSec = 2; 
ssOffset = 709 * fs; %ss @ 00:11:49 -> 709s
offset = ssOffset;
samp = numSec * fs;
t = linspace(0,numSec,samp);
figure; plot(t,hpcD(1,1+offset:samp+offset));











