clc;clear;close all

nSections = 4;
Length = 10;
w0 = 10;
w1 = 6;

dx = Length/nSections;
x = 0:dx:Length;
LineFunc = (((w1-w0)/Length).*x) + w0;

% Area of each section N
Area = zeros(nSections,1);

for i = 1:nSections
    Area(i) = ((LineFunc(i)-LineFunc(i+1))*dx)/2 + LineFunc(i+1)*dx;
end

% Centroid of each section N
Centroid = zeros(nSections,1);

for j = 1:nSections
    Centroid(j) = (dx*(2*LineFunc(i) + LineFunc(i+1)))/(3*(LineFunc(i) + LineFunc(i+1)));
    if j > 1
        Centroid(j) = Centroid(j) + (dx*(j-1));
    end
end
