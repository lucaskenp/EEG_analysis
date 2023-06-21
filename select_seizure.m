%retorna a matriz a partir do tempo inicial especificado até o tempo final
function [seizures,non_seizures] = select_seizure(x,fs,t_begin,t_end)
first_sample = t_begin*fs;
last_sample = t_end*fs;
seizures = x(:,(first_sample:last_sample));
B = x(:,1:first_sample-1);
C = x(:,last_sample+1:end);
non_seizures = horzcat(B,C);
end
