% This script will make fnameSets for the Indiana data. 

%%
overwrite = 1;
basePath = fullfile(dropboxPath,'ratsEphys');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%
animalID = 'Tio';
prefixes = {...                                                             
  '170713_1325_CircleTrack_good'...                                                                                     
  };     
                       
group = '170804_1200_170804_1315_170804_1745_CS';   
manip = 'FAM';
dose = NaN;
anatomy = {...
  'CA1',...% 1
  'CA1',... % 2
  'CA1',... % 3
  'CA1',... % 4
  'CA1',... % 5
  'CA1',... % 6
  'CA1',... % 7
  'CA1',... % 8
  'CA1',... % 9
  'CA1',... % 10
  'CA1',... % 11
  'CA1',... % 12
  'CA1',... % 13
  'CA1',... % 14
  'CA1',... % 15
  'CA1'};   % 16

ref = 9;
fType = 'kwik';
alignDataTimebase(animalID,prefixes,[],[],ref,fType);
chOrd = [53 52 58 59 37];
outFiles = invivoImport('basePath',basePath,'overwrite',overwrite,'ratNames',{animalID},'prefixes',prefixes,'group',group,'chOrd',chOrd, 'fileType', fType);

dataSetPath = fullfile(basePath);
fnameSet_fname = [animalID,'_',prefixes{1}(1:6),'_',num2str(dose),'_',manip,'_fnameSet.mat'];

% create fnameSets
cmbObj_folder = fullfile('ratsEphys',animalID,[animalID,'_txtDataFiles'],'cmbObjsV2');
n = 1;

fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
fnameSet(n).sess_label = 'CT_pre';
fnameSet(n).dose = -1;
n=n+1;

fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
fnameSet(n).sess_label = 'CT_inj';
fnameSet(n).dose = dose;
n=n+1;

fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
fnameSet(n).sess_label = 'CT_3-6';
fnameSet(n).dose = -1;
n=n+1;

% fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
% fnameSet(n).sess_label = 'CT_24';
% fnameSet(n).dose = -1;
% n=n+1;

[fnameSet.anatomy] = deal(anatomy);
[fnameSet.manip] = deal(manip);

save(fullfile(dataSetPath,fnameSet_fname),'fnameSet','group'); % saves group to fnameSet file SJV 20151211
runPreprocessData(fnameSet);
clear fnameSet


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
animalID = 'Jolene';
prefixes = {...                                                             
  '170805_1200_CircleTrack'...                                             
  '170805_1300_15minPostSalInj_CircleTrack',...                                          
  };     
                       
group = '170805_1200_170805_1300_CS';   
manip = 'saline';
dose = 0;
anatomy = {...
  'CA1',...% 1
  'CA1',... % 2
  'CA1',... % 3
  'CA1',... % 4
  'CA1',... % 5
  'CA1',... % 6
  'CA1',... % 7
  'CA1',... % 8
  'CA1',... % 9
  'CA1',... % 10
  'CA1',... % 11
  'CA1',... % 12
  'CA1',... % 13
  'CA1',... % 14
  'CA1',... % 15
  'CA1'};   % 16

ref = 1;
alignDataTimebase(animalID,prefixes,[],[],ref,'openephys');
chOrd = [39,35,59,63,47,43,51,55,53,49,57,61,37,33,41,45,17,21,29,25,1,5,13,9,11,15,23,19,3,7,31,27,26,30,6,2,18,22,14,10,12,16,8,4,28,32,24,20,48,44,36,40,64,60,52,56,54,50,42,46,62,58,34,38];
outFiles = invivoImport('basePath',basePath,'overwrite',overwrite,'ratNames',{animalID},'prefixes',prefixes,'group',group,'chOrd',chOrd);

dataSetPath = fullfile(dropboxPath,'scripts','projects','phasePrecession','dataSets');
fnameSet_fname = [animalID,'_',prefixes{1}(1:6),'_',num2str(dose),'_',manip,'_fnameSet.mat'];

% create fnameSets
cmbObj_folder = fullfile('ratsEphys',animalID,[animalID,'_txtDataFiles'],'cmbObjsV2');
n = 1;

fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
fnameSet(n).sess_label = 'CT_pre';
fnameSet(n).dose = -1;
n=n+1;

fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
fnameSet(n).sess_label = 'CT_inj';
fnameSet(n).dose = dose;
n=n+1;

% fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
% fnameSet(n).sess_label = 'CT_3-6';
% fnameSet(n).dose = -1;
% n=n+1;

% fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
% fnameSet(n).sess_label = 'CT_24';
% fnameSet(n).dose = -1;
% n=n+1;

[fnameSet.anatomy] = deal(anatomy);
[fnameSet.manip] = deal(manip);

save(fullfile(dataSetPath,fnameSet_fname),'fnameSet','group'); % saves group to fnameSet file SJV 20151211
runPreprocessData(fnameSet);
clear fnameSet


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%
animalID = 'Jolene';
prefixes = {...                                                             
  '170809_1230_CircleTrack'...                                             
  '170809_1330_15minPostSalInj_CircleTrack',...
  '170809_1838_CircleTrack'...                                           
  };     
                       
group = '170809_1230_170809_1330_170809_1838_CS';   
manip = 'saline';
dose = 0;
anatomy = {...
  'CA1',...% 1
  'CA1',... % 2
  'CA1',... % 3
  'CA1',... % 4
  'CA1',... % 5
  'CA1',... % 6
  'CA1',... % 7
  'CA1',... % 8
  'CA1',... % 9
  'CA1',... % 10
  'CA1',... % 11
  'CA1',... % 12
  'CA1',... % 13
  'CA1',... % 14
  'CA1',... % 15
  'CA1'};   % 16

ref = 1;
alignDataTimebase(animalID,prefixes,[],[],ref,'openephys');
chOrd = [39,35,59,63,47,43,51,55,53,49,57,61,37,33,41,45,17,21,29,25,1,5,13,9,11,15,23,19,3,7,31,27,26,30,6,2,18,22,14,10,12,16,8,4,28,32,24,20,48,44,36,40,64,60,52,56,54,50,42,46,62,58,34,38];
outFiles = invivoImport('basePath',basePath,'overwrite',overwrite,'ratNames',{animalID},'prefixes',prefixes,'group',group,'chOrd',chOrd);

dataSetPath = fullfile(dropboxPath,'scripts','projects','phasePrecession','dataSets');
fnameSet_fname = [animalID,'_',prefixes{1}(1:6),'_',num2str(dose),'_',manip,'_fnameSet.mat'];

% create fnameSets
cmbObj_folder = fullfile('ratsEphys',animalID,[animalID,'_txtDataFiles'],'cmbObjsV2');
n = 1;

fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
fnameSet(n).sess_label = 'CT_pre';
fnameSet(n).dose = -1;
n=n+1;

fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
fnameSet(n).sess_label = 'CT_inj';
fnameSet(n).dose = dose;
n=n+1;

fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
fnameSet(n).sess_label = 'CT_3-6';
fnameSet(n).dose = -1;
n=n+1;

% fnameSet(n).name = path2array(fullfile(cmbObj_folder,['CMBH_',prefixes{n}]));
% fnameSet(n).sess_label = 'CT_24';
% fnameSet(n).dose = -1;
% n=n+1;

[fnameSet.anatomy] = deal(anatomy);
[fnameSet.manip] = deal(manip);

save(fullfile(dataSetPath,fnameSet_fname),'fnameSet','group'); % saves group to fnameSet file SJV 20151211
runPreprocessData(fnameSet);
clear fnameSet
