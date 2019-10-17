function b = vorSubsV2(L,b)
%VorSubsV2 Vorwärtssubstitution Version 2
%   vorSubsV2(L,b) löst das Gleichungssystem Lx=b, wobei L eine
%   untere Dreiecksmatrix ist.
%   Input:
%       L -> nxn untere Dreiecksmatrix (restliche einträge werden ignoriert)
%            Darf auf der Diagonalen keine Null-Einträge haben.
%       b -> beliebiger Vektor im R^n.
%   Output:
%       x -> Vektor im R^n, welcher Lx=b erfüllt.
%
%   Problematik von V1:
%       Für dünn besetzte Matrizen wurden auch Null-Einträge betrachtet.
%       Desshalb ist die Laufzeit O(n^2) obwohl die meisten Einträge Null
%       sind.
%   Lösung:
%       Benutze "Vektorisierung", um die innere Schleife zu vermeiden.
%
%   Laufzeit:
%       voll besetztes L: O(n^2)
%       dünn besetztes L: O(n)

for i=1:length(b)
    b(i)=b(i)-L(i,1:i-1)*b(1:i-1);
    b(i)=b(i)/L(i,i);
end
end
