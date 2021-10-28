
for suje=1:2:36
    
S=dir('*.set');
freq=1:42;
SCALE=1024*1.5./freq; %cmor1-1.5
 
 
    
    
EEGS1 = pop_loadset('filename',S(suje).name,'filepath','/Users/unaiv/Documents/NEWGAMMA/');
EEGS1 = pop_chanedit(EEGS1, 'load',{'/Users/unaiv/Documents/NEWGAMMA/canales_laplacian.ced' 'filetype' 'autodetect'});

EEGS2 = pop_loadset('filename',S(suje+1).name,'filepath','/Users/unaiv/Documents/NEWGAMMA/');
EEGS2 = pop_chanedit(EEGS2, 'load',{'/Users/unaiv/Documents/NEWGAMMA/canales_laplacian.ced' 'filetype' 'autodetect'});
 
 
%%%%%Condition 1
 
EEG1S1D = pop_epoch( EEGS1, {  '2'  }, [-2  2], 'newname', 'EEProbe continuous data epochs pruned with ICA pruned with ICA epochs', 'epochinfo', 'yes');
EEG1S1D = pop_rmbase( EEG1S1D, [-100    0]);
L1D=find(max(max(abs(EEG1S1D.data(:,1946:3073,:))))>100)
EEG1S1D = pop_select( EEG1S1D,'nochannel',{'Heog' 'Nose' 'Veog'});
 
EEG1S2D = pop_epoch( EEGS2, {  '2'  }, [-2  2], 'newname', 'EEProbe continuous data epochs pruned with ICA pruned with ICA epochs', 'epochinfo', 'yes');
EEG1S2D = pop_rmbase( EEG1S2D, [-100    0]);
L2D=find(max(max(abs(EEG1S2D.data(:,1946:3073,:))))>100)
EEG1S2D = pop_select( EEG1S2D,'nochannel',{'Heog' 'Nose' 'Veog'});
 
SDATAD=[EEG1S1D.data;EEG1S2D.data];

        
%Surface Laplacian:
 
%compute inter-electrode distances
interelectrodedist=zeros(27);
for chani=1:27
    for chanj=chani+1:27
        interelectrodedist(chani,chanj) = sqrt((EEG1S1D.chanlocs(chani).X-EEG1S1D.chanlocs(chanj).X)^2 + (EEG1S1D.chanlocs(chani).Y-EEG1S1D.chanlocs(chanj).Y)^2 + (EEG1S1D.chanlocs(chani).Z-EEG1S1D.chanlocs(chanj).Z)^2);
    end;
end;
valid_gridpoints = find(interelectrodedist);
% extract XYZ coordinates from EEG structure
X = [EEG1S1D.chanlocs.X];
Y = [EEG1S1D.chanlocs.Y];
Z = [EEG1S1D.chanlocs.Z];
% create G and H matrices
[lap_data,G,H] = laplacian_perrinX(SDATAD(1:27,:,:),X,Y,Z,[],1e-6);
DS1D=lap_data;
 
 
%Non-Phase-Locked
for elec=1:27
    for trial=1:size(DS1D,3)
        %we take out the average to extract the evoked part
        COEFSD1=cwt(DS1D(elec,:,trial)-mean(DS1D(elec,:,:),3),SCALE,'cmor1-1.5');
        COEFSD1_N=cwt(DS1D(elec,:,trial),SCALE,'cmor1-1.5');
        ANGD_S1(:,:,elec,trial)=angle(COEFSD1);
        ANGD_S1_N(:,:,elec,trial)=angle(COEFSD1_N);
    end;
end;
 
if ~isempty(L1D)
    for uu1D=1:length(L1D)
        ANGD_S1(:,:,:,L1D(uu1D))=NaN;
        ANGD_S1_N(:,:,:,L1D(uu1D))=NaN;
    end
