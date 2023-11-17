
%% Function Testing

[cL, cD] = CoeffLD(Cpif, alpha, PortLoc(:, 3), PortLoc(:, 4));

figure;
plot(alpha, cL);
hold on;
plot(alpha, cD);

function [cL, cD] = CoeffLD(cP, alpha, y, z)
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

    cL = (cN.*cos(alpha)) - (cA.*sin(alpha));
    cD = (cN.*cos(alpha)) + (cA.*cos(alpha));

end