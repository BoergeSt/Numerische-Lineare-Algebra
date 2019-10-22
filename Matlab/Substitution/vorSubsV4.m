function b = vorSubsV4(L,b)
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
%   Problematik von V3:
%       Die Idee zur beschleunigung der Vektorisierung von V3 beruht
%       darauf, dass die Matrix Spaltenweise abgespeichert wird. Dies ist
%       allerdings bei dünn besetzten Matrizen nicht der Fall. Desshalb
%       können wir eine Laufzeit von ca O(n^1.5) beobachten. Allerdings ist
%       die theoretisch beste Laufzeit O(n).
%   Lösung:
%       Auf voll besetzten Matrizen benutzen wir den optimierten
%       Algorithmus aus V3, während wir für dünn besetzte Matrizen den
%       Algorithmus so anpassen, dass er für deren Datenstruktur optimiert
%       ist.
%   Datenstruktur dünn besetzte Matrizen (Leicht vereinfacht dargestellt): 
%       Bei dünn besetzten Matrizen werden nur die Nichtnull-Einträge
%       abgespeichert. Deshalb muss man zusätzlich zu dem Wert jedes
%       Eintrags auch die zugehörige Zeile und Spalte abspeichern. Dazu
%       verwendet man 3 Vektoren welche häufig ia, ja und aa genannt
%       werden. Dazu werden alle Nichtnull-Einträge in aa abgespeichert. Um
%       diese den entsprechenden Positionen zuzuordnen wird die jeweilige
%       Zeilennummer in ia und die Spaltennummer in ja gespeichert. Zudem
%       werden alle Einträge nach Spalten sortiert gespeichert.
%
%   Laufzeit:
%       voll besetztes L: O(n^2)
%       dünn besetztes L: ca O(n^1)




if ~issparse(L)                 %Wenn voll besetzt -> V3

    for i=1:length(b)
        b(i)=b(i)/L(i,i);
        b(i+1:end)=b(i+1:end)-L(i+1:end,i)*b(i);
    end
    
else                            %Wenn dünn besetzt
   
    [ia,ja,aa] = find(L);       %Erhalte die drei Vektoren ia, ja, aa (siehe oben) 

    for k=1:length(ia)          %Anstelle einer Schleife über Spalten oder Zeilen, 
                                %  verwenden wir eine Schleife über alle
                                %  Nichtnull-Einträge
                            
        i = ia(k);              %die Zeile des aktuellen Eintrags
        j = ja(k);              %die Spalte des aktuellen Eintrags
        a = aa(k);              %der tatsächliche Wert des Eintrags

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
