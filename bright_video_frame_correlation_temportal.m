clear all;
clc;

fileDirectory='E:\Fertilizaton project\070221_IVF_Bright_field_validation_dataset\070221_IVF\IVFafter5min_DIC_288x300_1ms_5x_2min40000f_340fps\';
fileName1='IVFafter5min_DIC_288x300_1ms_5x_2min40000f_340fps_t';
fileName2='.tif';
width=288;
height=300;    
mkdir(strcat(fileDirectory,'temporal_correlation_map'));
for frame_num=1:100:40000
    vol(:,:,(frame_num+99)/100)=double(rgb2gray(imread(strcat(fileDirectory,fileName1,num2str(frame_num,'%05g'),fileName2))));
end 
temp_correlation_vol(1:298,1:286,1:40)=0;
for i=1:height-2
    for j=1:width-2
        for t=1:10:400
            for a=0:2
                for b=0:2
                    temp_correlation=corrcoef(vol(i,j,t:t+9),vol(i+a,j+b,t:t+9));
                    temp_correlation_vol(i,j,(t+9)/10)= temp_correlation_vol(i,j,(t+9)/10)+temp_correlation(2,1)/9;
   
                end
            end
        end
    end
      
end 
    

    
    for  t=1:40
        imwrite(mat2gray(temp_correlation_vol(:,:,t)),strcat(fileDirectory,'temporal_correlation_map\correlation_T',num2str(t),'.tif'));
    end 



