function [results] = classifier_one_centroid(X_train,X_test,y_test,epochs)
%trata os dados de teste e treino
% executa a predição diversas vezes e gera as estatísticas de desempenho

acuracia = [];
sensibilidade = [];
especificidade = [];
eficiencia = [];
best_efi = 0;
matthews = [];

centr = 0;
threshold = 0;

for i=1:epochs

%treino
[~, centr, ~, ~, ~, ~, threshold] = centroid(X_train);


[conf, acu, sen, esp, efi, mat] = predict_one_centroid(X_test,centr,threshold,y_test);

acuracia = [acuracia acu];
sensibilidade = [sensibilidade sen];
especificidade = [especificidade esp];
eficiencia = [eficiencia efi];
matthews = [matthews mat];

if(efi > best_efi)
    best_conf = conf;
end

end
max_vector = [max(acuracia); max(sensibilidade); max(especificidade); max(eficiencia); max(matthews)];
min_vector = [min(acuracia); min(sensibilidade); min(especificidade); min(eficiencia); min(matthews)];
mean_vector = [mean(acuracia); mean(sensibilidade); mean(especificidade); mean(eficiencia); mean(matthews)];
std_vector = [std(acuracia); std(sensibilidade); std(especificidade); std(eficiencia); std(matthews)];

results = horzcat(max_vector,min_vector,mean_vector,std_vector);

%visualização
dist = calc_distances(X_test,centr);
viz_classification(dist,y_test,threshold)

end

