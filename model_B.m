%gera o modelo de distribuição dos dados pelo centroide e visualiza pelo histograma
clear;clc;

load('features_nonSeizure.mat');
load('features_seizure.mat');

%calcula centroides e distancias
[dist_LPCns, centroid_LPCns, mean_dist_LPCns, std_dist_LPCns, max_dist_LPCns, min_dist_LPCns, threshold_LPCns] = centroid(LPC_nonSeizure);
[dist_PSDns, centroid_PSDns, mean_dist_PSDns, std_dist_PSDns, max_dist_PSDns, min_dist_PSDns, threshold_PSDns] = centroid(PSD_nonSeizure);
[dist_LPCs, centroid_LPCs, mean_dist_LPCs, std_dist_LPCs, max_dist_LPCs, min_dist_LPCs, threshold_LPCs] = centroid(LPC_Seizure);
[dist_PSDs, centroid_PSDs, mean_dist_PSDs, std_dist_PSDs, max_dist_PSDs, min_dist_PSDs, threshold_PSDs] = centroid(PSD_Seizure);

%%
##%histograma das distancias aos centroides: LPC
##figure
##hold on;
##hist(dist_LPCns);
####hist(dist_LPCns,'Normalization','pdf');
####hist(dist_LPCs,20,'Normalization','pdf','FaceColor','r');
##title('Histograma das distancias euclidianas normalizadas aos respectivos centroides. Atributos: LPC')
##legend('Nao-Convulsivo','Convulsivo')
##hold off;
##%%
##%histograma das distancias aos centroides: PSD
##figure
##hold on;
##hist(dist_PSDns,'Normalization','pdf');
##hist(dist_PSDs,'Normalization','pdf','FaceColor','r');
##title('Histograma das distancias euclidianas normalizadas aos respectivos centroides. Atributos PSD')
##legend('Nao-Convulsivo','Convulsivo')
##hold off;

%%
%classificacao LPC
[LPC_results,lpc_conf] = classifier_centroid_seizure(LPC_nonSeizure,LPC_Seizure,20,0.7)

title('Distancias LPC ao centroide nao-convulsivo')
ylabel('Distancia Euclidiana Normalizada')
legend('Nao-Convulsivo','Limiar')

%%
%classificacao PSD
[PSD_results,psd_conf] = classifier_centroid_seizure(PSD_nonSeizure,PSD_Seizure,20,0.7)

title('Distancias PSD ao centroide nao-convulsivo')
ylabel('Distancia Euclidiana Normalizada');
legend('Nao-Convulsivo','Limiar')
