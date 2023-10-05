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

for j=1:9
    
    mkdir(strcat(TarfileDirectory,'nor_var5sep',num2str(j)));

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
        
        

        for m=1:TotalframeNumber
            imwrite(uint8(255*mat2gray(normVar(:,:,m))),strcat(TarfileDirectory,'nor_var5sep',num2str(j),'\',fileName1,'T',num2str(i),'_Z',num2str(m),'.tif'));
        end 

    end 
end 