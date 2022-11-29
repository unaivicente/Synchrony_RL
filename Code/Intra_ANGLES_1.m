

for suje=1:36
S=dir('*R.set');
freq=1:42;
SCALE=1024*1.5./freq; %cmor1-1.5

    
    
EEG = pop_loadset('filename',S(suje).name,'filepath','/Users/unaiv/Desktop/Analysis 2/Data');
EEG = pop_chanedit(EEG, 'load',{'/Users/unaiv/Desktop/Analysis 2/Data/canales_laplacian.ced' 'filetype' 'autodetect'});

%%%%%CONDITION 1

%Extraer datos
EEG1 = pop_epoch( EEG, {  '2'  }, [-2  2], 'newname', 'EEProbe continuous data epochs pruned with ICA pruned with ICA epochs', 'epochinfo', 'yes');
EEG1 = pop_rmbase( EEG1, [-100    0]);
L1=find(max(max(abs(EEG1.data(:,1946:3073,:))))>100)


EEG1 = pop_select( EEG1,'nochannel',{'Heog' 'Nose' 'Veog'});


%Surface Laplacian:

%compute inter-electrode distances
interelectrodedist=zeros(EEG1.nbchan);
for chani=1:EEG1.nbchan
    for chanj=chani+1:EEG1.nbchan
        interelectrodedist(chani,chanj) = sqrt( (EEG1.chanlocs(chani).X-EEG1.chanlocs(chanj).X)^2 + (EEG1.chanlocs(chani).Y-EEG1.chanlocs(chanj).Y)^2 + (EEG1.chanlocs(chani).Z-EEG1.chanlocs(chanj).Z)^2);
    end;
end;
valid_gridpoints = find(interelectrodedist);
% extract XYZ coordinates from EEG structure
X = [EEG1.chanlocs.X];
Y = [EEG1.chanlocs.Y];
Z = [EEG1.chanlocs.Z];
% create G and H matrices
[lap_data,G,H] = laplacian_perrinX(EEG1.data,X,Y,Z,[],1e-6);
EEG1.data=lap_data;


%Non-Phase-Locked
for elec=1:27
    for trial=1:size(EEG1.data,3)
        %quitamos la media para extraer la parte evocada
        COEFS1=cwt(EEG1.data(elec,:,trial)-mean(EEG1.data(elec,:,:),3),SCALE,'cmor1-1.5');
        COEFS1_N=cwt(EEG1.data(elec,:,trial),SCALE,'cmor1-1.5');
        ANGD(:,:,elec,trial)=angle(COEFS1);
        ANGD_N(:,:,elec,trial)=angle(COEFS1_N);
        
    end;
end;

if ~isempty(L1)
    for uu1=1:length(L1)
        ANGD(:,:,:,L1(uu1))=NaN;
        ANGD_N(:,:,:,L1(uu1))=NaN;
    end
end



%%%%%CONDITION 2

%Extraer datos
EEG2 = pop_epoch( EEG, {  '4'  }, [-2  2], 'newname', 'EEProbe continuous data epochs pruned with ICA pruned with ICA epochs', 'epochinfo', 'yes');
EEG2 = pop_rmbase( EEG2, [-100    0]);
L2=find(max(max(abs(EEG2.data(:,1946:3073,:))))>100)

EEG2 = pop_select( EEG2,'nochannel',{'Heog' 'Nose' 'Veog'});

%Surface Laplacian:


%compute inter-electrode distances
interelectrodedist=zeros(EEG2.nbchan);
for chani=1:EEG2.nbchan
    for chanj=chani+1:EEG2.nbchan
        interelectrodedist(chani,chanj) = sqrt( (EEG2.chanlocs(chani).X-EEG2.chanlocs(chanj).X)^2 + (EEG2.chanlocs(chani).Y-EEG2.chanlocs(chanj).Y)^2 + (EEG2.chanlocs(chani).Z-EEG2.chanlocs(chanj).Z)^2);
    end;
