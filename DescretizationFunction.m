clc;clear;close all

nSections = 4;
Length = 10;
w0 = 10;
w1 = 5;

dx = Length/nSections;
x = 0:dx:Length;
LineFunc = (((w1-w0)/Length).*x) + w0;

% Area of each section N
Area = zeros(nSections,1);

for i = 1:nSections
    Area(i) = ((LineFunc(i)-LineFunc(i+1))*dx)/2 + LineFunc(i+1)*dx;
end

% Centroid of each section N
Centroid = zeros(nSections + 2,1);

for j = 1:nSections
    Centroid(j) = dx*(LineFunc(j) + 2*LineFunc(j+1))/(3*(LineFunc(j) + LineFunc(j+1)));
    if j > 1
        Centroid(j) = Centroid(j) + (dx*(j-1));
    end
end

% Wiffle Tree Dimensions

Centroid(5) = ((Area(1)*Centroid(1) + Area(2)*Centroid(2))/(Area(1)+Area(2)));
Centroid(6) = ((Area(3)*Centroid(3) + Area(4)*Centroid(4))/(Area(3)+Area(4)));

Rod1 = Centroid(6) - Centroid(5);
Rod2 = Centroid(2) - Centroid(1);
Rod3 = Centroid(4) - Centroid(3);