end
 
 
% create G and H matrices
[lap_data,G,H] = laplacian_perrinX(SDATAD(28:54,:,:),X,Y,Z,[],1e-6);
DS2D=lap_data;
 
 
%Non-Phase-Locked
for elec=1:27
    for trial=1:size(DS2D,3)
        %we take out the average to extract the evoked part
        COEFSD2=cwt(DS2D(elec,:,trial)-mean(DS2D(elec,:,:),3),SCALE,'cmor1-1.5');
        COEFSD2_N=cwt(DS2D(elec,:,trial),SCALE,'cmor1-1.5');
        ANGD_S2(:,:,elec,trial)=angle(COEFSD2);
        ANGD_S2_N(:,:,elec,trial)=angle(COEFSD2_N);
    end;
end;
 
if ~isempty(L2D)
    for uu2D=1:length(L2D)
        ANGD_S2(:,:,:,L2D(uu2D))=NaN;
        ANGD_S2_N(:,:,:,L2D(uu2D))=NaN;
    end
end
 
%Theta
SANGD1=ANGD_S1(4:8,2561:3073,:,:);
SANGD2=ANGD_S2(4:8,2561:3073,:,:);
 
SANGD1_N=ANGD_S1_N(4:8,2561:3073,:,:);
SANGD2_N=ANGD_S2_N(4:8,2561:3073,:,:);
%Alpha
SANGD3=ANGD_S1(8:13,2561:3073,:,:);
SANGD4=ANGD_S2(8:13,2561:3073,:,:);

SANGD3_N=ANGD_S1_N(8:13,2561:3073,:,:);
SANGD4_N=ANGD_S2_N(8:13,2561:3073,:,:);
%Beta
SANGD5=ANGD_S1(13:25,2561:3073,:,:);
SANGD6=ANGD_S2(13:25,2561:3073,:,:);

SANGD5_N=ANGD_S1_N(13:25,2561:3073,:,:);
SANGD6_N=ANGD_S2_N(13:25,2561:3073,:,:); 
%Gamma
SANGD7=ANGD_S1(38:42,2561:3073,:,:);
SANGD8=ANGD_S2(38:42,2561:3073,:,:);

SANGD7_N=ANGD_S1_N(38:42,2561:3073,:,:);
SANGD8_N=ANGD_S2_N(38:42,2561:3073,:,:);

%Save Theta
fnames1=sprintf('SANGD_1_4_%d',suje)
save(fnames1,'SANGD1')
fnames2=sprintf('SANGD_2_4_%d',suje+1)
save(fnames2, 'SANGD2')

fnames1_N=sprintf('SANGD_N_1_4_%d',suje)
save(fnames1_N,'SANGD1_N')
fnames2_N=sprintf('SANGD_N_2_4_%d',suje+1)
save(fnames2_N, 'SANGD2_N')
%Save Alpha
fnames3=sprintf('SANGD_1_8_%d',suje)
save(fnames3,'SANGD3')
fnames4=sprintf('SANGD_2_8_%d',suje+1)
save(fnames4, 'SANGD4')

fnames3_N=sprintf('SANGD_N_1_8_%d',suje)
save(fnames3_N,'SANGD3_N')
fnames4_N=sprintf('SANGD_N_2_8_%d',suje+1)
save(fnames4_N, 'SANGD4_N')
%Save Beta
fnames5=sprintf('SANGD_1_13_%d',suje)
save(fnames5,'SANGD5')
fnames6=sprintf('SANGD_2_13_%d',suje+1)
save(fnames6, 'SANGD6')

fnames5_N=sprintf('SANGD_N_1_13_%d',suje)
save(fnames5_N,'SANGD5_N')
fnames6_N=sprintf('SANGD_N_2_13_%d',suje+1)
save(fnames6_N, 'SANGD6_N')
%Save Gamma
fnames7=sprintf('SANGD_1_38_%d',suje)
save(fnames7,'SANGD7')
fnames8=sprintf('SANGD_2_38_%d',suje+1)
save(fnames8, 'SANGD8')

fnames7_N=sprintf('SANGD_N_1_38_%d',suje)
save(fnames7_N,'SANGD7_N')
fnames8_N=sprintf('SANGD_N_2_38_%d',suje+1)
save(fnames8_N, 'SANGD8_N')
 
 

