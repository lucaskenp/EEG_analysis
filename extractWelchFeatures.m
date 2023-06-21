function [psd] = extractWelchFeatures(x,fs)

epochs_number = length(x(1,:))/(fs*2); %Épocas de 2 segundos
channels_number = length(x(:,1)); %23 canais
psd=[];

Xt = [];

for i=1:epochs_number
    begin_ = i*fs;
    end_ = (i+1)*fs;

    for j=1:channels_number
      epoch = x(j,begin_:end_);
      a = pwelch(epoch,gausswin(128),[ ],256,fs);
      a = 10*log10(a);

      a = a'; %collum to row
      M = zeros(1,8); %frequency bands

      M(1) = mean(a(1:3));
      M(2) = mean(a(4:6));
      M(3) = mean(a(7:9));
      M(4) = mean(a(10:12));
      M(5) = mean(a(13:15));
      M(6) = mean(a(16:18));
      M(7) = mean(a(19:21));
      M(8) = mean(a(22:25));

%       for k=1:8
%       M(1,k) = mean(a(k));
%       end

%       aat = a'

    Xt = [M Xt]; %cria um vetor de coeficientes para os 23 canais, em 2s

    end
    if(mod(i,3) == 0) %concatena vetores de coeficientes de 3 Épocas
    Xt = Xt';
    psd = horzcat(psd,Xt);
    Xt = [];
    end
end

end
