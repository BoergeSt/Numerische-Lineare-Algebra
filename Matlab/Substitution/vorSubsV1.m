function x = vorSubsV1(L,b)
%VorSubsV1 Vorwärtssubstitution
%   vorSubsV1(L,b) löst das Gleichungssystem Lx=b, wobei L eine
%   untere Dreiecksmatrix ist.
%   Input:
%       L -> nxn untere Dreiecksmatrix (restliche einträge werden ignoriert)
%            Darf auf der Diagonalen keine Null-Einträge haben.
%       b -> beliebiger Vektor im R^n.
%   Output:
%       x -> Vektor im R^n, welcher Lx=b erfüllt.
%
%   Laufzeit:
%       voll besetztes L: O(n^2)
%       dünn besetztes L: O(n^2)


x = b;                              % initialisiere x mit b
for i=1:length(b)                   % Schleife über alle Zeilen
    for j = 1:i-1                   % Schleife über alle nicht-diagonal Einträge
        x(i)=x(i)-L(i,j)*x(j);      % Aktualisiere x(i)
    end
    x(i)=x(i)/L(i,i);               % Teile x(i) durch jeweiliges Diagonalelement
end
end