clear all 
end


 
 
%Condition 2
 
 
for suje=1:2:36
S=dir('*R.set');
freq=1:42;
SCALE=1024*1.5./freq; %cmor1-1.5
 
     
EEGS1 = pop_loadset('filename',S(suje).name,'filepath','/Users/unaiv/Documents/NEWGAMMA/');
EEGS1 = pop_chanedit(EEGS1, 'load',{'/Users/unaiv/Documents/NEWGAMMA/canales_laplacian.ced' 'filetype' 'autodetect'});

EEGS2 = pop_loadset('filename',S(suje+1).name,'filepath','/Users/unaiv/Documents/NEWGAMMA/');
EEGS2 = pop_chanedit(EEGS2, 'load',{'/Users/unaiv/Documents/NEWGAMMA/canales_laplacian.ced' 'filetype' 'autodetect'});
 
 
EEG1S1C = pop_epoch( EEGS1, {  '4'  }, [-2  2], 'newname', 'EEProbe continuous data epochs pruned with ICA pruned with ICA epochs', 'epochinfo', 'yes');
EEG1S1C = pop_rmbase( EEG1S1C, [-100    0]);
L1C=find(max(max(abs(EEG1S1C.data(:,1946:3073,:))))>100)
EEG1S1C = pop_select( EEG1S1C,'nochannel',{'Heog' 'Nose' 'Veog'});
 
EEG1S2C = pop_epoch( EEGS2, {  '4'  }, [-2  2], 'newname', 'EEProbe continuous data epochs pruned with ICA pruned with ICA epochs', 'epochinfo', 'yes');
EEG1S2C = pop_rmbase( EEG1S2C, [-100    0]);
L2C=find(max(max(abs(EEG1S2C.data(:,1946:3073,:))))>100)
EEG1S2C = pop_select( EEG1S2C,'nochannel',{'Heog' 'Nose' 'Veog'});
 
SDATAC=[EEG1S1C.data;EEG1S2C.data]; 
  
        
%Surface Laplacian:
 
%compute inter-electrode distances
interelectrodedist=zeros(27);
for chani=1:27
    for chanj=chani+1:27
        interelectrodedist(chani,chanj) = sqrt((EEG1S1C.chanlocs(chani).X-EEG1S1C.chanlocs(chanj).X)^2 + (EEG1S1C.chanlocs(chani).Y-EEG1S1C.chanlocs(chanj).Y)^2 + (EEG1S1C.chanlocs(chani).Z-EEG1S1C.chanlocs(chanj).Z)^2);
    end;
end;
valid_gridpoints = find(interelectrodedist);
% extract XYZ coordinates from EEG structure
X = [EEG1S1C.chanlocs.X];
Y = [EEG1S1C.chanlocs.Y];
Z = [EEG1S1C.chanlocs.Z];
% create G and H matrices
[lap_data,G,H] = laplacian_perrinX(SDATAC(1:27,:,:),X,Y,Z,[],1e-6);
DS1C=lap_data;
 
 
%Non-Phase-Locked
for elec=1:27
    for trial=1:size(DS1C,3)
        %we take out the average to extract the evoked part
        COEFSC1=cwt(DS1C(elec,:,trial)-mean(DS1C(elec,:,:),3),SCALE,'cmor1-1.5');
        COEFSC1_N=cwt(DS1C(elec,:,trial),SCALE,'cmor1-1.5');
        ANGC_S1(:,:,elec,trial)=angle(COEFSC1);
        ANGC_S1_N(:,:,elec,trial)=angle(COEFSC1_N);
    end;
end;
 
if ~isempty(L1C)
    for uu1C=1:length(L1C)
        ANGC_S1(:,:,:,L1C(uu1C))=NaN;
        ANGC_S1_N(:,:,:,L1C(uu1C))=NaN;

    end
end
 
 
 
