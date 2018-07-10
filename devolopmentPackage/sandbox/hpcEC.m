
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
layout.hpcS1 = ;
layout.hpcS2 = ;
layout.hpcS3 = ;

% each hpc shank has 8 channels 
hpcD = D(layout.hpc,:);
ecD = D(layout.ec,:);

numSec = 1; 
samp = numSec * fs;
t = (0:samp);
figure; plot(t,hpcD(1,1:samp));











