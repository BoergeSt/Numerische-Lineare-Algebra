%% Laufzeittest von vorSubs für große voll besetzte Matrizen
% Die Laufzeit von wird für verschiedene Matrixgrößen gemessen, und
% daraufhin in einem n-t (Matrixgröße-Laufzeit) Diagram dargestellt.
%
% Um Laufzeit zu sparen, wird am anfang eine zufällige (diagonaldominante)
% Dreiecksmatrix erzeugt, aus der jeweils die oberen nxn Blöcke zur
% Laufzeitanalyse verwendet werden.


n = floor(linspace(10^3,10^4,20));      % Größen der 20 Matrizen zwischen 10^3 und 10^4
L0 = tril(genDiagDomMat(n(end)));       % zufällige diagonaldominanten Testmatrix maximaler Größe
b0 = rand(n(end),1);                    % erzeugen der rechten Seite

laufzeiten = zeros(3,length(n));        % Matrix zum Abspeichern der Laufzeiten für V1-V3

for k=1:length(n)
    L=L0(1:n(k),1:n(k));                % Matrix der Größe n(k) x n(k)
    b=b0(1:n(k));                       % Vektor der Größe n(k)

    tic;                                % Starte Zeitmessung
    vorSubsV1(L,b);                     % Rufe vorsubsV1 auf
    laufzeiten(1,k)=toc;                % Stoppe die Zeitmessung und speicher das
                                        %   Ergebnis in der Laufzeit Matrix
    tic;
    vorSubsV2(L,b);
    laufzeiten(2,k)=toc;

    tic;
    vorSubsV3(L,b);
    laufzeiten(3,k)=toc;
end

%% Erstelle linearen Plot der Laufzeiten für voll besetzte Matrizen

subplot(2,2,1);                         % oberer linker plot
plot(n,laufzeiten);                     % linearer plot
legend('V1','V2','V3');                 % benenne die Daten
legend('Location','northwest');         % Verschiebe die Legende nach oben links
title('Linearer Plot für voll besetzte Matrizen')

% Interpretation der Ergebnisse:
%   - Unabhängig von V1-V3 sind alle laufzeiten parabelförmig. Ob
%     allerdings die Laufzeit wirklich mit O(n^2) zunimmt, kann in linearen
%     plots schwer erkannt werden (vgl. nächster Abschnitt)
%
%   - Es gibt ein paar Ausreißer, welche länger brauchen. Dies liegt daran,
%     dass der Computer neben Matlab auch noch andere Tasks abarbeiten
%     muss. Für glattere Ergebnisse, sollte der Laufzeittest mehrmals
%     durchgeführt und anschließend der Durchschnitt gebildet werden.
%
%   - Direkter Vergleich zwischen V1,V2 und V3:
%     * V3 ist deutlich schneller als V1 und V2, Insbesondere für große n:
%       Dies liegt daran, dass Matrizen in Matlab spaltenweise
%       abgespeichert sind, und der spaltenweise Zugriff dementsprechend
%       deutlich schneller ist.
%     * V2 ist langsamer als V1:
%       Vektorisierung ist nur dann besser als eine Schleife über alle
%       Elemente, wenn die Vektoren bereits vorliegen. Da die Matrizen
%       jedoch spaltenweise gespeichert sind, muss Matlab sich aus jeder
%       Spalte den entsprechenden Wert erst raussuchen, dann in einen
%       Vektor zusammenfügen, und kann dann erst das Skalarprodukt
%       ausführen. Dies dauert länger, als direkt das Skalarprodukt
%       komponentenweise zu berechnen.


%% Erstelle logarithmischen Plot der Laufzeiten für voll besetzte Matrizen

subplot(2,2,2);                             % oberer rechter plot
loglog(n,laufzeiten);                       % doppelt logarithmischer plot
hold on
c = laufzeiten([1,3],end)./n(end).^2;       % berechne die Vorfaktoren für die 
                                            % Vergleichs-Parabeln für V1 und V3
loglog(n,c*n.^2,'--');                      % plotte die Verglichs-Parabeln
hold off
legend('V1','V2','V3','c_1*n^2','c_3*n^2'); % benenne die Daten
legend('Location','northwest');             % Verschiebe die Legende nach oben links
title('Doppelt Logarithmischer Plot für voll besetzte Matrizen')