% create G and H matrices
[lap_data,G,H] = laplacian_perrinX(SDATAC(28:54,:,:),X,Y,Z,[],1e-6);
DS2C=lap_data;
 
 
%Non-Phase-Locked
for elec=1:27
    for trial=1:size(DS2C,3)
        %we take out the average to extract the evoked part
        COEFSC2=cwt(DS2C(elec,:,trial)-mean(DS2C(elec,:,:),3),SCALE,'cmor1-1.5');
        COEFSC2_N=cwt(DS2C(elec,:,trial),SCALE,'cmor1-1.5');
        ANGC_S2(:,:,elec,trial)=angle(COEFSC2);
        ANGC_S2_N(:,:,elec,trial)=angle(COEFSC2_N);
    end;
end;
 
if ~isempty(L2C)
    for uu2C=1:length(L2C)
        ANGC_S2(:,:,:,L2C(uu2C))=NaN;
        ANGC_S2_N(:,:,:,L2C(uu2C))=NaN;
    end
end
 
 

%Theta
SANGC1=ANGC_S1(4:8,2561:3073,:,:);
SANGC2=ANGC_S2(4:8,2561:3073,:,:);
 
SANGC1_N=ANGC_S1_N(4:8,2561:3073,:,:);
SANGC2_N=ANGC_S2_N(4:8,2561:3073,:,:);
%Alpha
SANGC3=ANGC_S1(8:13,2561:3073,:,:);
SANGC4=ANGC_S2(8:13,2561:3073,:,:);

SANGC3_N=ANGC_S1_N(8:13,2561:3073,:,:);
SANGC4_N=ANGC_S2_N(8:13,2561:3073,:,:);
%Beta
SANGC5=ANGC_S1(13:25,2561:3073,:,:);
SANGC6=ANGC_S2(13:25,2561:3073,:,:);

SANGC5_N=ANGC_S1_N(13:25,2561:3073,:,:);
SANGC6_N=ANGC_S2_N(13:25,2561:3073,:,:); 
%Gamma
SANGC7=ANGC_S1(38:42,2561:3073,:,:);
SANGC8=ANGC_S2(38:42,2561:3073,:,:);

SANGC7_N=ANGC_S1_N(38:42,2561:3073,:,:);
SANGC8_N=ANGC_S2_N(38:42,2561:3073,:,:);

%Save Theta
fnames1=sprintf('SANGC_1_4_%d',suje)
save(fnames1,'SANGC1')
fnames2=sprintf('SANGC_2_4_%d',suje+1)
save(fnames2, 'SANGC2')

fnames1_N=sprintf('SANGC_N_1_4_%d',suje)
save(fnames1_N,'SANGC1_N')
fnames2_N=sprintf('SANGC_N_2_4_%d',suje+1)
save(fnames2_N, 'SANGC2_N')
%Save Alpha
fnames3=sprintf('SANGC_1_8_%d',suje)
save(fnames3,'SANGC3')
fnames4=sprintf('SANGC_2_8_%d',suje+1)
save(fnames4, 'SANGC4')

fnames3_N=sprintf('SANGC_N_1_8_%d',suje)
save(fnames3_N,'SANGC3_N')
fnames4_N=sprintf('SANGC_N_2_8_%d',suje+1)
save(fnames4_N, 'SANGC4_N')
%Save Beta
fnames5=sprintf('SANGC_1_13_%d',suje)
save(fnames5,'SANGC5')
fnames6=sprintf('SANGC_2_13_%d',suje+1)
save(fnames6, 'SANGC6')

fnames5_N=sprintf('SANGC_N_1_13_%d',suje)
save(fnames5_N,'SANGC5_N')
fnames6_N=sprintf('SANGC_N_2_13_%d',suje+1)
save(fnames6_N, 'SANGC6_N')
%Save Gamma
fnames7=sprintf('SANGC_1_38_%d',suje)
save(fnames7,'SANGC7')
fnames8=sprintf('SANGC_2_38_%d',suje+1)
save(fnames8, 'SANGC8')

fnames7_N=sprintf('SANGC_N_1_38_%d',suje)
save(fnames7_N,'SANGC7_N')
fnames8_N=sprintf('SANGC_N_2_38_%d',suje+1)
save(fnames8_N, 'SANGC8_N')

