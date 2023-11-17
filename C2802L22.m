
%% Read In Data 
SpanTest = readmatrix('ASEN2802_InfiniteWing_FullRange.csv');
PortLoc = readmatrix('ClarkY14_PortLocations.xlsx'); % y is location front to bagck 
T = SpanTest(:,1);%Atmospheric Temperature [K]
P =  SpanTest(:,2);% Atmospheric Pressure [Pa]
rho =  SpanTest(:,3);% Atmospheric Density [kg/m^3]
Vinf =  SpanTest(:,4); %Airspeed [m/s]
Pdyn = SpanTest(:,5); %Pitot Dynamic Pressure [Pa]
Paux = SpanTest(:,6); %Ayx Dyn Pressure [Pa]
Volt = SpanTest(:,7); % Applied Voltage[V]
alpha = SpanTest(:,8);% Angle of Attack [degrees]
x = SpanTest(:,9); %Spanwise Location [in]
FNorm = SpanTest(:,10); %Sting Normal Force [N]
FAx  = SpanTest(:,11); % Sting Axial Force [N]
Mpitch = SpanTest(:,12); %Sting Pitching Moment [Nm]
ProbeX = SpanTest(:,13); %ELD Probe X axis [mm]
ProbeY = SpanTest(:,14); %ELD Probe Y axis [mm]
Px01 = SpanTest(:,15); %Scanivalve Pressure 1 [Pa]
Px02 = SpanTest(:,16); %Scanivalve Pressure 2 [Pa]
Px03 = SpanTest(:,17); %Scanivalve Pressure 3 [Pa]
Px04 = SpanTest(:,18); %Scanivalve Pressure 4 [Pa]
Px05 = SpanTest(:,19); %Scanivalve Pressure 5 [Pa]
Px06 = SpanTest(:,20); %Scanivalve Pressure 6 [Pa]
Px07 = SpanTest(:,21); %Scanivalve Pressure 7 [Pa]
Px08 = SpanTest(:,22); %Scanivalve Pressure 8 [Pa]
Px09 = SpanTest(:,23); %Scanivalve Pressure 9 [Pa]
Px10 = SpanTest(:,24); %Scanivalve Pressure 10 [Pa]
Px11 = SpanTest(:,25); %Scanivalve Pressure 11 [Pa]
Px12 = SpanTest(:,26); %Scanivalve Pressure 12 [Pa]
Px13 = SpanTest(:,27); %Scanivalve Pressure 13 [Pa]
Px14 = SpanTest(:,28); %Scanivalve Pressure 14 [Pa]
Px15 = SpanTest(:,29); %Scanivalve Pressure 15 [Pa]
Px16 = SpanTest(:,30); %Scanivalve Pressure 16 [Pa]
    

    C = 3.5031; % [in] % Z is along cord I believe based on data range 0:about 3 in 
   % plot3(PortLoc(:,1),PortLoc(:,2),PortLoc(:,3))

    xlabel('x')
    ylabel('y')
    zlabel('z')
%% 
Cpi = zeros(640,16);
xci = zeros(1,16);
for i =  1:16 
    column = 14 + i ; % column from read in matrix starts 15 
    %skipping trailing edge data point 
    d = i;
    if i >= 10
        d = i+1;

    end
    Xnorm = PortLoc(d,3)/C; 
    xci(i) = Xnorm; 
    Pdiff = SpanTest(:,column); %p - pinf  
    Cpi(:,i) = Pdiff./Pdyn;
end 
% focusing on 4* angle of attack: row 400 of data table
%interpolate last data point 
%Cpf = interp1(xci(8:9), Cpi(400,8:9),0.9)
slope = (Cpi(400,8)-Cpi(400,9))  / (xci(8)-xci(9));
Cpf = slope*(1-xci(8))+Cpi(400,8);

% creating a single array 
xcif = [xci(1:9), 1, xci(10:16)];
Cpif = [Cpi(400,1:9), Cpf,Cpi(400,10:16) ];

%cP VS x/C graphs 
hold on;
figure(1);
plot(xcif, Cpif,['.-' ]);
plot(1,Cpf);
title("Normalized Chord vs Coeff. of Pressure at alpha = 4 degrees")
xlabel('X/c');
ylabel("Cp")
set(gca, 'YDir','reverse')