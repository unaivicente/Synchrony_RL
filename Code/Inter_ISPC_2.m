%Band starting at 4Hz

% CONDITION 1

for suje = 1:2:36
    
    
    S1=load (['SANGD_1_4_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGD_2_4_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCD_Dyad=nanmean(CCD,1);


fnames1=sprintf('CC_Dyad_D_4_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCD_Dyad');

end

clear all
% CONDITION 2

for suje = 1:2:36
    
    
    S1=load (['SANGC_1_4_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGC_2_4_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCC_Dyad=nanmean(CCC,1);

fnames1=sprintf('CC_Dyad_C_4_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCC_Dyad');

end
clear all
% CONDITION 3

for suje = 1:2:36
    
    
    S1=load (['SANGS_1_4_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGS_2_4_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCS_Dyad=nanmean(CCS,1);

fnames1=sprintf('CC_Dyad_S_4_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCS_Dyad');

end
 clear all   

%Band starting at 8Hz

% CONDITION 1

for suje = 1:2:36
    
    
    S1=load (['SANGD_1_8_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGD_2_8_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCD_Dyad=nanmean(CCD,1);

fnames1=sprintf('CC_Dyad_D_8_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCD_Dyad');

end
clear all
% CONDITION 2

for suje = 1:2:36
    
    
    S1=load (['SANGC_1_8_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGC_2_8_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCC_Dyad=nanmean(CCC,1);

fnames1=sprintf('CC_Dyad_C_8_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCC_Dyad');

end
clear all
% CONDITION 3

for suje = 1:2:36
    
    
    S1=load (['SANGS_1_8_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGS_2_8_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCS_Dyad=nanmean(CCS,1);
fnames1=sprintf('CC_Dyad_S_8_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCS_Dyad');

end
clear all
%Band starting at 13Hz

    % CONDITION 1


for suje = 1:2:36
    
    
    S1=load (['SANGD_1_13_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGD_2_13_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCD_Dyad=nanmean(CCD,1);%no hace falta el cuadrado

fnames1=sprintf('CC_Dyad_D_13_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCD_Dyad');

end
clear all
% CONDITION 2

for suje = 1:2:36
    
    
    S1=load (['SANGC_1_13_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGC_2_13_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
      for trial=1:size(DYAD,4);
      for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCC_Dyad=nanmean(CCC,1);%no hace falta el cuadrado
fnames1=sprintf('CC_Dyad_C_13_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCC_Dyad');

end
clear all
% CONDITION 3

for suje = 1:2:36
    
    
    S1=load (['SANGS_1_13_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGS_2_13_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
      for trial=1:size(DYAD,4);
      for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCS_Dyad=nanmean(CCS,1);%ahora no hace falta el cuadrado

fnames1=sprintf('CC_Dyad_S_13_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCS_Dyad');

end
clear all

%Band starting at 38Hz

% CONDITION 1

for suje = 1:2:36
    
    
    S1=load (['SANGD_1_38_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGD_2_38_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCD_Dyad=nanmean(CCD,1);


fnames1=sprintf('CC_Dyad_D_38_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCD_Dyad');

end
clear all
% CONDITION 2

for suje = 1:2:36
    
    
    S1=load (['SANGC_1_38_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGC_2_38_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCC_Dyad=nanmean(CCC,1);

fnames1=sprintf('CC_Dyad_C_38_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCC_Dyad');

end
clear all
% CONDITION 3

for suje = 1:2:36
    
    
    S1=load (['SANGS_1_38_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGS_2_38_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCS_Dyad=nanmean(CCS,1);

fnames1=sprintf('CC_Dyad_S_38_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCS_Dyad');

end

clear all
%%%%%% NOW WITH ERP DATA

%Band starting at 4Hz

% CONDITION 1

for suje = 1:2:36
    
    
    S1=load (['SANGD_N_1_4_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGD_N_2_4_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCD_Dyad=nanmean(CCD,1);


fnames1=sprintf('CC_Dyad_N_D_4_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCD_Dyad');

end
clear all
% CONDITION 2

for suje = 1:2:36
    
    
    S1=load (['SANGC_N_1_4_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGC_N_2_4_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCC_Dyad=nanmean(CCC,1);

fnames1=sprintf('CC_Dyad_N_C_4_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCC_Dyad');

end
clear all
% CONDITION 3

for suje = 1:2:36
    
    
    S1=load (['SANGS_N_1_4_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGS_N_2_4_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCS_Dyad=nanmean(CCS,1);

fnames1=sprintf('CC_Dyad_N_S_4_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCS_Dyad');

end
clear all

%Band starting at 8Hz

% CONDITION 1

for suje = 1:2:36
    
    
    S1=load (['SANGD_N_1_8_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGD_N_2_8_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCD_Dyad=nanmean(CCD,1);

fnames1=sprintf('CC_Dyad_N_D_8_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCD_Dyad');

end
clear all
% CONDITION 2

for suje = 1:2:36
    
    
    S1=load (['SANGC_N_1_8_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGC_N_2_8_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCC_Dyad=nanmean(CCC,1);

fnames1=sprintf('CC_Dyad_N_C_8_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCC_Dyad');

end
clear all
% CONDITION 3

for suje = 1:2:36
    
    
    S1=load (['SANGS_N_1_8_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGS_N_2_8_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCS_Dyad=nanmean(CCS,1);
fnames1=sprintf('CC_Dyad_N_S_8_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCS_Dyad');

end
clear all
%Band starting at 13Hz

    % CONDITION 1

for suje = 1:2:36
    
    
    S1=load (['SANGD_N_1_13_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGD_N_2_13_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCD_Dyad=nanmean(CCD,1);%no hace falta el cuadrado

fnames1=sprintf('CC_Dyad_N_D_13_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCD_Dyad');

end

clear all
% CONDITION 2

for suje = 1:2:36
    
    
    S1=load (['SANGC_N_1_13_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGC_N_2_13_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
      for trial=1:size(DYAD,4);
      for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCC_Dyad=nanmean(CCC,1);%no hace falta el cuadrado
fnames1=sprintf('CC_Dyad_N_C_13_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCC_Dyad');

end
clear all
% CONDITION 3

for suje = 1:2:36
    
    
    S1=load (['SANGS_N_1_13_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGS_N_2_13_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
      for trial=1:size(DYAD,4);
      for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCS_Dyad=nanmean(CCS,1);%ahora no hace falta el cuadrado

fnames1=sprintf('CC_Dyad_N_S_13_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCS_Dyad');

end
clear all

%Band starting at 38Hz

% CONDITION 1

for suje = 1:2:36
    
    
    S1=load (['SANGD_N_1_38_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGD_N_2_38_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCD_Dyad=nanmean(CCD,1);


fnames1=sprintf('CC_Dyad_N_D_38_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCD_Dyad');

end
clear all
% CONDITION 2

for suje = 1:2:36
    
    
    S1=load (['SANGC_N_1_38_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGC_N_2_38_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCC_Dyad=nanmean(CCC,1);

fnames1=sprintf('CC_Dyad_N_C_38_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCC_Dyad');

end
clear all
% CONDITION 3

for suje = 1:2:36
    
    
    S1=load (['SANGS_N_1_38_' num2str(suje) '.mat']);%load squeezed suje 1 from dyad
    S2=load (['SANGS_N_2_38_' num2str(suje+1) '.mat']);%load squeezed suje 2 from dyad
    
    S1 = cell2mat(struct2cell(S1));
    S2 = cell2mat(struct2cell(S2));
    
    DYAD = cat(3,S1,S2);    
    
    for e1=1:54;
    for e2=1:54;
        
        for trial=1:size(DYAD,4);
        for freq=1:size(DYAD,1);
        
        A=DYAD(freq,:,e1,trial);
        B=DYAD(freq,:,e2,trial);
        
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

    
CCS_Dyad=nanmean(CCS,1);

fnames1=sprintf('CC_Dyad_N_S_38_%d',(suje+1)/2);%isolated from arithmetic prog
save(fnames1,'CCS_Dyad');

end
clear all