clear all
 end
 
% Condition 3
 
for suje=1:2:36
S=dir('*R.set');
freq=1:42;
SCALE=1024*1.5./freq; %cmor1-1.5
 
    
EEGS1 = pop_loadset('filename',S(suje).name,'filepath','/Users/unaiv/Documents/NEWGAMMA/');
EEGS1 = pop_chanedit(EEGS1, 'load',{'/Users/unaiv/Documents/NEWGAMMA/canales_laplacian.ced' 'filetype' 'autodetect'});

EEGS2 = pop_loadset('filename',S(suje+1).name,'filepath','/Users/unaiv/Documents/NEWGAMMA/');
EEGS2 = pop_chanedit(EEGS2, 'load',{'/Users/unaiv/Documents/NEWGAMMA/canales_laplacian.ced' 'filetype' 'autodetect'});

 
EEG1S1S = pop_epoch( EEGS1, {  '6'  }, [-2  2], 'newname', 'EEProbe continuous data epochs pruned with ICA pruned with ICA epochs', 'epochinfo', 'yes');
EEG1S1S = pop_rmbase( EEG1S1S, [-100    0]);
L1S=find(max(max(abs(EEG1S1S.data(:,1946:3073,:))))>100)
EEG1S1S = pop_select( EEG1S1S,'nochannel',{'Heog' 'Nose' 'Veog'});
 
EEG1S2S = pop_epoch( EEGS2, {  '6'  }, [-2  2], 'newname', 'EEProbe continuous data epochs pruned with ICA pruned with ICA epochs', 'epochinfo', 'yes');
EEG1S2S = pop_rmbase( EEG1S2S, [-100    0]);
L2S=find(max(max(abs(EEG1S2S.data(:,1946:3073,:))))>100)
EEG1S2S = pop_select( EEG1S2S,'nochannel',{'Heog' 'Nose' 'Veog'});
 
SDATAS=[EEG1S1S.data;EEG1S2S.data];
        
%Surface Laplacian:
 
%compute inter-electrode distances
interelectrodedist=zeros(27);
for chani=1:27
    for chanj=chani+1:27
        interelectrodedist(chani,chanj) = sqrt((EEG1S1S.chanlocs(chani).X-EEG1S1S.chanlocs(chanj).X)^2 + (EEG1S1S.chanlocs(chani).Y-EEG1S1S.chanlocs(chanj).Y)^2 + (EEG1S1S.chanlocs(chani).Z-EEG1S1S.chanlocs(chanj).Z)^2);
    end;
end;
valid_gridpoints = find(interelectrodedist);
% extract XYZ coordinates from EEG structure
X = [EEG1S1S.chanlocs.X];
Y = [EEG1S1S.chanlocs.Y];
Z = [EEG1S1S.chanlocs.Z];
% create G and H matrices
[lap_data,G,H] = laplacian_perrinX(SDATAS(1:27,:,:),X,Y,Z,[],1e-6);
DS1S=lap_data;
 
 
%Non-Phase-Locked
for elec=1:27
    for trial=1:size(DS1S,3)
        %we take out the average to extract the evoked part
        COEFSS1=cwt(DS1S(elec,:,trial)-mean(DS1S(elec,:,:),3),SCALE,'cmor1-1.5');
        COEFSS1_N=cwt(DS1S(elec,:,trial),SCALE,'cmor1-1.5');
        ANGS_S1(:,:,elec,trial)=angle(COEFSS1);
        ANGS_S1_N(:,:,elec,trial)=angle(COEFSS1_N);
    end;
end;
 
if ~isempty(L1S)
    for uu1S=1:length(L1S)
        ANGS_S1(:,:,:,L1S(uu1S))=NaN;
        ANGS_S1_N(:,:,:,L1S(uu1S))=NaN;

    end
end
 
 
 
