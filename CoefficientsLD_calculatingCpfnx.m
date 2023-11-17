
%% Function Testing
cls = zeros(1,31);
cds = zeros(1,31);
alphas =zeros(1,31);
for i = 1:16+15 
    alpha = i-15;
PortLoc = readmatrix('ClarkY14_PortLocations.xlsx'); % y is location front to bagck 
[cL, cD] = CoeffLD(NaN,alpha, PortLoc(:, 3), PortLoc(:, 4));
cls(i) = cL;
cds(i) = cD;
alphas(i) = alpha;
end 
figure(2);
plot(alphas, cls);
hold on;

 plot(alphas, cds);
 legend('Cl vs Alpha', 'Cd vs Alpha')
 xlabel("Alpha [Degrees]");
 ylabel("Coefficient Value")
% hold on 
function [cL, cD] = CoeffLD(cP, alpha, y, z)

    [cP,normalizedChord] = CPvsNormC(alpha);

    % Figure out where to split based on port locations (split at 0)
     
    % Find maximum y value -> Chord Length
    C = max(y);

    % Find z = 0 -> Trailing Edge
    TE = find(z == 0);
    TE = TE(2);

    yTop = y(1:TE);
    yBot = y(TE:length(y));
    zTop = z(1:TE);
    zBot = z(TE:length(y));
    cPTop = cP(1:TE);
    cPBot = cP(TE:length(y));

    % Calculate Cn and Ca using integrals
    cNTop = (-1/C)*(trapz(yTop, cPTop));
    cNBot = (-1/C)*(trapz(yBot, cPBot));
    cATop = (1/C)*(trapz(zTop, cPTop));
    cABot = (1/C)*(trapz(zBot, cPBot));

    cN = cNTop + cNBot;
    cA = cATop + cABot;

    cL = (cN.*cosd(alpha)) - (cA.*sind(alpha));
    cD = (cN.*sind(alpha)) + (cA.*cosd(alpha));

end