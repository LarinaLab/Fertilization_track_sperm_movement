clear all;
clc;

OrgfileDirectory='E:\Fertilizaton project\090321_IVF1_2min_150x150_0.3x0.3_Bscan1.2ms\images\';
TarfileDirectory='D:\Tian\fertilization\090321_IVF1_2min_150x150_0.3x0.3_Bscan1.2ms\';
fileName1='image_';
fileName2='.tiff';


TotalframeNumber=150;
var_num=5;
width=150;
depth=250;

for j=0
    
    mkdir(strcat(TarfileDirectory,'maskp1size6_var5sep',num2str(j)));

    for i=j*200:j*200+199

        Vol(1:depth,1:width,1:TotalframeNumber,1:var_num)=0;
        
        for series_num=i:i+var_num-1
            for fileNumber= 1:TotalframeNumber
                dataMatrix=imread(strcat(OrgfileDirectory,fileName1,num2str((series_num)*TotalframeNumber+fileNumber,'%06g'),fileName2));
                Vol(:,:,fileNumber,series_num-i+1)=dataMatrix(100:349,:);
            end 
        end 

        Variance(1:depth,1:width,1:TotalframeNumber)=0;

        Variance(:,:,:)=var(Vol(:,:,:,1:var_num),0,4);
        normVar = Variance - min(Variance,[],'all');
        normVar = normVar ./ max(normVar,[],'all');
        
        mask(1:250,1:150,1:150)=0;
        for o=1:244
            for p=1:144
                for q=1:144
                    if mean(normVar(o:o+6,p:p+6,q:q+6),'all')>0.1
                        mask(o:o+6,p:p+6,q:q+6)=1;
                    end
                end
            end
        end
        maskVar=normVar.*mask;

        for m=1:TotalframeNumber
            imwrite(uint8(255*mat2gray(maskVar(:,:,m))),strcat(TarfileDirectory,'maskp1size6_var5sep',num2str(j),'\',fileName1,'T',num2str(i),'_Z',num2str(m),'.tif'));
        end 

    end 
end 