end;
valid_gridpoints = find(interelectrodedist);
% extract XYZ coordinates from EEG structure
X = [EEG2.chanlocs.X];
Y = [EEG2.chanlocs.Y];
Z = [EEG2.chanlocs.Z];
% create G and H matrices
[lap_data,G,H] = laplacian_perrinX(EEG2.data,X,Y,Z,[],1e-6);
EEG2.data=lap_data;


%Non-Phase-Locked
for elec=1:27
    for trial=1:size(EEG2.data,3)
        %quitamos la media para extraer la parte evocada
        COEFS2=cwt(EEG2.data(elec,:,trial)-mean(EEG2.data(elec,:,:),3),SCALE,'cmor1-1.5');
        COEFS2_N=cwt(EEG2.data(elec,:,trial),SCALE,'cmor1-1.5');
        ANGC(:,:,elec,trial)=angle(COEFS2);
        ANGC_N(:,:,elec,trial)=angle(COEFS2_N);
    end;
end;

if ~isempty(L2)
    for uu2=1:length(L2)
        ANGC(:,:,:,L2(uu2))=NaN;
        ANGC_N(:,:,:,L2(uu2))=NaN;
    end
end

%%%%%CONDITION 3

%Extraer datos
EEG3 = pop_epoch( EEG, {  '6'  }, [-2  2], 'newname', 'EEProbe continuous data epochs pruned with ICA pruned with ICA epochs', 'epochinfo', 'yes');
EEG3 = pop_rmbase( EEG3, [-100    0]);
L3=find(max(max(abs(EEG3.data(:,1946:3073,:))))>100)

EEG3 = pop_select( EEG3,'nochannel',{'Heog' 'Nose' 'Veog'});

%Surface Laplacian

%compute inter-electrode distances
interelectrodedist=zeros(EEG3.nbchan);
for chani=1:EEG3.nbchan
    for chanj=chani+1:EEG3.nbchan
        interelectrodedist(chani,chanj) = sqrt( (EEG3.chanlocs(chani).X-EEG3.chanlocs(chanj).X)^2 + (EEG3.chanlocs(chani).Y-EEG3.chanlocs(chanj).Y)^2 + (EEG3.chanlocs(chani).Z-EEG3.chanlocs(chanj).Z)^2);
    end;
end;
valid_gridpoints = find(interelectrodedist);
% extract XYZ coordinates from EEG structure
X = [EEG3.chanlocs.X];
Y = [EEG3.chanlocs.Y];
Z = [EEG3.chanlocs.Z];
% create G and H matrices
[lap_data,G,H] = laplacian_perrinX(EEG3.data,X,Y,Z,[],1e-6);
EEG3.data=lap_data;


%Non-Phase-Locked
for elec=1:27
    for trial=1:size(EEG3.data,3)
        %quitamos la media para extraer la parte evocada
        COEFS3=cwt(EEG3.data(elec,:,trial)-mean(EEG3.data(elec,:,:),3),SCALE,'cmor1-1.5');
        COEFS3_N=cwt(EEG3.data(elec,:,trial),SCALE,'cmor1-1.5');
        ANGS(:,:,elec,trial)=angle(COEFS3);
        ANGS_N(:,:,elec,trial)=angle(COEFS3_N);

    end;
end;

if ~isempty(L3)
    for uu3=1:length(L3)
        ANGS(:,:,:,L3(uu3))=NaN;
        ANGS_N(:,:,:,L3(uu3))=NaN;
    end
end

%hacemos un squeeze para limitar frecuencia 10 y tiempo de 0 a 1s
SANGD4=squeeze(ANGD(4:8,2049:2561,:,:));
SANGC4=squeeze(ANGC(4:8,2049:2561,:,:));
SANGS4=squeeze(ANGS(4:8,2049:2561,:,:));

SANGD8=squeeze(ANGD(8:12,2049:2561,:,:));
SANGC8=squeeze(ANGC(8:12,2049:2561,:,:));
SANGS8=squeeze(ANGS(8:12,2049:2561,:,:));

