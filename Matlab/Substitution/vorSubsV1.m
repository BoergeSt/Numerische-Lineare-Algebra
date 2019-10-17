function x = vorSubsV1(L,b)
%VorSubsV1 Vorw�rtssubstitution
%   vorSubsV1(L,b) l�st das Gleichungssystem Lx=b, wobei L eine
%   untere Dreiecksmatrix ist.
%   Input:
%       L -> nxn untere Dreiecksmatrix (restliche eintr�ge werden ignoriert)
%            Darf auf der Diagonalen keine Null-Eintr�ge haben.
%       b -> beliebiger Vektor im R^n.
%   Output:
%       x -> Vektor im R^n, welcher Lx=b erf�llt.
%
%   Laufzeit:
%       voll besetztes L: O(n^2)
%       d�nn besetztes L: O(n^2)


x = b;                              % initialisiere x mit b
for i=1:length(b)                   % Schleife �ber alle Zeilen
    for j = 1:i-1                   % Schleife �ber alle nicht-diagonal Eintr�ge
        x(i)=x(i)-L(i,j)*x(j);      % Aktualisiere x(i)
    end
    x(i)=x(i)/L(i,i);               % Teile x(i) durch jeweiliges Diagonalelement
end
end
