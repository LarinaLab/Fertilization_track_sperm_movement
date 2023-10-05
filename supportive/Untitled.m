fileDirectory='D:\Kohei\071621_IVF\IVF2min_DIC_288x300_1ms_5x_148s50000f_340fps\';
fileName1='IVF2min_DIC_288x300_1ms_5x_148s50000f_340fps_t';
fileName2='.tif';


for i = 1:30:7501
    A=rgb2gray(imread(strcat(fileDirectory,fileName1,num2str(i,'%05g'),fileName2)));
    imwrite(A,strcat(fileDirectory,'variance5_all\','step0_T',num2str((i-1)/30+1),'.tif'));
end 