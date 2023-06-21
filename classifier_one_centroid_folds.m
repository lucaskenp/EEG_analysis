function [results,best_conf] = classifier_one_centroid_folds(X_ns,X_s,folds)
%trata os dados de teste e treino
% executa a predição diversas vezes e gera as estatísticas de desempenho

size_ns = size(X_ns);
size_s = size(X_s);

step = floor(size_ns(2)/folds);
fprintf("Tamanho do vetor de teste: " + step);
acuracia = [];
sensibilidade = [];
especificidade = [];
eficiencia = [];
matthews = [];
best_efi = 0;

number_seizures = size_s(2)

for i=1:folds
%separação dos dados de teste e treino   
%[X_train, y_train, X_test, y_test ] = train_test_split(X_ns,y,p);
inicio = (i-1)*step + 1;
fim = i*step;

X_test = X_ns(:,inicio:fim);

if(i==1)
X_train1 = [];
else
X_train1 = X_ns(:,1:inicio-1);
end

if(i==folds)
X_train2 = [];    
else
X_train2 = X_ns(:,fim+1:end);
end

X_train = horzcat(X_train1,X_train2);
y_test = ones(1,length(X_test(1,:)))*(-1);

%treino
[dist, centr, mean_dist, std_dist, max_dist, min_dist, threshold] = centroid(X_train);

%teste
ys = ones(1,size_s(2));
y_test = [y_test ys];
X_test = horzcat(X_test,X_s);
I = randperm(length(y_test));
X_test = X_test(:,I);
y_test = y_test(:,I);

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

