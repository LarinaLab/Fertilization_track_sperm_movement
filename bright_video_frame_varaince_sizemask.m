clear all;
clc;

fileDirectory='E:\Fertilizaton project\070221_IVF_Bright_field_validation_dataset\070221_IVF\IVFafter5min_DIC_288x300_1ms_5x_2min40000f_340fps\';
fileName1='IVFafter5min_DIC_288x300_1ms_5x_2min40000f_340fps_t';
fileName2='.tif';
var_num=5;
width=144;
height=150;  
dataVol(1:height,1:width,:)=0;
   for j= 25001:40959
        dataVol(:,:,j-25000)=double(rgb2gray(imresize(imread(strcat(fileDirectory,fileName1,num2str(j,'%05g'),fileName2)),0.5)));
    end 

for k=7:9
step=2.^k;
mkdir(strcat(fileDirectory,'variance5_all_resize\variance5_normalize_step',num2str(step)));

Variance(1:height,1:width,:)=0;
 
    
    for i = 1:30:10801
    Variance(:,:,(i-1)/30+1)=var(dataVol(:,:,i:step:i+4*step),0,3);  
    end 
    normVar = Variance - min(Variance,[],'all');
    normVar = normVar ./ max(normVar,[],'all');
    %% size mask
%     for h=1:150
%         for w=1:144
%             if mean(normVar(h:h+3,w:w+3),'all')>0.1
%                         mask(o:o+6,p:p+6,q:q+6)=1;
%                     end
%                 end
%             end
%       
%         maskVar=normVar.*mask;
    
    for  m = 1:size(normVar,3)
    imwrite(uint8(Variance(:,:,m)),strcat(fileDirectory,'variance5_all_resize\variance5_normalize_step',num2str(step),'\',fileName1,num2str(m),'.tif'));
    end 

end

%%
% for i = 1:30:10801
%     imwrite(uint8(dataVol(:,:,i)),strcat(fileDirectory,'variance5_all_resize\variance_5_normalize_step0\',fileName1,'_',num2str((i-1)/30+1),'.tif'));
% end 