%gera o modelo de distribuição dos dados por quantização vetorial
%utilizando k-means
clear, clc
load('features_nonSeizure.mat');
load('features_seizure.mat');
%%
%achando o K ótimo determinado pelos indices Davies-Bouldin e Calinski-Harabasz
[CH_PSD, DB_PSD] = find_K(PSD_nonSeizure,25)
[CH_LPC, DB_LPC] = find_K(LPC_nonSeizure,25)

%%
figure
plot(CH_PSD);

figure
plot(DB_PSD);

figure
plot(CH_LPC);

figure
plot(DB_LPC);


%%
K_PSD = DB_PSD.OptimalK %3
K_LPC = DB_LPC.OptimalK %2
epocas = 20
p = 0.98 %0.995
%%
%histograma distancias minimas aos clusters LPC
LPC_ns = LPC_nonSeizure';
[~,clusters_lpc_ns] = kmeans(LPC_ns,K_LPC,'MaxIter',10000);
clusters_lpc_ns = clusters_lpc_ns';
dists_LPC_ns = calc_distances_clusters(LPC_nonSeizure,clusters_lpc_ns);
dists_LPC_s = calc_distances_clusters(LPC_seizure,clusters_lpc_ns);

figure
hold on;
histogram(dists_LPC_ns,'Normalization','pdf');
histogram(dists_LPC_s,'Normalization','pdf','FaceColor','r');
title('Histograma das menores distâncias euclidianas aos centróides não-convulsivos. Atributos LPC')
legend('Não-Convulsivo','Convulsivo')
hold off;

%%
%histograma distancias minimas aos clusters LPC
PSD_ns = PSD_nonSeizure';
[~,clusters_psd_ns] = kmeans(PSD_ns,K_PSD,'MaxIter',10000);
clusters_psd_ns = clusters_psd_ns';
dists_PSD_ns = calc_distances_clusters(PSD_nonSeizure,clusters_psd_ns);
dists_PSD_s = calc_distances_clusters(PSD_seizure,clusters_psd_ns);

figure
hold on;
histogram(dists_PSD_ns,'Normalization','pdf');
histogram(dists_PSD_s,'Normalization','pdf','FaceColor','r');
title('Histograma das menores distâncias euclidianas aos centróides não-convulsivos. Atributos PSD')
legend('Não-Convulsivo','Convulsivo')
hold off;

%%
fprintf("LPC")
[LPC_results,lpc_conf] =  classifier_vector_quantization(LPC_nonSeizure,LPC_seizure,epocas,p,K_LPC)
title('Distancias mínimas LPC ao protótipos não-convulsivo')
ylabel('Distância Euclidiana')
legend('Não-Convulsivo','Limiar')

%%
fprintf("PSD")
[PSD_results,psd_conf] =  classifier_vector_quantization(PSD_nonSeizure,PSD_seizure,epocas,p,K_PSD)
title('Distancias mínimas PSD ao protótipos não-convulsivo')
ylabel('Distância Euclidiana')
legend('Não-Convulsivo','Limiar')



