%Calcula o centroide do conjunto de dados e as distancias euclidianas normalizadas de cada vetor a
%esse centroide. 
%Calcula também a matriz de covariancia (C) e o limiar de classificação
%(threshold)

function [dist2, centroid, mean_dist, std_dist, max_dist, min_dist, threshold] = centroid(coef)

% dist = bsxfun(@minus, coef, centroid);
% dist2 = sqrt(sum(dist.*dist));
% tol = 0.95;
% coef2 = coef;
% [coef L V Q M] = myPCA3(coef,tol);
% size(Q);

centroid = mean(coef,2);


%  C=cov(coef');
%  invC=inv(C);


dist2 = [];
for i = 1:length(coef(1,:))
    %d = norm(centroid - coef(:,i));
    d2E = (centroid - coef(:,i))'*(centroid - coef(:,i));
    %d2M = (centroid - coef(:,i))'*invC*(centroid - coef(:,i));
    %dist2 = [dist2 d2E];    
    
    dist2 = [dist2 d2E];
    
end

threshold = prctile(dist2,95);

Raio_NS = sqrt(threshold); % ???????

mean_dist = mean(dist2);
std_dist = std(dist2);
max_dist = max(dist2);
min_dist = min(dist2);

dist2 = (dist2 - mean_dist)/std_dist;




