function A = genInvMat(n)
%genInvMat generiere zuf�llige invertierbare voll besetzte Matrix
%   Input:
%       n -> Gr��e der Matrix%   Output:
%   Output
%       A -> zuf�llig erzeugte invertierbare nxn Matrix
%   Warnung:
%       Kann f�r n>>100 lange Laufzeit haben.

while true
  A = rand(n);          %generiere zuf�llige Matrix
  if rank(A) == n       %teste Invertierbarkeit
      break;            %Breche Schleife ab wenn Matrix invertierbar
  end
end

end
