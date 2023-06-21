function [dists] = calc_distances(x,centroid)
% calcula as distancias de um vetor de dados para um dado centroide
dists = [];

for i=1:length(x(1,:))
    d = (centroid - x(:,i))'*(centroid - x(:,i));
    dists = [dists d];  
    
end

end

