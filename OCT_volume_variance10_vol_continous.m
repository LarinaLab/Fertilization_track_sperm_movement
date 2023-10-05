clear all;
clc;

OrgfileDirectory='G:\Fertilizaton project\090321_IVF1_2min_150x150_0.3x0.3_Bscan1.2ms\images\';
TarfileDirectory='D:\Tian\fertilization\090321_IVF1_2min_150x150_0.3x0.3_Bscan1.2ms\';
fileName1='image_';
fileName2='.tiff';


TotalframeNumber=150;
var_num=10;
width=150;
depth=250;


for j=0
    
    mkdir(strcat(TarfileDirectory,'continous8outof10_var10sep',num2str(j)));

        Vol(1:depth,1:width,1:TotalframeNumber,1:200+var_num-1)=0;
        
        for fileNumber= 1:TotalframeNumber
            for series_num=1:200+var_num-1
                dataMatrix=imread(strcat(OrgfileDirectory,fileName1,num2str((series_num-1)*TotalframeNumber+fileNumber+j*30000,'%06g'),fileName2));
                Vol(:,:,fileNumber,series_num)=dataMatrix(100:349,:);
            end 
        end 

        Variance(1:depth,1:width,1:TotalframeNumber,1:200)=0;
        mask(1:250,1:150,1:150,1:200)=0;
        
        for varseries=1:200
            Variance(:,:,:,varseries)=var(Vol(:,:,:,varseries:varseries+var_num-1),0,4);
            normVar(:,:,:,varseries) = Variance(:,:,:,varseries) - min(Variance(:,:,:,varseries),[],'all');
            normVar(:,:,:,varseries) = normVar(:,:,:,varseries) ./ max(normVar(:,:,:,varseries),[],'all');
  %% size mask    
            size=6;
            threshold=0.2;
            for o=1:250-size
                for p=1:150-size
                    for q=1:150-size
                        if mean(normVar(o:o+size,p:p+size,q:q+size,varseries),'all')>threshold
                            mask(o:o+size,p:p+size,q:q+size,varseries)=1;
                        end
                    end
                end
            end
            
            
        end 
 %% selecting for spot appear continously at least once in the following eight volumes
%         vol_continous(1:250,1:150,1:150,1:200)=0;
%         for volconseries=1:196
%             for step=1:4
%                 idx=mask(:,:,:,volconseries).*mask(:,:,:,volconseries+step);
%                 if find(idx==1)
%                     vol_continous(:,:,:,volconseries)=double(idx|vol_continous(:,:,:,volconseries));
%                 end
%             end
%         end
%         continousVar=normVar.*vol_continous;
  %% selecting for spot appear continously at next 8 out of 10 volumes
        vol_continous(1:250,1:150,1:150,1:200)=0;
        for temp1=1:250
                for temp2=1:150
                    for temp3=1:150
                        for temp4=1:141
                            if sum(double(~logical(mask(temp1,temp2,temp3:temp3,temp4:temp4+9))))<=2
                                vol_continous(temp1,temp2,temp3,temp4)=1;
                            end
                        end 
                    end
                end
        end
        continousVar=normVar.*vol_continous;
 %% selecting for spot appear continously at all eight volumes
%         vol_continous(1:250,1:150,1:150,1:200)=0;
%         for volconseries=1:192
%             idx=mask(:,:,:,volconseries).*mask(:,:,:,volconseries+1);
%             for step=2:8
%                 idx=idx.*mask(:,:,:,volconseries+step);
%                 if find(idx==1)
%                     vol_continous(:,:,:,volconseries)=idx;
%                 end
%             end
%         end
%         continousVar=normVar.*vol_continous;
%% output
        for m=1:200
            for n=1:150
                imwrite(uint8(255*mat2gray(continousVar(:,:,n,m))),strcat(TarfileDirectory,'continous8outof10_var10sep',num2str(j),'\',fileName1,'T',num2str(m),'_Z',num2str(n),'.tif'));
            end 
        end
    end 
