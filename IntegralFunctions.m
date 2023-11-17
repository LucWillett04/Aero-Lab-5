clc
clear
close all

L = 10;
E = 10^7;
I = ((0.5)*(0.12^3))/12;
C = (1/(E*I));
x = linspace(0,L,100);
J = length(x);
w1 = .95;
w0 = 1.37;
t = .12;

[Wrect,Wtri,Wtrap] = load(J,x,w1,w0,L); %This is currently set for a trapezoidal load (Based on the example Cl graph)
[Vrect,Vtri,Vtrap] = shear(Wrect,Wtri,Wtrap,x,L,J);
[Mrect,Mtri,Mtrap] = bendingmoment(Wrect,Wtri,Wtrap,x,L,J);
[vprimerect,vprimetri,vprimetrap] = deflectionslope(Wrect,Wtri,Wtrap,x,L,J,C);
[drect,dtri,dtrap] = deflection(Wrect,Wtri,Wtrap,x,L,J,C);
rectmaxdeflection = max(drect);
trimaxdeflection = max(dtri);
trapmaxdeflection = max(dtrap);
[Srect,Stri,Strap] = stress(Wrect,Wtri,Wtrap,L,I,t);
[Strect, Sttri, Sttrap] = strain(Srect,Stri,Strap,E);



function [Wrect, Wtri, Wtrap] = load(J,x,w1,w0,L)
Wtrap = zeros(1,J);
Wtri = zeros(1,J);
Wrect = zeros(1,J);
    for i = 1:J
        Wtrap(i) = (((w1-w0)/L).*x(i)) + w0;
        Wtri(i) = (w0/L).*x(i) + w0;
        Wrect(i) = w0;
    end
end

function [Vrect,Vtri,Vtrap] = shear(Wrect,Wtri,Wtrap,x,L,J)
Vrect = zeros(1,J);
Vtri = zeros(1,J);
Vtrap = zeros(1,J);
    for i = 1:J
        Vtrap(i) = -(Wtrap(i).*x(i)) + (Wtrap(i).*L);
        Vtri(i) = -(Wtri(i).*x(i)) + (Wtri(i).*L);
        Vrect(i) = -(Wrect(i).*x(i)) + (Wrect(i).*L);
    end
end

function [Mrect, Mtri, Mtrap] = bendingmoment(Wrect,Wtri,Wtrap,x,L,J)
Mtrap = zeros(1,J);
Mtri = zeros(1,J);
Mrect = zeros(1,J);
    for i = 1:J
     Mtrap(i) = (Wtrap(i).*x(i).^2)/2 - Wtrap(i).*L.*x(i) + (Wtrap(i).*L^2)/2;
     Mtri(i) = (Wtri(i).*x(i).^2)/2 - Wtri(i).*L.*x(i) + (Wtri(i).*L^2)/2;
     Mrect(i) = (Wrect(i).*x(i).^2)/2 - Wrect(i).*L.*x(i) + (Wrect(i).*L^2)/2;
    end
end

function [vprimerect, vprimetri, vprimetrap] = deflectionslope(Wrect,Wtri,Wtrap,x,L,J,C)
vprimerect = zeros(1,J);
vprimetri = zeros(1,J);
vprimetrap = zeros(1,J);
    for i = 1:J
        vprimetrap(i) = (C)*(Wtrap(i).*x(i).^3)/6 - (Wtrap(i).*x(i).^2*L)/2 + (Wtrap(i).*L^2.*x(i)./2);
        vprimetri(i) = (C)*(Wtri(i).*x(i).^3)/6 - (Wtri(i).*x(i).^2*L)/2 + (Wtri(i).*L^2.*x(i)./2);
        vprimerect(i) = (C)*(Wrect(i).*x(i).^3)/6 - (Wrect(i).*x(i).^2*L)/2 + (Wrect(i).*L^2.*x(i)./2);
    end
end

function [drect,dtri,dtrap] = deflection(Wrect,Wtri,Wtrap,x,L,J,C)
drect = zeros(1,J);
dtri = zeros(1,J);
dtrap = zeros(1,J);
for i = 1:J
    dtrap(i) = (C)*(((Wtrap(i).*x(i).^4)./24) - ((Wtrap(i).*x(i).^3*L)./6) + ((Wtrap(i).*L^2.*x(i).^2)./4));
    dtri(i) = (C)*(((Wtri(i).*x(i).^4)./24) - ((Wtri(i).*x(i).^3*L)./6) + ((Wtri(i).*L^2.*x(i).^2)./4));
    drect(i) = (C)*(((Wrect(i).*x(i).^4)./24) - ((Wrect(i).*x(i).^3*L)./6) + ((Wrect(i).*L^2.*x(i).^2)./4));
end
end

function [Srect,Stri,Strap] = stress(Wrect,Wtri,Wtrap,L,I,t)
    %for i = 1:J
        Strap = -((max(Wtrap).*L^2*(t/2))/(2*I));
        Stri = -((max(Wtri).*L^2*(t/2))/(2*I));
        Srect = -((max(Wrect).*L^2*(t/2))/(2*I));
    %end
end

function [Strect,Sttri,Sttrap] = strain(Srect,Stri,Strap,E)
    %for i = 1:iterator
         Strect = Srect/E;
         Sttri = Stri/E;
         Sttrap = Strap/E;
    %end
end