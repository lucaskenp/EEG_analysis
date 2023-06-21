function [conf_matrix, acuracia, sensibilidade, especificidade, eficiencia, matthews] = predict_one_centroid_s(x,centroid,threshold,truth)
%classifica um vetor de acordo com o limiar de uma distancia a um centroide

dist = calc_distances(x,centroid);
prediction = zeros(1,length(dist));

VP = 0;
VN = 0;
FN = 0;
FP = 0;

for i = 1:length(dist)
        
    if(dist(:,i)<threshold)
        prediction(i) = 1; %seizure
    else
        prediction(i) = -1; %non-seizure
    end
    
    if(prediction(i) == 1 && truth(i) == 1)
        VP = VP+1;
    elseif(prediction(i) == 1 && truth(i) == -1)
        FP = FP + 1;
    elseif(prediction(i) == -1 && truth(i) == 1)
        FN = FN + 1;
    elseif(prediction(i) == -1 && truth(i) == -1)
        VN = VN + 1;
    end
    
end

acuracia = (VP+VN)/length(dist);
sensibilidade = VP/(VP+FN);
especificidade = VN/(VN + FP);
eficiencia = (sensibilidade + especificidade)/2;
matthews = (VP*VN-FP*FN)/sqrt((VP+FP)*(VP+FN)*(VN+FP)*(VN+FN));
conf_matrix = [VP FP; FN VN];





end

