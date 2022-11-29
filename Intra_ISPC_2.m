%For 4-8Hz

for suje = 1:36
      
    %CONDITION 1

    SANGD = load (['SANGD' num2str(suje) '_4.mat'])%load squeezed from cond 1
    SANGD = cell2mat(struct2cell(SANGD));
    
    for e1=1:27
    for e2=1:27
        for freq=1:size(SANGD,1);
        for trial=1:size(SANGD,4);
        A=SANGD(freq,:,e1,trial);
        B=SANGD(freq,:,e2,trial);
         if (isnan(A(1)) || isnan(B(1)))
            CCD(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCD(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
        
    end;
    end;
    
%%%% Hacemos medias sobre frecuencias.
CCDM=squeeze(nanmean(CCD,1));  %pasas de 4D a 3D e1,e2,trial

CCDSuj=nanmean(CCDM,3);


fnames1=sprintf('CC_Suj_D_4_%d',suje);
save(fnames1,'CCDSuj');

fnames2=sprintf('ALLCC_Suj_D_4_%d',suje);
save(fnames2,'CCDM');
clear all
end

for suje = 1:36
    
    %CONDITION 2
    SANGC = load (['SANGC' num2str(suje) '_4.mat'])%load squeezed from cond 1
    SANGC = cell2mat(struct2cell(SANGC));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGC,1);
        for trial=1:size(SANGC,4);
            
        A=SANGC(freq,:,e1,trial);
        B=SANGC(freq,:,e2,trial);
        if (isnan(A(1)) || isnan(B(1)))
            CCC(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCC(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
          
    end;
    end;


CCCM=squeeze(nanmean(CCC,1));  %pasas de 4D a 3D e1,e2,trial
CCCSuj=nanmean(CCCM,3);



fnames3=sprintf('CC_Suj_C_4_%d',suje);
save(fnames3,'CCCSuj');

fnames4=sprintf('ALLCC_Suj_C_4_%d',suje);
save(fnames4,'CCCM');
clear all
end

%CONDITION 3
for suje = 1:36
    SANGS = load (['SANGS' num2str(suje) '_4.mat'])%load squeezed from cond 1
    SANGS = cell2mat(struct2cell(SANGS));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGS,1);
        for trial=1:size(SANGS,4);
            
        A=SANGS(freq,:,e1,trial);
        B=SANGS(freq,:,e2,trial);
        if (isnan(A(1)) || isnan(B(1)))
            CCS(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCS(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;  
    end;
    end;

CCSM=squeeze(nanmean(CCS,1));
CCSSuj=nanmean(CCSM,3);


fnames5=sprintf('CC_Suj_S_4_%d',suje);
save(fnames5,'CCSSuj');

fnames6=sprintf('ALLCC_Suj_S_4_%d',suje);
save(fnames6,'CCSM');

clear all
end

%For 8-12Hz

for suje = 1:36
      
    %CONDITION 1

    SANGD = load (['SANGD' num2str(suje) '_8.mat'])%load squeezed from cond 1
    SANGD = cell2mat(struct2cell(SANGD));
    
    for e1=1:27
    for e2=1:27
        for freq=1:size(SANGD,1);
        for trial=1:size(SANGD,4);
        A=SANGD(freq,:,e1,trial);
        B=SANGD(freq,:,e2,trial);
            if (isnan(A(1)) || isnan(B(1)))
            CCD(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCD(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        
        end;
        end;
        
    end;
    end;
    
%%%% Hacemos medias sobre frecuencias. 
CCDM=squeeze(nanmean(CCD,1));  %pasas de 4D a 3D e1,e2,trial

CCDSuj=nanmean(CCDM,3);


fnames1=sprintf('CC_Suj_D_8_%d',suje);
save(fnames1,'CCDSuj');

fnames2=sprintf('ALLCC_Suj_D_8_%d',suje);
save(fnames2,'CCDM');
clear all
end



%CONDITION 2
for suje = 1:36

    SANGC = load (['SANGC' num2str(suje) '_8.mat'])%load squeezed from cond 1
    SANGC = cell2mat(struct2cell(SANGC));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGC,1);
        for trial=1:size(SANGC,4);
            
        A=SANGC(freq,:,e1,trial);
        B=SANGC(freq,:,e2,trial);
            if (isnan(A(1)) || isnan(B(1)))
            CCC(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCC(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
          
    end;
    end;


CCCM=squeeze(nanmean(CCC,1));  %pasas de 4D a 3D e1,e2,trial
CCCSuj=nanmean(CCCM,3);



fnames3=sprintf('CC_Suj_C_8_%d',suje);
save(fnames3,'CCCSuj');

fnames4=sprintf('ALLCC_Suj_C_8_%d',suje);
save(fnames4,'CCCM');

clear all

end

for suje = 1:36

%CONDITION 3

    SANGS = load (['SANGS' num2str(suje) '_8.mat'])%load squeezed from cond 1
    SANGS = cell2mat(struct2cell(SANGS));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGS,1);
        for trial=1:size(SANGS,4);
            
        A=SANGS(freq,:,e1,trial);
        B=SANGS(freq,:,e2,trial);
            if (isnan(A(1)) || isnan(B(1)))
            CCS(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCS(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        
        end;
        end;  
    end;
    end;

CCSM=squeeze(nanmean(CCS,1));
CCSSuj=nanmean(CCSM,3);


fnames5=sprintf('CC_Suj_S_8_%d',suje);
save(fnames5,'CCSSuj');

fnames6=sprintf('ALLCC_Suj_S_8_%d',suje);
save(fnames6,'CCSM');

clear all
end

%For 13-25Hz

for suje = 1:36
      
    %CONDITION 1

    SANGD = load (['SANGD' num2str(suje) '_13.mat'])%load squeezed from cond 1
    SANGD = cell2mat(struct2cell(SANGD));
    
    for e1=1:27
    for e2=1:27
        for freq=1:size(SANGD,1);
        for trial=1:size(SANGD,4);
        A=SANGD(freq,:,e1,trial);
        B=SANGD(freq,:,e2,trial);
            if (isnan(A(1)) || isnan(B(1)))
            CCD(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCD(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        
        end;
        end;
        
    end;
    end;
    
CCDM=squeeze(nanmean(CCD,1));  %pasas de 4D a 3D e1,e2,trial

CCDSuj=nanmean(CCDM,3); %ignoring nan values


fnames1=sprintf('CC_Suj_D_13_%d',suje);
save(fnames1,'CCDSuj');

fnames2=sprintf('ALLCC_Suj_D_13_%d',suje);
save(fnames2,'CCDM');
clear all
end

for suje = 1:36


%CONDITION 2

    SANGC = load (['SANGC' num2str(suje) '_13.mat'])%load squeezed from cond 1
    SANGC = cell2mat(struct2cell(SANGC));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGC,1);
        for trial=1:size(SANGC,4);
            
        A=SANGC(freq,:,e1,trial);
        B=SANGC(freq,:,e2,trial);

        if (isnan(A(1)) || isnan(B(1)))
            CCC(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCC(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
          
    end;
    end;


CCCM=squeeze(nanmean(CCC,1));  %pasas de 4D a 3D e1,e2,trial
CCCSuj=nanmean(CCCM,3);



fnames3=sprintf('CC_Suj_C_13_%d',suje);
save(fnames3,'CCCSuj');

fnames4=sprintf('ALLCC_Suj_C_13_%d',suje);
save(fnames4,'CCCM');
clear all
end

for suje = 1:36

%CONDITION 3

    SANGS = load (['SANGS' num2str(suje) '_13.mat'])%load squeezed from cond 1
    SANGS = cell2mat(struct2cell(SANGS));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGS,1);
        for trial=1:size(SANGS,4);
            
        A=SANGS(freq,:,e1,trial);
        B=SANGS(freq,:,e2,trial);
            if (isnan(A(1)) || isnan(B(1)))
            CCS(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCS(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        
        end;
        end;  
    end;
    end;

CCSM=squeeze(nanmean(CCS,1));
CCSSuj=nanmean(CCSM,3);


fnames5=sprintf('CC_Suj_S_13_%d',suje);
save(fnames5,'CCSSuj');

fnames6=sprintf('ALLCC_Suj_S_13_%d',suje);
save(fnames6,'CCSM');

clear all
end



%For 38-42Hz



for suje = 1:36
      
    %CONDITION 1

    SANGD = load (['SANGD' num2str(suje) '_38.mat'])%load squeezed from cond 1
    SANGD = cell2mat(struct2cell(SANGD));
    
    for e1=1:27
    for e2=1:27
        for freq=1:size(SANGD,1);
        for trial=1:size(SANGD,4);
        A=SANGD(freq,:,e1,trial);
        B=SANGD(freq,:,e2,trial);
         if (isnan(A(1)) || isnan(B(1)))
            CCD(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCD(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
        
    end;
    end;
    
%%%% Hacemos medias sobre frecuencias.
CCDM=squeeze(nanmean(CCD,1));  %pasas de 4D a 3D e1,e2,trial

CCDSuj=nanmean(CCDM,3);


fnames1=sprintf('CC_Suj_D_38_%d',suje);
save(fnames1,'CCDSuj');

fnames2=sprintf('ALLCC_Suj_D_38_%d',suje);
save(fnames2,'CCDM');
clear all
end

for suje = 1:36
    
    %CONDITION 2
    SANGC = load (['SANGC' num2str(suje) '_38.mat'])%load squeezed from cond 1
    SANGC = cell2mat(struct2cell(SANGC));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGC,1);
        for trial=1:size(SANGC,4);
            
        A=SANGC(freq,:,e1,trial);
        B=SANGC(freq,:,e2,trial);
        if (isnan(A(1)) || isnan(B(1)))
            CCC(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCC(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
          
    end;
    end;


CCCM=squeeze(nanmean(CCC,1));  %pasas de 4D a 3D e1,e2,trial
CCCSuj=nanmean(CCCM,3);



fnames3=sprintf('CC_Suj_C_38_%d',suje);
save(fnames3,'CCCSuj');

fnames4=sprintf('ALLCC_Suj_C_38_%d',suje);
save(fnames4,'CCCM');
clear all
end

%CONDITION 3
for suje = 1:36
    SANGS = load (['SANGS' num2str(suje) '_38.mat'])%load squeezed from cond 1
    SANGS = cell2mat(struct2cell(SANGS));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGS,1);
        for trial=1:size(SANGS,4);
            
        A=SANGS(freq,:,e1,trial);
        B=SANGS(freq,:,e2,trial);
        if (isnan(A(1)) || isnan(B(1)))
            CCS(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCS(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;  
    end;
    end;

CCSM=squeeze(nanmean(CCS,1));
CCSSuj=nanmean(CCSM,3);


fnames5=sprintf('CC_Suj_S_38_%d',suje);
save(fnames5,'CCSSuj');

fnames6=sprintf('ALLCC_Suj_S_38_%d',suje);
save(fnames6,'CCSM');

clear all
end


%Without EXtracting ERP

%For 4-8Hz

for suje = 1:36
      
    %CONDITION 1

    SANGD = load (['SANGD' num2str(suje) '_N_4.mat'])%load squeezed from cond 1
    SANGD = cell2mat(struct2cell(SANGD));
    
    for e1=1:27
    for e2=1:27
        for freq=1:size(SANGD,1);
        for trial=1:size(SANGD,4);
        A=SANGD(freq,:,e1,trial);
        B=SANGD(freq,:,e2,trial);
         if (isnan(A(1)) || isnan(B(1)))
            CCD(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCD(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
        
    end;
    end;
    
%%%% Hacemos medias sobre frecuencias.
CCDM=squeeze(nanmean(CCD,1));  %pasas de 4D a 3D e1,e2,trial

CCDSuj=nanmean(CCDM,3);


fnames1=sprintf('CC_Suj_N_D_4_%d',suje);
save(fnames1,'CCDSuj');

fnames2=sprintf('ALLCC_Suj_N_D_4_%d',suje);
save(fnames2,'CCDM');
clear all
end

for suje = 1:36
    
    %CONDITION 2
    SANGC = load (['SANGC' num2str(suje) '_N_4.mat'])%load squeezed from cond 1
    SANGC = cell2mat(struct2cell(SANGC));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGC,1);
        for trial=1:size(SANGC,4);
            
        A=SANGC(freq,:,e1,trial);
        B=SANGC(freq,:,e2,trial);
        if (isnan(A(1)) || isnan(B(1)))
            CCC(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCC(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
          
    end;
    end;


CCCM=squeeze(nanmean(CCC,1));  %pasas de 4D a 3D e1,e2,trial
CCCSuj=nanmean(CCCM,3);



fnames3=sprintf('CC_Suj_N_C_4_%d',suje);
save(fnames3,'CCCSuj');

fnames4=sprintf('ALLCC_Suj_N_C_4_%d',suje);
save(fnames4,'CCCM');
clear all
end

%CONDITION 3
for suje = 1:36
    SANGS = load (['SANGS' num2str(suje) '_N_4.mat'])%load squeezed from cond 1
    SANGS = cell2mat(struct2cell(SANGS));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGS,1);
        for trial=1:size(SANGS,4);
            
        A=SANGS(freq,:,e1,trial);
        B=SANGS(freq,:,e2,trial);
        if (isnan(A(1)) || isnan(B(1)))
            CCS(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCS(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;  
    end;
    end;

CCSM=squeeze(nanmean(CCS,1));
CCSSuj=nanmean(CCSM,3);


fnames5=sprintf('CC_Suj_N_S_4_%d',suje);
save(fnames5,'CCSSuj');

fnames6=sprintf('ALLCC_Suj_N_S_4_%d',suje);
save(fnames6,'CCSM');

clear all
end

%For 8-12Hz

for suje = 1:36
      
    %CONDITION 1

    SANGD = load (['SANGD' num2str(suje) '_N_8.mat'])%load squeezed from cond 1
    SANGD = cell2mat(struct2cell(SANGD));
    
    for e1=1:27
    for e2=1:27
        for freq=1:size(SANGD,1);
        for trial=1:size(SANGD,4);
        A=SANGD(freq,:,e1,trial);
        B=SANGD(freq,:,e2,trial);
            if (isnan(A(1)) || isnan(B(1)))
            CCD(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCD(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        
        end;
        end;
        
    end;
    end;
    
%%%% Hacemos medias sobre frecuencias. 
CCDM=squeeze(nanmean(CCD,1));  %pasas de 4D a 3D e1,e2,trial

CCDSuj=nanmean(CCDM,3);


fnames1=sprintf('CC_Suj_N_D_8_%d',suje);
save(fnames1,'CCDSuj');

fnames2=sprintf('ALLCC_Suj_N_D_8_%d',suje);
save(fnames2,'CCDM');
clear all
end



%CONDITION 2
for suje = 1:36

    SANGC = load (['SANGC' num2str(suje) '_N_8.mat'])%load squeezed from cond 1
    SANGC = cell2mat(struct2cell(SANGC));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGC,1);
        for trial=1:size(SANGC,4);
            
        A=SANGC(freq,:,e1,trial);
        B=SANGC(freq,:,e2,trial);
            if (isnan(A(1)) || isnan(B(1)))
            CCC(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCC(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
          
    end;
    end;


CCCM=squeeze(nanmean(CCC,1));  %pasas de 4D a 3D e1,e2,trial
CCCSuj=nanmean(CCCM,3);



fnames3=sprintf('CC_Suj_N_C_8_%d',suje);
save(fnames3,'CCCSuj');

fnames4=sprintf('ALLCC_Suj_N_C_8_%d',suje);
save(fnames4,'CCCM');

clear all

end

for suje = 1:36

%CONDITION 3

    SANGS = load (['SANGS' num2str(suje) '_N_8.mat'])%load squeezed from cond 1
    SANGS = cell2mat(struct2cell(SANGS));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGS,1);
        for trial=1:size(SANGS,4);
            
        A=SANGS(freq,:,e1,trial);
        B=SANGS(freq,:,e2,trial);
            if (isnan(A(1)) || isnan(B(1)))
            CCS(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCS(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        
        end;
        end;  
    end;
    end;

CCSM=squeeze(nanmean(CCS,1));
CCSSuj=nanmean(CCSM,3);


fnames5=sprintf('CC_Suj_N_S_8_%d',suje);
save(fnames5,'CCSSuj');

fnames6=sprintf('ALLCC_Suj_N_S_8_%d',suje);
save(fnames6,'CCSM');

clear all
end

%For 13-25Hz

for suje = 1:36
      
    %CONDITION 1

    SANGD = load (['SANGD' num2str(suje) '_N_13.mat'])%load squeezed from cond 1
    SANGD = cell2mat(struct2cell(SANGD));
    
    for e1=1:27
    for e2=1:27
        for freq=1:size(SANGD,1);
        for trial=1:size(SANGD,4);
        A=SANGD(freq,:,e1,trial);
        B=SANGD(freq,:,e2,trial);
            if (isnan(A(1)) || isnan(B(1)))
            CCD(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCD(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        
        end;
        end;
        
    end;
    end;
    
CCDM=squeeze(nanmean(CCD,1));  %pasas de 4D a 3D e1,e2,trial

CCDSuj=nanmean(CCDM,3); %ignoring nan values


fnames1=sprintf('CC_Suj_N_D_13_%d',suje);
save(fnames1,'CCDSuj');

fnames2=sprintf('ALLCC_Suj_N_D_13_%d',suje);
save(fnames2,'CCDM');
clear all
end

for suje = 1:36


%CONDITION 2

    SANGC = load (['SANGC' num2str(suje) '_N_13.mat'])%load squeezed from cond 1
    SANGC = cell2mat(struct2cell(SANGC));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGC,1);
        for trial=1:size(SANGC,4);
            
        A=SANGC(freq,:,e1,trial);
        B=SANGC(freq,:,e2,trial);

        if (isnan(A(1)) || isnan(B(1)))
            CCC(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCC(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
          
    end;
    end;


CCCM=squeeze(nanmean(CCC,1));  %pasas de 4D a 3D e1,e2,trial
CCCSuj=nanmean(CCCM,3);



fnames3=sprintf('CC_Suj_N_C_13_%d',suje);
save(fnames3,'CCCSuj');

fnames4=sprintf('ALLCC_Suj_N_C_13_%d',suje);
save(fnames4,'CCCM');
clear all
end

for suje = 1:36

%CONDITION 3

    SANGS = load (['SANGS' num2str(suje) '_N_13.mat'])%load squeezed from cond 1
    SANGS = cell2mat(struct2cell(SANGS));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGS,1);
        for trial=1:size(SANGS,4);
            
        A=SANGS(freq,:,e1,trial);
        B=SANGS(freq,:,e2,trial);
            if (isnan(A(1)) || isnan(B(1)))
            CCS(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCS(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        
        end;
        end;  
    end;
    end;

CCSM=squeeze(nanmean(CCS,1));
CCSSuj=nanmean(CCSM,3);


fnames5=sprintf('CC_Suj_N_S_13_%d',suje);
save(fnames5,'CCSSuj');

fnames6=sprintf('ALLCC_Suj_N_S_13_%d',suje);
save(fnames6,'CCSM');

clear all
end



%For 38-42Hz



for suje = 1:36
      
    %CONDITION 1

    SANGD = load (['SANGD' num2str(suje) '_N_38.mat'])%load squeezed from cond 1
    SANGD = cell2mat(struct2cell(SANGD));
    
    for e1=1:27
    for e2=1:27
        for freq=1:size(SANGD,1);
        for trial=1:size(SANGD,4);
        A=SANGD(freq,:,e1,trial);
        B=SANGD(freq,:,e2,trial);
         if (isnan(A(1)) || isnan(B(1)))
            CCD(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCD(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
        
    end;
    end;
    
%%%% Hacemos medias sobre frecuencias.
CCDM=squeeze(nanmean(CCD,1));  %pasas de 4D a 3D e1,e2,trial

CCDSuj=nanmean(CCDM,3);


fnames1=sprintf('CC_Suj_N_D_38_%d',suje);
save(fnames1,'CCDSuj');

fnames2=sprintf('ALLCC_Suj_N_D_38_%d',suje);
save(fnames2,'CCDM');
clear all
end

for suje = 1:36
    
    %CONDITION 2
    SANGC = load (['SANGC' num2str(suje) '_N_38.mat'])%load squeezed from cond 1
    SANGC = cell2mat(struct2cell(SANGC));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGC,1);
        for trial=1:size(SANGC,4);
            
        A=SANGC(freq,:,e1,trial);
        B=SANGC(freq,:,e2,trial);
        if (isnan(A(1)) || isnan(B(1)))
            CCC(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCC(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;
          
    end;
    end;


CCCM=squeeze(nanmean(CCC,1));  %pasas de 4D a 3D e1,e2,trial
CCCSuj=nanmean(CCCM,3);



fnames3=sprintf('CC_Suj_N_C_38_%d',suje);
save(fnames3,'CCCSuj');

fnames4=sprintf('ALLCC_Suj_N_C_38_%d',suje);
save(fnames4,'CCCM');
clear all
end

%CONDITION 3
for suje = 1:36
    SANGS = load (['SANGS' num2str(suje) '_N_38.mat'])%load squeezed from cond 1
    SANGS = cell2mat(struct2cell(SANGS));
    
    for e1=1:27;
    for e2=1:27;

        for freq=1:size(SANGS,1);
        for trial=1:size(SANGS,4);
            
        A=SANGS(freq,:,e1,trial);
        B=SANGS(freq,:,e2,trial);
        if (isnan(A(1)) || isnan(B(1)))
            CCS(freq,e1,e2,trial)=NaN;
        
            else
            DIFA=A-B;     
        

            jj=sqrt(-1);
            CCS(freq,e1,e2,trial)=abs(sum(exp(jj*(DIFA)))/size(A,2));
            end;
        end;
        end;  
    end;
    end;

CCSM=squeeze(nanmean(CCS,1));
CCSSuj=nanmean(CCSM,3);


fnames5=sprintf('CC_Suj_N_S_38_%d',suje);
save(fnames5,'CCSSuj');

fnames6=sprintf('ALLCC_Suj_N_S_38_%d',suje);
save(fnames6,'CCSM');

clear all
end

