%Theta

fileID = fopen('intramatrixALL_4.csv','w');
    
for suje=1:36
    
     suje           
    
    load(['ALLCC_Suj_D_4_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_C_4_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_S_4_',num2str(suje),'.mat']);
    
    CCDM=squeeze(CCDM);
    CCCM=squeeze(CCCM);
    CCSM=squeeze(CCSM);
    
    
    for trial=1:size(CCDM,3);
        for el=1:27;
            for ell=el+1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCDM(el,ell,trial),el,ell,suje,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCCM(el,ell,trial),el,ell,suje,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCSM(el,ell,trial),el,ell,suje,3,trial);
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

clear all
%Alpha

fileID = fopen('intramatrixALL_8.csv','w');
    
for suje=1:36
    
     suje           
    
    load(['ALLCC_Suj_D_8_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_C_8_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_S_8_',num2str(suje),'.mat']);
    
    CCDM=squeeze(CCDM);
    CCCM=squeeze(CCCM);
    CCSM=squeeze(CCSM);
    
    
    for trial=1:size(CCDM,3);
        for el=1:27;
            for ell=el+1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCDM(el,ell,trial),el,ell,suje,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCCM(el,ell,trial),el,ell,suje,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCSM(el,ell,trial),el,ell,suje,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

clear all
%Beta

fileID = fopen('intramatrixALL_13.csv','w');
    
for suje=1:36
    
     suje           
    
    load(['ALLCC_Suj_D_13_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_C_13_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_S_13_',num2str(suje),'.mat']);
    
    CCDM=squeeze(CCDM);
    CCCM=squeeze(CCCM);
    CCSM=squeeze(CCSM);
    
    
    for trial=1:size(CCDM,3);
        for el=1:27;
            for ell=el+1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCDM(el,ell,trial),el,ell,suje,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCCM(el,ell,trial),el,ell,suje,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCSM(el,ell,trial),el,ell,suje,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

clear all
%Gamma

fileID = fopen('intramatrixALL_38.csv','w');
    
for suje=1:36
    
     suje           
    
    load(['ALLCC_Suj_D_38_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_C_38_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_S_38_',num2str(suje),'.mat']);
    
    CCDM=squeeze(CCDM);
    CCCM=squeeze(CCCM);
    CCSM=squeeze(CCSM);
    
    
    for trial=1:size(CCDM,3);
        for el=1:27;
            for ell=el+1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCDM(el,ell,trial),el,ell,suje,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCCM(el,ell,trial),el,ell,suje,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCSM(el,ell,trial),el,ell,suje,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

%WITH ERP N
%Theta

fileID = fopen('intramatrixALL_N_4.csv','w');
    
for suje=1:36
    
     suje           
    
    load(['ALLCC_Suj_N_D_4_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_N_C_4_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_N_S_4_',num2str(suje),'.mat']);
    
    CCDM=squeeze(CCDM);
    CCCM=squeeze(CCCM);
    CCSM=squeeze(CCSM);
    
    
    for trial=1:size(CCDM,3);
        for el=1:27;
            for ell=el+1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCDM(el,ell,trial),el,ell,suje,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCCM(el,ell,trial),el,ell,suje,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCSM(el,ell,trial),el,ell,suje,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

clear all
%Alpha

fileID = fopen('intramatrixALL_N_8.csv','w');
    
for suje=1:36
    
     suje           
    
    load(['ALLCC_Suj_N_D_8_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_N_C_8_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_N_S_8_',num2str(suje),'.mat']);
    
    CCDM=squeeze(CCDM);
    CCCM=squeeze(CCCM);
    CCSM=squeeze(CCSM);
    
    
    for trial=1:size(CCDM,3);
        for el=1:27;
            for ell=el+1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCDM(el,ell,trial),el,ell,suje,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCCM(el,ell,trial),el,ell,suje,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCSM(el,ell,trial),el,ell,suje,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

clear all
%Beta

fileID = fopen('intramatrixALL_N_13.csv','w');
    
for suje=1:36
    
     suje           
    
    load(['ALLCC_Suj_N_D_13_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_N_C_13_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_N_S_13_',num2str(suje),'.mat']);
    
    CCDM=squeeze(CCDM);
    CCCM=squeeze(CCCM);
    CCSM=squeeze(CCSM);
    
    
    for trial=1:size(CCDM,3);
        for el=1:27;
            for ell=el+1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCDM(el,ell,trial),el,ell,suje,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCCM(el,ell,trial),el,ell,suje,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCSM(el,ell,trial),el,ell,suje,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);

clear all
%Gamma

fileID = fopen('intramatrixALL_N_38.csv','w');
    
for suje=1:36
    
     suje           
    
    load(['ALLCC_Suj_N_D_38_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_N_C_38_',num2str(suje),'.mat']);
    load(['ALLCC_Suj_N_S_38_',num2str(suje),'.mat']);
    
    CCDM=squeeze(CCDM);
    CCCM=squeeze(CCCM);
    CCSM=squeeze(CCSM);
    
    
    for trial=1:size(CCDM,3);
        for el=1:27;
            for ell=el+1:27;
                
                  
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCDM(el,ell,trial),el,ell,suje,1,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCCM(el,ell,trial),el,ell,suje,2,trial);
                fprintf(fileID,'%f,%i,%i,%i,%i,%i\n',CCSM(el,ell,trial),el,ell,suje,3,trial);
                
                
                               
            end;
        end;
    end
   
end
fclose(fileID);