SANGD13=squeeze(ANGD(13:25,2049:2561,:,:));
SANGC13=squeeze(ANGC(13:25,2049:2561,:,:));
SANGS13=squeeze(ANGS(13:25,2049:2561,:,:));

SANGD38=squeeze(ANGD(25:42,2049:2561,:,:));
SANGC38=squeeze(ANGC(25:42,2049:2561,:,:));
SANGS38=squeeze(ANGS(25:42,2049:2561,:,:));

%With ERP

SANGD4_N=squeeze(ANGD_N(4:8,2049:2561,:,:));
SANGC4_N=squeeze(ANGC_N(4:8,2049:2561,:,:));
SANGS4_N=squeeze(ANGS_N(4:8,2049:2561,:,:));

SANGD8_N=squeeze(ANGD_N(8:12,2049:2561,:,:));
SANGC8_N=squeeze(ANGC_N(8:12,2049:2561,:,:));
SANGS8_N=squeeze(ANGS_N(8:12,2049:2561,:,:));

SANGD13_N=squeeze(ANGD_N(13:25,2049:2561,:,:));
SANGC13_N=squeeze(ANGC_N(13:25,2049:2561,:,:));
SANGS13_N=squeeze(ANGS_N(13:25,2049:2561,:,:));

SANGD38_N=squeeze(ANGD_N(25:42,2049:2561,:,:));
SANGC38_N=squeeze(ANGC_N(25:42,2049:2561,:,:));
SANGS38_N=squeeze(ANGS_N(25:42,2049:2561,:,:));




fnamed1=sprintf('SANGD%d_4',suje)
save(fnamed1,'SANGD4')

fnamec1=sprintf('SANGC%d_4',suje)
save(fnamec1,'SANGC4')

fnames1=sprintf('SANGS%d_4',suje)
save(fnames1,'SANGS4')


fnamed2=sprintf('SANGD%d_8',suje)
save(fnamed2,'SANGD8')

fnamec2=sprintf('SANGC%d_8',suje)
save(fnamec2,'SANGC8')

fnames2=sprintf('SANGS%d_8',suje)
save(fnames2,'SANGS8')


fnamed3=sprintf('SANGD%d_13',suje)
save(fnamed3,'SANGD13')

fnamec3=sprintf('SANGC%d_13',suje)
save(fnamec3,'SANGC13')

fnames3=sprintf('SANGS%d_13',suje)
save(fnames3,'SANGS13')


fnamed4=sprintf('SANGD%d_38',suje)
save(fnamed4,'SANGD38')

fnamec4=sprintf('SANGC%d_38',suje)
save(fnamec4,'SANGC38')

fnames4=sprintf('SANGS%d_38',suje)
save(fnames4,'SANGS38')

%With ERP

fnamed5=sprintf('SANGD%d_N_4',suje)
save(fnamed5,'SANGD4_N')

fnamec5=sprintf('SANGC%d_N_4',suje)
save(fnamec5,'SANGC4_N')

fnames5=sprintf('SANGS%d_N_4',suje)
save(fnames5,'SANGS4_N')


fnamed6=sprintf('SANGD%d_N_8',suje)
save(fnamed6,'SANGD8_N')

fnamec6=sprintf('SANGC%d_N_8',suje)
save(fnamec6,'SANGC8_N')

fnames6=sprintf('SANGS%d_N_8',suje)
save(fnames6,'SANGS8_N')


fnamed7=sprintf('SANGD%d_N_13',suje)
save(fnamed7,'SANGD13_N')

fnamec7=sprintf('SANGC%d_N_13',suje)
save(fnamec7,'SANGC13_N')

fnames7=sprintf('SANGS%d_N_13',suje)
save(fnames7,'SANGS13_N')


fnamed8=sprintf('SANGD%d_N_38',suje)
save(fnamed8,'SANGD38_N')

fnamec8=sprintf('SANGC%d_N_38',suje)
save(fnamec8,'SANGC38_N')

fnames8=sprintf('SANGS%d_N_38',suje)
save(fnames8,'SANGS38_N')

clear all

end



