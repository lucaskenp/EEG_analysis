function [min_dists] = calc_distances_clusters(x,clusters)
% calcula as distancias de um vetor de dados para um dado centroide
min_dists = zeros(1,length(x(1,:)));

for i=1:length(x(1,:))
    dists = zeros(1,length(clusters(1,:)));
    
    for j = 1:length(clusters(1,:)) 
    d = (clusters(:,j) - x(:,i))'*(clusters(:,j) - x(:,i));
    dists(j) = d; 
    end
    m = min(dists);
    min_dists(i) = m;
    
end

end

