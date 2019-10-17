function A = genInvMat(n)
%genInvMat generiere zufällige invertierbare voll besetzte Matrix
%   Input:
%       n -> Größe der Matrix%   Output:
%   Output
%       A -> zufällig erzeugte invertierbare nxn Matrix
%   Warnung:
%       Kann für n>>100 lange Laufzeit haben.

while true
  A = rand(n);          %generiere zufällige Matrix
  if rank(A) == n       %teste Invertierbarkeit
      break;            %Breche Schleife ab wenn Matrix invertierbar
  end
end

end
