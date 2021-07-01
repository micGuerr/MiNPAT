%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Logbook for Longitdinal Data analysis
%
% NB: DO NOT MODIFY THIS FILE!
%     Make a copy of it, adapt to your paths and rename it to "processingLogBook.m"
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Name:
% 
% Starting date:
% 
% ...

%% SETUP

% Make sure you modified consistently the "LongAn_Setup.m" script.
% Run it every time you open Matlab and you want to start a new analysis:
LongAn_Setup;

%% SUBJECT 01

% set the dicom IDs
subid_dcm = '';
sesid_01_dcm = '';
sesid_02_dcm = '';
sesid_03_dcm = '';
sesid_04_dcm = '';
sesid_05_dcm = {'', ''};

% set the processing IDs
subid = '';
sesid_01 = '';
sesid_02 = '';
sesid_03 = '';
sesid_04 = '';
sesid_05 = '';

% Single session processing
l1 = longan_singleSessionProcessing(subid, sesid_01, subid_dcm, sesid_01_dcm);
l2 = longan_singleSessionProcessing(subid, sesid_02, subid_dcm, sesid_02_dcm);
l3 = longan_singleSessionProcessing(subid, sesid_03, subid_dcm, sesid_03_dcm);
l4 = longan_singleSessionProcessing(subid, sesid_04, subid_dcm, sesid_04_dcm);
l5 = longan_singleSessionProcessing(subid, sesid_05, subid_dcm, sesid_05_dcm);

% Multi session processing
%l = longan_multiSessionProcessing(subid, sesid_01, sesid_02, sesid_03, sesid_04, sesid_05);










