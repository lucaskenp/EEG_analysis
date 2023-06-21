%cria conjunto de dados de teste
%features: PSD e LPC

%%1
[header, data] = edfread('C:\Users\Cabral\Documents\TCC\data\chb01\seizure\chb01_03.edf');
fprintf("1 selecting seizures...\n");
[seizure_data,non_seizure_data] = select_seizure(data,256,2996,3036);
fprintf("1 Extracting features...\n");

PSD_seizure = extractWelchFeatures(seizure_data,256);
PSD_non_seizure = extractWelchFeatures(non_seizure_data,256);
PSD_test = horzcat(PSD_seizure,PSD_non_seizure);

size_s = size(PSD_seizure);
size_ns = size(PSD_non_seizure);
y1 = ones(1,size_s(2));
y2 = ones(1,size_ns(2));
y = horzcat(y1,y2);

I = randperm(length(y));
PSD_test = PSD_test(:,I);
y_test = y(:,I);

%Seizure Start Time: 2996 seconds
%Seizure End Time: 3036 seconds




%%

save('test.mat','PSD_test','y_test');

