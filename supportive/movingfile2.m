clear all;
clc;

OrgfileDirectory='E:\Fertilizaton project\090321_IVF1_14min_150x150_0.3x0.3_Bscan1.4ms\images\';
TarfileDirectory='D:\Tian\fertilization\090321_IVF1_14min_150x150_0.3x0.3_Bscan1.4ms\';
fileName1='image_';
fileName2='.tiff';


for series_num=1:20
    baseNumber=200*150*(series_num-1);
    Timepoint=200*(series_num-1);
    mkdir(strcat(TarfileDirectory,'str5sep',num2str(Timepoint)));  
    for i=1:200
        for fileNumber=1:150
            img=imread(strcat(OrgfileDirectory,fileName1,num2str(150*(i-1)+baseNumber+fileNumber,'%06g'),fileName2));
            imwrite(img(100:349,:),strcat(TarfileDirectory,'str10sep',num2str(Timepoint),'\',fileName1,num2str(i+Timepoint),'_Z',num2str(fileNumber),'.tif'));
          
        end 
    end
end