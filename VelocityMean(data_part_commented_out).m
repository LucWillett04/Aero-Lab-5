% Establish workspace
clc;
clear;
close all;

% Read in data
%inputFile = 'exampleFileName.csv';
%data = readmatrix(inputFile);

% Clean data of nans
% data(isnan(data)) = [];

% Implement scalingFactor
% Placeholder: convertedData = data(appropriate columns)*scalingFactor

% Need to move data into appropriate vectors for equation below

% Calculate magnitude of difference in pressures
% magnitudeDeltaP = abs(P2-P1);
magnitudeDeltaP = 150;
Tatm = 22+273.15;
Patm = 24.87*3386;
R=0.286*1000;

% Calculate airspeed
v=sqrt(2*magnitudeDeltaP.*((R*Tatm)./Patm));

% Find max airspeed
% maxV = max(v);

% disp('Maximum Airspeed');
% disp(maxV);
disp(v);