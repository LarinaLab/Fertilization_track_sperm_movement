clear all;
clc;

fileDirectory='E:\Fertilizaton project\070221_IVF_Bright_field_validation_dataset\070221_IVF\IVFafter5min_DIC_288x300_1ms_5x_2min40000f_340fps\';
fileName1='IVFafter5min_DIC_288x300_1ms_5x_2min40000f_340fps_t';
fileName2='.tif';
width=288;
height=300;    
mkdir(strcat(fileDirectory,'correlation_map_step10'));
for frame_num=1:10:4000
    vol(:,:,(frame_num+9)/10)=double(rgb2gray(imread(strcat(fileDirectory,fileName1,num2str(frame_num,'%05g'),fileName2))));
end 
correlation_vol(1:298,1:286,1:399)=0;
for i=1:height-2
    for j=1:width-2
        for t=1:399
            for a=0:2
                for b=0:2
                    first_frame_var=vol(i+a,j+b,t)-mean(vol(i:i+2,j:j+2,t),'all');
                    next_frame_var=vol(i+a,j+b,t+1)-mean(vol(i:i+2,j:j+2,t+1),'all');
                    correlation_vol(i,j,t)= correlation_vol(i,j,t)+first_frame_var*next_frame_var/sqrt(first_frame_var^2+next_frame_var^2);
   
                end
            end
        end
    end
      
end 
    

    
    for  t=1:400
        imwrite(mat2gray(correlation_vol(:,:,t)),strcat(fileDirectory,'correlation_map_step10\correlation_T',num2str(t),'.tif'));
    end 



