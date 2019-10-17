function b = vorSubsV3(L,b)
%VorSubsV3 Vorwärtssubstitution Version 3
%   vorSubsV3(L,b) löst das Gleichungssystem Lx=b, wobei L eine
%   untere Dreiecksmatrix ist.
%   Input:
%       L -> nxn untere Dreiecksmatrix (restliche einträge werden ignoriert)
%            Darf auf der Diagonalen keine Null-Einträge haben.
%       b -> beliebiger Vektor im R^n.
%   Output:
%       x -> Vektor im R^n, welcher Lx=b erfüllt.
%
%   Problematik von V2:
%       Ist trotz Vektorisierung auf voll besetzten Matrizen teilweise 
%       langsamer als V1. Dies liegt daran, dass Matlab Matrizen intern
%       Spaltenweise abspeichert. Desshalb ist ein Spaltenweiser Zugriff
%       auf Matrizen deutlich schneller.
%   Lösung:
%       Anstatt zeilenweise durch die Matrix zu "gehen", führen wir die
%       Operationen spaltenweise durch. 
%
%   Laufzeit:
%       voll besetztes L: O(n^2)
%       dünn besetztes L: O(n)

for i=1:length(b)
   b(i)=b(i)/L(i,i);
   b(i+1:end)=b(i+1:end)-L(i+1:end,i)*b(i);
end
end
