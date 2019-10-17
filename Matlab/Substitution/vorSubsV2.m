function b = vorSubsV2(L,b)
%VorSubsV2 Vorw�rtssubstitution Version 2
%   vorSubsV2(L,b) l�st das Gleichungssystem Lx=b, wobei L eine
%   untere Dreiecksmatrix ist.
%   Input:
%       L -> nxn untere Dreiecksmatrix (restliche eintr�ge werden ignoriert)
%            Darf auf der Diagonalen keine Null-Eintr�ge haben.
%       b -> beliebiger Vektor im R^n.
%   Output:
%       x -> Vektor im R^n, welcher Lx=b erf�llt.
%
%   Problematik von V1:
%       F�r d�nn besetzte Matrizen wurden auch Null-Eintr�ge betrachtet.
%       Desshalb ist die Laufzeit O(n^2) obwohl die meisten Eintr�ge Null
%       sind.
%   L�sung:
%       Benutze "Vektorisierung", um die innere Schleife zu vermeiden.
%
%   Laufzeit:
%       voll besetztes L: O(n^2)
%       d�nn besetztes L: O(n)

for i=1:length(b)
    b(i)=b(i)-L(i,1:i-1)*b(1:i-1);
    b(i)=b(i)/L(i,i);
end
end
