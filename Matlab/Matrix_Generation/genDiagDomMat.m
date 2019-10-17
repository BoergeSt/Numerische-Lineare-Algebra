function A = genDiagDomMat(n)
%genInvMat generiere zufällige streng diagonal-dominante voll besetzte Matrix
%   Input:
%       n -> Größe der Matrix
%   Output:
%       A -> zufällig erzeugte streng diagonal-dominante nxn Matrix



A = rand(n)*2-1;                    %generiere zufällige Matrix
A = A + diag(sum(abs(A),2));        %addiert die betragliche Zeilensumme zur Diagonalen

end
