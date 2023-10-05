clear all;
clc;

fileDirectory='D:\Kohei\082721 IVF\082721_IVF3min_150x150_0.25x0.25_TimeInterval0.27s\';
fileName1='image_T';
fileName2='.tif';

 

for series_num=1:23
    baseNumber=200*(series_num-1);
    mkdir(strcat(fileDirectory,'var5sep',num2str(baseNumber)));
    for i=1:200
        for fileNumber=1:150
           copyfile(strcat(fileDirectory,'volume_variance_5\',fileName1,num2str(i+baseNumber),'_Z',num2str(fileNumber),fileName2),strcat(fileDirectory,'var5sep',num2str(baseNumber),'\',fileName1,num2str(i+baseNumber),'_Z',num2str(fileNumber),'.tif'));
        end 
    end
end






