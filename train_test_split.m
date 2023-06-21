function [ X_train y_train X_test y_test ] = train_test_split(X,y,p)
%divide os dados em treino e teste
n = size(X);
I = randperm(n(2));
X = X(:,I);
Itr = floor(p*n(2));
X_train = X(:,1:Itr);
y_train = y(:,1:Itr);
X_test = X(:,Itr+1:end);
y_test = y(:,Itr+1:end);

end

