function A = genDiagDomMat(n)
%genInvMat generiere zuf�llige streng diagonal-dominante voll besetzte Matrix
%   Input:
%       n -> Gr��e der Matrix
%   Output:
%       A -> zuf�llig erzeugte streng diagonal-dominante nxn Matrix



A = rand(n)*2-1;                    %generiere zuf�llige Matrix
A = A + diag(sum(abs(A),2));        %addiert die betragliche Zeilensumme zur Diagonalen

end
