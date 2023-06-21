function [CH, DB] = find_K(X,max)
%acha o k ótimo para um conjunto de dados pelos indices DB e Silhouette
meas = X';

clust = zeros(size(meas,1),max);
for i=1:max
clust(:,i) = kmeans(meas,i+1,'MaxIter',10000);
end

DB = evalclusters(meas,clust,'DaviesBouldin');
CH = evalclusters(meas,clust,'CalinskiHarabasz');
%SI = 0;
%SI = evalclusters(meas,clust,'silhouette');
%SI = evalclusters(meas,'kmeans','silhouette','kList',[1:max])


end