% create G and H matrices
[lap_data,G,H] = laplacian_perrinX(SDATAS(28:54,:,:),X,Y,Z,[],1e-6);
DS2S=lap_data;
 
 
%Non-Phase-Locked
for elec=1:27
    for trial=1:size(DS2S,3)
        %we take out the average to extract the evoked part
        COEFSS2=cwt(DS2S(elec,:,trial)-mean(DS2S(elec,:,:),3),SCALE,'cmor1-1.5');
        COEFSS2_N=cwt(DS2S(elec,:,trial),SCALE,'cmor1-1.5');
        ANGS_S2(:,:,elec,trial)=angle(COEFSS2);
        ANGS_S2_N(:,:,elec,trial)=angle(COEFSS2_N);
    end;
end;
 
if ~isempty(L2S)
    for uu2S=1:length(L2S)
        ANGS_S2(:,:,:,L2S(uu2S))=NaN;
        ANGS_S2_N(:,:,:,L2S(uu2S))=NaN;
    end
end
 
 

%Theta
SANGS1=ANGS_S1(4:8,2561:3073,:,:);
SANGS2=ANGS_S2(4:8,2561:3073,:,:);
 
SANGS1_N=ANGS_S1_N(4:8,2561:3073,:,:);
SANGS2_N=ANGS_S2_N(4:8,2561:3073,:,:);
%Alpha
SANGS3=ANGS_S1(8:13,2561:3073,:,:);
SANGS4=ANGS_S2(8:13,2561:3073,:,:);

SANGS3_N=ANGS_S1_N(8:13,2561:3073,:,:);
SANGS4_N=ANGS_S2_N(8:13,2561:3073,:,:);
%Beta
SANGS5=ANGS_S1(13:25,2561:3073,:,:);
SANGS6=ANGS_S2(13:25,2561:3073,:,:);

SANGS5_N=ANGS_S1_N(13:25,2561:3073,:,:);
SANGS6_N=ANGS_S2_N(13:25,2561:3073,:,:); 
%Gamma
SANGS7=ANGS_S1(38:42,2561:3073,:,:);
SANGS8=ANGS_S2(38:42,2561:3073,:,:);

SANGS7_N=ANGS_S1_N(38:42,2561:3073,:,:);
SANGS8_N=ANGS_S2_N(38:42,2561:3073,:,:);

%Save Theta
fnames1=sprintf('SANGS_1_4_%d',suje)
save(fnames1,'SANGS1')
fnames2=sprintf('SANGS_2_4_%d',suje+1)
save(fnames2, 'SANGS2')

fnames1_N=sprintf('SANGS_N_1_4_%d',suje)
save(fnames1_N,'SANGS1_N')
fnames2_N=sprintf('SANGS_N_2_4_%d',suje+1)
save(fnames2_N, 'SANGS2_N')
%Save Alpha
fnames3=sprintf('SANGS_1_8_%d',suje)
save(fnames3,'SANGS3')
fnames4=sprintf('SANGS_2_8_%d',suje+1)
save(fnames4, 'SANGS4')

fnames3_N=sprintf('SANGS_N_1_8_%d',suje)
save(fnames3_N,'SANGS3_N')
fnames4_N=sprintf('SANGS_N_2_8_%d',suje+1)
save(fnames4_N, 'SANGS4_N')
%Save Beta
fnames5=sprintf('SANGS_1_13_%d',suje)
save(fnames5,'SANGS5')
fnames6=sprintf('SANGS_2_13_%d',suje+1)
save(fnames6, 'SANGS6')

fnames5_N=sprintf('SANGS_N_1_13_%d',suje)
save(fnames5_N,'SANGS5_N')
fnames6_N=sprintf('SANGS_N_2_13_%d',suje+1)
save(fnames6_N, 'SANGS6_N')
%Save Gamma
fnames7=sprintf('SANGS_1_38_%d',suje)
save(fnames7,'SANGS7')
fnames8=sprintf('SANGS_2_38_%d',suje+1)
save(fnames8, 'SANGS8')

fnames7_N=sprintf('SANGS_N_1_38_%d',suje)
save(fnames7_N,'SANGS7_N')
fnames8_N=sprintf('SANGS_N_2_38_%d',suje+1)
save(fnames8_N, 'SANGS8_N')
 
 
clear all
end
