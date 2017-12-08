function stampa (file, coordinate, incidenze, nset_sup)
% Stampo il file per ABAQUS in colonne 
% (e' un file unico contenente le tabelle)

% Scrive la tabella delle coordinate
[m n]=size(coordinate);
fprintf(file,'*Node\n');

for i=1:m
    fprintf(file,'%d, %12.8f, %12.8f, %12.8f  \n ',coordinate(i,1),coordinate(i,2),coordinate(i,3),coordinate(i,4));
end

% Scrive la tabella delle incidenze sotto quella delle coordinate
    
[m n]=size(incidenze);

fprintf(file,'*Element, type=C3D8\n');

for i=1:m      
    fprintf(file,'%d, %d, %d, %d, %d, %d, %d, %d, %d  \n ',incidenze(i,1),incidenze(i,2),incidenze(i,3),incidenze(i,4),...
        incidenze(i,5),incidenze(i,6),incidenze(i,7),incidenze(i,8), incidenze(i,9));
end

% Scrive i Node set di superficie sotto la tabella delle incidenze�
facce = fieldnames(nset_sup);                                               % Serve per individuare i campi della struct
for i = 1:length(facce)
    nodi_sup=nset_sup.(facce{i});                                           % Vettore dei nodi della superficie i
    g=size(nodi_sup);                                                       % g = Lunghezza del node set 
    fprintf(file,'*Nset, nset=%s\n',facce{i});
    f=1;                                                                    % f = Numero di riga
    for j=1:g(1)  
        fprintf(file,'%d', nodi_sup(j));
        if (j == 13*f) || (j==g(1))                                         % Se arriva al 13� nodo sulla riga o se arriva alla fine di nodi_sup
        fprintf(file,'\n');                                                  
        f=f+1;                                                              % Si va a capo 
    
        else 
            fprintf(file,',');
        end
    end
  
end

end
    