function [ matrice_cricche, N_cicli, numero_cricca] = Paris( matrice_cricche,N_cicli )

%Paris Produce l'aumento della lunghezza delle cricche secondo la legge di
%      Paris. Si arresta quando una trabecola fallisce (cond 1 -> sforzo
%      locale > di sforzo critico; cond 2 -> lunghezza cricca > spessore
%      trabecola) o quando una cricca raggiunge metà dello spessore della
%      trabecola corrispondente. 
%   sigma_medio() riceve: coordinate e spessore trabecola e restituisce lo
%   sforzo medio in direzione dell'asse di carico
%
% Input: matrice_cricche (vedi funz Crea_cricche per definizione)
%        N_cicli numero di cicli da cui parte l'analisi
%
% Output: matrice_cricche aggiornata
%         N_cicli aggiornati
%         coord_trabecola restituisce le coordinate della trabecola per cui
%         si è interrotto il ciclo
%         stato_trabecola restituisce il tipo di avvenimento per cui si è
%         interrotto il ciclo (trabecola inattivata o trabecola inattivata
%         a metà)


dK = @(c,dsigma) (pi*c)^(1/2) * dsigma; % funzione che descrive il fattore di intensificazione degli sforzi
C = ; %parametro del materiale
m = ; %parametro del materiale
flag=0;

while N_cicli<10e6
    
    N_cicli = N_cicli + 1;
    
    for i=1:size(matrice_cricche,1)
        
        if matrice_cricche(i,7) ~= 2 || matrice_cricche(i,7) ~= 3
            
            sigma = Sforzo_medio(matrice_cricche(i,:),matrice_cricche(i,6)/2); %l'area su cui si calcola lo sforzo medio è la metà dello spessore della trabecola
            k = dK( matrice_cricche(i,5), 2*sigma); % il Delta_sigma è assunto pari a 2 volte lo sforzo medio
            k_thresold = ; %parametro locale
            k1c = ; %parametro locale
            
            if k_thresold < k(i) < k1c 

                matrice_cricche(i,5) = matrice_cricche(i,5) + C*k(i)^m ; %incrementa lunghezza cricca

                if matrice_cricche(i,5) >= 0.5*matrice_cricche(i,4) && matrice_cricche(i,7)==0   % se la lunghezza della cricca raggiunge la metà dello spessore minimo della trabecola e non è già stata modificata si rielabora la mesh  

                    matrice_cricche(i,7) = 1;
                    numero_cricca = i;
                    flag=1;

                elseif  matrice_cricche(i,5) >= matrice_cricche(i,4) % condizione implicita && matrice_cricche(i,7)==1 - se la trabecola è già stata modificata deve verificarsi la condizone di fallimento

                    matrice_cricche(i,7) = 2;
                    numero_cricca = i;
                    flag=1;

                end

            elseif k(i) > k1c % se lo sforzo locale supera lo sforzo critico la trabecola fallisce immediatamente

                matrice_cricche(i,7) = 3;
                numero_cricca = i;
                flag=1;

            end

        end
    end
    
    if flag==1
        return
    end
    
end

end

