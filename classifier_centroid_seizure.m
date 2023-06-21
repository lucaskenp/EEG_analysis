function [results,best_conf] = classifier_centroid_seizure(X_ns,X_s,epochs,p)
% classifica pelo limiar de distancia ao centroide convulsivo
% trata os dados de teste e treino
% executa a predicao diversas vezes e gera as estatisticas de desempenho

size_ns = size(X_ns);
size_s = size(X_s);
y = ones(1,size_s(2));
y2 = ones(1,size_ns(2))*(-1);

acuracia = [];
sensibilidade = [];
especificidade = [];
eficiencia = [];
matthews = [];
best_efi = 0;


for i=1:epochs
%separados dados de teste e treino
[X_train, y_train, X_test, y_test ] = train_test_split(X_s,y,p);
[X_tr, y_tr, X_te, y_te ] = train_test_split(X_ns,y2,0.99);

number_seizures = length(y_test);

%treino
[dist, centr, mean_dist, std_dist, max_dist, min_dist, threshold] = centroid(X_train);

%teste
y_test = [y_test y_te];
X_test = horzcat(X_test,X_te);
I = randperm(length(y_test));
X_test = X_test(:,I);
y_test = y_test(:,I);

if(i==1)
    test_size = length(y_test)
    number_seizures
end

[conf, acu, sen, esp, efi, mat] = predict_one_centroid_s(X_test,centr,max_dist,y_test);

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

%visualizacao
dist = calc_distances(X_test,centr);
viz_classification(dist,y_test,threshold)

end

