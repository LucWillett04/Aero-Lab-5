clc
clear
close all

L = 10;
E = 10^7;
I = ((0.5)*(0.12^3))/12;
C = (1/(E*I));
x = linspace(0,L,100);
J = length(x);
%z = linspace(zmin,zmax,100);
%k = length(z);
w1 = .95;
w0 = 1.37;
t = .12;

[W] = load(J,x,w1,w0,L); %This is currently set for a trapezoidal load (Based on the example Cl graph)
[V] = shear(W,x,L,J);
[M] = bendingmoment(W,x,L,J);
[vprime] = deflectionslope(W,x,L,J,C);
[d] = deflection(W,x,L,J,C);
maxdeflection = max(d);
[S] = stress(W,L,I,t);
[St] = strain(S,E);



%Shearforce = integral(load(x),0,L);
%Bendingmoment = integral(shear(W,x,L),0,L);
%Vslope = integral(bendingmoment(W,x,L),0,L);
%deflection = integral(deflectionslope(W,x,L),0,L);



function [W] = load(J,x,w1,w0,L)
W = zeros(1,J);
    for i = 1:J
        W(i) = (((w1-w0)/L).*x(i)) + w0; %This will change with new function
    end
end

function [V] = shear(W,x,L,J)
V = zeros(1,J);
    for i = 1:J
        V(i) = -(W(i).*x(i)) + (W(i).*L);
    end
end

function [M] = bendingmoment(W,x,L,J)
M = zeros(1,J);
    for i = 1:J
     M(i) = (W(i).*x(i).^2)/2 - W(i).*L.*x(i) + (W(i).*L^2)/2;
    end
end

function [vprime] = deflectionslope(W,x,L,J,C)
vprime = zeros(1,J);
    for i = 1:J
        vprime = (C)*(W(i).*x(i).^3)/6 - (W(i).*x(i).^2*L)/2 + (W(i).*L^2.*x(i)./2);
    end
end

function [d] = deflection(W,x,L,J,C)
d = zeros(1,J);
for i = 1:J
    d(i) = (C)*(((W(i).*x(i).^4)./24) - ((W(i).*x(i).^3*L)./6) + ((W(i).*L^2.*x(i).^2)./4));
end
end

function [S] = stress(W,L,I,t)
    %for i = 1:J
        S = -((max(W).*L^2*(t/2))/(2*I));
    %end
end

function [St] = strain(S,E)
    %for i = 1:iterator
         St = S/E;
    %end
end