% Interpretation der Ergebnisse:
%   - Asymptotisch können wir die theoretische Laufzeit von O(n^2) in allen
%     drei Methoden beobachten.
%   - Die deutlich schnellere Laufzeit des V3 kann hier durch eine
%   vertikale Verschiebung gesehen werden.
%   - die starken Schwankungen die hier auftreten, sind ähnlich wie die
%     "Ausreißer" im linearen Plot unter anderem auf schwankende
%     Rechnerauslastung durch andere Prozesse zurückzuführen. Um diese
%     auszugleichen, sollte jeder Test mehrmals durchgeführt und das
%     Mittelmaß verwendet werden. Dies dauert allerdings dementsprechend
%     länger, wesshalb in dieser Übung darauf verzichtet wurde.



%% Laufzeittest von vorSubs für große dünn besetzte Matrizen
% Die Laufzeit von wird erneut für diesmal dünn besetzte Matrizen gemessen.
% Als Testmatrix verwenden wir die untere Dreiecksmatrix der 
% Poisson-Matrizen aus der Matlab-Galerie.
% Diese werden benutzt um die 2-Dimensionale partielle
% Differentialgleichung -(u_{xx}+u_{yy})=f numerisch zu lösen.
%
% Damit die Laufzeit nicht explodiert, wenden wir V1 nur auf kleine
% Matrizen an.

n = floor(linspace(5,100,50));      % 
laufzeiten2 = zeros(4,length(n));       % Zum abspeichern der Laufzeiten für dünn besetzte Matrizen
L0=tril(gallery('poisson',n(end)));

for k=1:length(n)
    L=L0(1:(n(k)^2),1:(n(k)^2));     % Matrix der Größe n(k)^2 x n(k)^2
    b=rand(n(k)^2,1);                   % Vektor der Größe n(k)^2
    
    if n(k)^2 < 6*10^2
        tic;                                
        vorSubsV1(L,b);                     
        laufzeiten2(1,k)=toc;  
    else
        laufzeiten2(1,k)=nan;
    end
    
    tic;
    vorSubsV2(L,b);
    laufzeiten2(2,k)=toc;

    tic;
    vorSubsV3(L,b);
    laufzeiten2(3,k)=toc;
    
    tic;
    vorSubsV4(L,b);
    laufzeiten2(4,k)=toc;
end


%% Erstelle linearen Plot der Laufzeiten für dünn besetzte Matrizen

subplot(2,2,3);                         % unterer linker plot
plot(n.^2,laufzeiten2);                 % linearer plot
legend('V1','V2','V3','V4');                 % benenne die Daten
legend('Location','northwest');         % Verschiebe die Legende nach oben links
title('Linearer Plot für dünn besetzte Matrizen')


%% Erstelle logarithmischen Plot der Laufzeiten für voll besetzte Matrizen

subplot(2,2,4);                             % unterer rechter plot
loglog(n.^2,laufzeiten2);                   % doppelt logarithmischer plot
hold on

lastV1= find(isnan(laufzeiten2(1,:)),1)-1;  % letzter nutzbare Wert für V1;
c1 = laufzeiten2(1,lastV1)./n(lastV1).^4;

c3 = laufzeiten2(3,end)./n(end).^3;
c4 = laufzeiten2(4,end)./n(end).^2;


loglog(n.^2,c1*n.^4,':');
loglog(n.^2,c3*n.^3,'--');
loglog(n.^2,c4*n.^2,'--');  
hold off

legend('V1','V2','V3','V4','c_1*n^2','c_3*n^{1.5}','c_4*n^1'); 
legend('Location','northwest');            
title('Doppelt Logarithmischer Plot für dünn besetzte Matrizen')
xlim([n(1)^2,n(end)^2]);  

% Interpretation der Ergebnisse:
%   - V1 hat immer noch eine Laufzeit von O(n^2) während die beiden
%     Vektorisierten Methoden V2 und V3 nur noch ungefähr O(n^1.5) sind.
%   - Der Backslashoperator erreicht sogar das theoretische Maximum für O(n)

