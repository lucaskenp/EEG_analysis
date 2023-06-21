function [LPCcoef A] = extract_LPC_features(x,fs,p)

epochs_number = length(x(1,:))/(fs*2); %Épocas de 2 segundos
fprintf("Epochs number %d\n",epochs_number);
channels_number = length(x(:,1)); %23 canais
fprintf("Channels number %d\n",channels_number);
LPCcoef=[]; %matriz com os vetores de features
Xt = []; %vetor de coeficientes com 23 canais, concatenando 3 Épocas

for i=1:epochs_number
    begin_ = i*fs;
    end_ = (i+1)*fs;

    for j=1:channels_number
      epoch = x(j,begin_:end_);
      a = aryule(epoch,p);
      len_a = length(a);
      a = a(2:len_a);

      Xt = [a Xt]; %cria um vetor de coeficientes para os 23 canais, em 2s
    end
    if(mod(i,3) == 0) %concatena vetores de coeficientes de 3 Épocas
    Xt = Xt';
    LPCcoef = horzcat(LPCcoef,Xt);
    Xt = [];
    end
end

end
