clear all;
clc;

fileDirectory='\\bcmcloudbk.ad.bcm.edu\bcm-mpb-larina\Kohei\070221_IVF\IVFafter5min_DIC_288x300_1ms_5x_2min40000f_340fps\';
fileName1='IVF2min_DIC_288x300_1ms_5x_148s50000f_340fps_t';
fileName2='.tif';
var_num=5;
width=288;
height=300;    
mkdir(strcat(fileDirectory,'variance5_all_test'));
dataVol(1:height,1:width,:)=0;
 for j= 1:11000
        dataVol(:,:,j)=double(rgb2gray(imread(strcat(fileDirectory,fileName1,num2str(j,'%05g'),fileName2))));
 end
 
for k=0:9
step=2.^k;
Variance(1:height,1:width,:)=0;
    
    for i = 1:30:7501
    Variance(:,:,(i-1)/30+1)=var(dataVol(:,:,i:step:i+4*step),0,3);  
    end 
    
    for  m = 1:size(Variance,3)
    imwrite(uint8(Variance(:,:,m)),strcat(fileDirectory,'variance5_all_test\','step',num2str(step),'_T',num2str(m),'.tif'));
    
    
    end 

end 

