clc;clear;close all

nSections = 4;
Length = 10;
w0 = 10;
w1 = 4;

dx = Length/nSections;
x = 0:dx:Length;
LineFunc = (((w1-w0)/Length).*x) + w0;

Area = zeros(nSections,1);

for i = 1:nSections
Area(i) = ((LineFunc(i)-LineFunc(i+1))*dx)/2 + LineFunc(i+1)*dx;
end
