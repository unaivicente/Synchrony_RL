
%Theta Band


fileID = fopen('dyadmatrixALL_4.csv','w');
    
for dyad=1:18
    
     dyad           
    
    load(['CC_Dyad_D_4_',num2str(dyad),'.mat']);
    load(['CC_Dyad_C_4_',num2str(dyad),'.mat']);
    load(['CC_Dyad_S_4_',num2str(dyad),'.mat']);
    
    CCD_Dyad=squeeze(CCD_Dyad);
    CCC_Dyad=squeeze(CCC_Dyad);
    CCS_Dyad=squeeze(CCS_Dyad);
    
    
    for trial=1:size(CCD_Dyad,3);
        for el=1:27;
            for ell=1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCD_Dyad(el+27,ell,trial),el,ell,dyad,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCC_Dyad(el+27,ell,trial),el,ell,dyad,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCS_Dyad(el+27,ell,trial),el,ell,dyad,3,trial);
                
            end;
        end;
    end
   
end
fclose(fileID);

%Alpha Band

clear all

fileID = fopen('dyadmatrixALL_8.csv','w');
    
for dyad=1:18
    
     dyad           
    
    load(['CC_Dyad_D_8_',num2str(dyad),'.mat']);
    load(['CC_Dyad_C_8_',num2str(dyad),'.mat']);
    load(['CC_Dyad_S_8_',num2str(dyad),'.mat']);
    
    CCD_Dyad=squeeze(CCD_Dyad);
    CCC_Dyad=squeeze(CCC_Dyad);
    CCS_Dyad=squeeze(CCS_Dyad);
    
    
    for trial=1:size(CCD_Dyad,3);
        for el=1:27;
            for ell=1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCD_Dyad(el+27,ell,trial),el,ell,dyad,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCC_Dyad(el+27,ell,trial),el,ell,dyad,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCS_Dyad(el+27,ell,trial),el,ell,dyad,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

clear all

%Beta Band

fileID = fopen('dyadmatrixALL_13.csv','w');
    
for dyad=1:18
    
     dyad           
    
    load(['CC_Dyad_D_13_',num2str(dyad),'.mat']);
    load(['CC_Dyad_C_13_',num2str(dyad),'.mat']);
    load(['CC_Dyad_S_13_',num2str(dyad),'.mat']);
    
    CCD_Dyad=squeeze(CCD_Dyad);
    CCC_Dyad=squeeze(CCC_Dyad);
    CCS_Dyad=squeeze(CCS_Dyad);
    
    
    for trial=1:size(CCD_Dyad,3);
        for el=1:27;
            for ell=1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCD_Dyad(el+27,ell,trial),el,ell,dyad,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCC_Dyad(el+27,ell,trial),el,ell,dyad,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCS_Dyad(el+27,ell,trial),el,ell,dyad,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

clear all

fileID = fopen('dyadmatrixALL_38.csv','w');
    
for dyad=1:18
    
     dyad           
    
    load(['CC_Dyad_D_38_',num2str(dyad),'.mat']);
    load(['CC_Dyad_C_38_',num2str(dyad),'.mat']);
    load(['CC_Dyad_S_38_',num2str(dyad),'.mat']);
    
    CCD_Dyad=squeeze(CCD_Dyad);
    CCC_Dyad=squeeze(CCC_Dyad);
    CCS_Dyad=squeeze(CCS_Dyad);
    
    
    for trial=1:size(CCD_Dyad,3);
        for el=1:27;
            for ell=1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCD_Dyad(el+27,ell,trial),el,ell,dyad,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCC_Dyad(el+27,ell,trial),el,ell,dyad,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCS_Dyad(el+27,ell,trial),el,ell,dyad,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

%%%%%



fileID = fopen('dyadmatrixALL_N_4.csv','w');
    
for dyad=1:18
    
     dyad           
    
    load(['CC_Dyad_N_D_4_',num2str(dyad),'.mat']);
    load(['CC_Dyad_N_C_4_',num2str(dyad),'.mat']);
    load(['CC_Dyad_N_S_4_',num2str(dyad),'.mat']);
    
    CCD_Dyad=squeeze(CCD_Dyad);
    CCC_Dyad=squeeze(CCC_Dyad);
    CCS_Dyad=squeeze(CCS_Dyad);
    
    
    for trial=1:size(CCD_Dyad,3);
        for el=1:27;
            for ell=1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCD_Dyad(el+27,ell,trial),el,ell,dyad,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCC_Dyad(el+27,ell,trial),el,ell,dyad,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCS_Dyad(el+27,ell,trial),el,ell,dyad,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

clear all

fileID = fopen('dyadmatrixALL_N_8.csv','w');
    
for dyad=1:18
    
     dyad           
    
    load(['CC_Dyad_N_D_8_',num2str(dyad),'.mat']);
    load(['CC_Dyad_N_C_8_',num2str(dyad),'.mat']);
    load(['CC_Dyad_N_S_8_',num2str(dyad),'.mat']);
    
    CCD_Dyad=squeeze(CCD_Dyad);
    CCC_Dyad=squeeze(CCC_Dyad);
    CCS_Dyad=squeeze(CCS_Dyad);
    
    
    for trial=1:size(CCD_Dyad,3);
        for el=1:27;
            for ell=1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCD_Dyad(el+27,ell,trial),el,ell,dyad,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCC_Dyad(el+27,ell,trial),el,ell,dyad,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCS_Dyad(el+27,ell,trial),el,ell,dyad,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

clear all


fileID = fopen('dyadmatrixALL_N_13.csv','w');
    
for dyad=1:18
    
     dyad           
    
    load(['CC_Dyad_N_D_13_',num2str(dyad),'.mat']);
    load(['CC_Dyad_N_C_13_',num2str(dyad),'.mat']);
    load(['CC_Dyad_N_S_13_',num2str(dyad),'.mat']);
    
    CCD_Dyad=squeeze(CCD_Dyad);
    CCC_Dyad=squeeze(CCC_Dyad);
    CCS_Dyad=squeeze(CCS_Dyad);
    
    
    for trial=1:size(CCD_Dyad,3);
        for el=1:27;
            for ell=1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCD_Dyad(el+27,ell,trial),el,ell,dyad,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCC_Dyad(el+27,ell,trial),el,ell,dyad,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCS_Dyad(el+27,ell,trial),el,ell,dyad,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

clear all


fileID = fopen('dyadmatrixALL_N_38.csv','w');
    
for dyad=1:18
    
     dyad           
    
    load(['CC_Dyad_N_D_38_',num2str(dyad),'.mat']);
    load(['CC_Dyad_N_C_38_',num2str(dyad),'.mat']);
    load(['CC_Dyad_N_S_38_',num2str(dyad),'.mat']);
    
    CCD_Dyad=squeeze(CCD_Dyad);
    CCC_Dyad=squeeze(CCC_Dyad);
    CCS_Dyad=squeeze(CCS_Dyad);
    
    
    for trial=1:size(CCD_Dyad,3);
        for el=1:27;
            for ell=1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCD_Dyad(el+27,ell,trial),el,ell,dyad,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCC_Dyad(el+27,ell,trial),el,ell,dyad,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCS_Dyad(el+27,ell,trial),el,ell,dyad,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);