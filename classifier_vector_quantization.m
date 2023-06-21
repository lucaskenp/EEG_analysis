function [results,best_conf] = classifier_vector_quantization(X_ns,X_s,epochs,p,k)
%trata os dados de teste e treino
% executa a predição diversas vezes e gera as estatísticas de desempenho

size_ns = size(X_ns);
size_s = size(X_s);
y = ones(1,size_ns(2))*(-1);

acuracia = zeros(epochs,1);
sensibilidade = zeros(epochs,1);
especificidade = zeros(epochs,1);
eficiencia = zeros(epochs,1);
matthews = zeros(epochs,1);
best_efi = 0;
y_train = [];
y_test = [];
for i=1:epochs
i   
%separação dos dados de teste e treino   
[X_train, y_train, X_test, y_test ] = train_test_split(X_ns,y,p);

%treino
X_t = X_train';

[idx,C] = kmeans(X_t,k,'MaxIter',10000);
C = C';
min_dists = calc_distances_clusters(X_train,C);
threshold = prctile(min_dists,95);

%teste
ys = ones(1,size_s(2));
y_test = [y_test ys];
X_test = horzcat(X_test,X_s);
I = randperm(length(y_test));
X_test = X_test(:,I);
y_test = y_test(:,I);

[conf, acu, sen, esp, efi, mat] = predict_multiple_centroids(X_test,C,threshold,y_test);

acuracia(i) = acu;
sensibilidade(i) = sen;
especificidade(i) = esp;
eficiencia = efi;
matthews(i) = mat;

if(efi > best_efi)
    best_conf = conf;
end

end
max_vector = [max(acuracia); max(sensibilidade); max(especificidade); max(eficiencia); max(matthews)];
min_vector = [min(acuracia); min(sensibilidade); min(especificidade); min(eficiencia); min(matthews)];
mean_vector = [mean(acuracia); mean(sensibilidade); mean(especificidade); mean(eficiencia); mean(matthews)];
std_vector = [std(acuracia); std(sensibilidade); std(especificidade); std(eficiencia); std(matthews)];

results = horzcat(max_vector,min_vector,mean_vector,std_vector);

dados_treino = length(y_train)
dados_teste = length(y_test)
dados_seizure = size_s(2)
teste_razao = dados_seizure/dados_teste

%visualização
dist = calc_distances_clusters(X_test,C);
viz_classification(dist,y_test,threshold);

end

