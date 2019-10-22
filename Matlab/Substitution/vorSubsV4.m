function b = vorSubsV4(L,b)
%VorSubsV3 Vorw�rtssubstitution Version 3
%   vorSubsV3(L,b) l�st das Gleichungssystem Lx=b, wobei L eine
%   untere Dreiecksmatrix ist.
%   Input:
%       L -> nxn untere Dreiecksmatrix (restliche eintr�ge werden ignoriert)
%            Darf auf der Diagonalen keine Null-Eintr�ge haben.
%       b -> beliebiger Vektor im R^n.
%   Output:
%       x -> Vektor im R^n, welcher Lx=b erf�llt.
%
%   Problematik von V3:
%       Die Idee zur beschleunigung der Vektorisierung von V3 beruht
%       darauf, dass die Matrix Spaltenweise abgespeichert wird. Dies ist
%       allerdings bei d�nn besetzten Matrizen nicht der Fall. Desshalb
%       k�nnen wir eine Laufzeit von ca O(n^1.5) beobachten. Allerdings ist
%       die theoretisch beste Laufzeit O(n).
%   L�sung:
%       Auf voll besetzten Matrizen benutzen wir den optimierten
%       Algorithmus aus V3, w�hrend wir f�r d�nn besetzte Matrizen den
%       Algorithmus so anpassen, dass er f�r deren Datenstruktur optimiert
%       ist.
%   Datenstruktur d�nn besetzte Matrizen (Leicht vereinfacht dargestellt): 
%       Bei d�nn besetzten Matrizen werden nur die Nichtnull-Eintr�ge
%       abgespeichert. Deshalb muss man zus�tzlich zu dem Wert jedes
%       Eintrags auch die zugeh�rige Zeile und Spalte abspeichern. Dazu
%       verwendet man 3 Vektoren welche h�ufig ia, ja und aa genannt
%       werden. Dazu werden alle Nichtnull-Eintr�ge in aa abgespeichert. Um
%       diese den entsprechenden Positionen zuzuordnen wird die jeweilige
%       Zeilennummer in ia und die Spaltennummer in ja gespeichert. Zudem
%       werden alle Eintr�ge nach Spalten sortiert gespeichert.
%
%   Laufzeit:
%       voll besetztes L: O(n^2)
%       d�nn besetztes L: ca O(n^1)




if ~issparse(L)                 %Wenn voll besetzt -> V3

    for i=1:length(b)
        b(i)=b(i)/L(i,i);
        b(i+1:end)=b(i+1:end)-L(i+1:end,i)*b(i);
    end
    
else                            %Wenn d�nn besetzt
   
    [ia,ja,aa] = find(L);       %Erhalte die drei Vektoren ia, ja, aa (siehe oben) 

    for k=1:length(ia)          %Anstelle einer Schleife �ber Spalten oder Zeilen, 
                                %  verwenden wir eine Schleife �ber alle
                                %  Nichtnull-Eintr�ge
                            
        i = ia(k);              %die Zeile des aktuellen Eintrags
        j = ja(k);              %die Spalte des aktuellen Eintrags
        a = aa(k);              %der tats�chliche Wert des Eintrags

        if i==j                 %Wenn i==j dann ist a auf der Diagonale
            b(i)=b(i)/a;        %Alle vorherigen spalten wurden aufgrund der 
                                %  Sortierung bereits vorher abgezogen. Daher
                                %  brauchen wir nur noch durch das
                                %  Diagonalelement teilen.
                                
        else                    %Ansonsten ist a in der strikt unteren Dreiecksmatrix
            b(i)=b(i)-a*b(j);   %Die Nichtdiagonalelemente multiplizieren wir mit
                                %  den bereits berechneten werten b(j) und
                                %  ziehen dies von b(i) ab.
        end
    end
end
