%cria conjunto de dados de eeg com crise convulsiva
%features: PSD e LPC

%%1
[header, data] = edfread('C:\Users\Cabral\Documents\TCC\data\chb05\seizure\chb05_06.edf');
fprintf("1 selecting seizures...\n");
seizure_data = select_seizure(data,256,417,532);
fprintf("1 Extracting features...\n");
LPC_seizure = extract_LPC_features(seizure_data,256,4);
PSD_seizure = extractWelchFeatures(seizure_data,256);
%%
%2
[header, data] = edfread('C:\Users\Cabral\Documents\TCC\data\chb05\seizure\chb05_13.edf');
fprintf("2 selecting seizures...\n");
seizure_data = select_seizure(data,256,1086,1196);
fprintf("2 Extracting features...\n");
LPC_seizure = extract_LPC_features(seizure_data,256,4);
PSD_seizure = extractWelchFeatures(seizure_data,256);

%%3
[header, data] = edfread('C:\Users\Cabral\Documents\TCC\data\chb05\seizure\chb05_16.edf');
fprintf("3 selecting seizures...\n");
seizure_data = select_seizure(data,256,2317,2413);
fprintf("3 Extracting features...\n");
LPC_seizure1 = extract_LPC_features(seizure_data,256,4);
PSD_seizure1 = extractWelchFeatures(seizure_data,256);
LPC_seizure = horzcat(LPC_seizure,LPC_seizure1);
PSD_seizure = horzcat(PSD_seizure,PSD_seizure1);

%%4
[header, data] = edfread('C:\Users\Cabral\Documents\TCC\data\chb05\seizure\chb05_17.edf');
fprintf("4 selecting seizures...\n");
seizure_data = select_seizure(data,256,2451,2571);
fprintf("4 Extracting features...\n");
LPC_seizure1 = extract_LPC_features(seizure_data,256,4);
PSD_seizure1 = extractWelchFeatures(seizure_data,256);
LPC_seizure = horzcat(LPC_seizure,LPC_seizure1);
PSD_seizure = horzcat(PSD_seizure,PSD_seizure1);

%%5
[header, data] = edfread('C:\Users\Cabral\Documents\TCC\data\chb05\seizure\chb05_22.edf');
fprintf("5 selecting seizures...\n");
seizure_data = select_seizure(data,256,2348,2465);
fprintf("5 Extracting features...\n");
LPC_seizure1 = extract_LPC_features(seizure_data,256,4);
PSD_seizure1 = extractWelchFeatures(seizure_data,256);
LPC_seizure = horzcat(LPC_seizure,LPC_seizure1);
PSD_seizure = horzcat(PSD_seizure,PSD_seizure1);

%%

save('features_seizure.mat','LPC_seizure', 'PSD_seizure');

