clear all;
clc;

fileDirectory='D:\Kohei\';
mkdir(strcat(fileDirectory,'sv_for_video_frame_variance'));
fileName='IVF-After20min_20x_992x1000_40fs.mov';
var_num=5;
height=1000;
width=992;
v = VideoReader(strcat(fileDirectory,fileName));


for k=0:8
    var_vol(1:height,1:width,:)=0;
    step=2.^k;
    series_num=1000;
    while series_num<1500
    frame = read(v,series_num);
    frame=double(rgb2gray(frame));
    var_vol(:,:,series_num-999)=frame;
    series_num=series_num+step;
    end 

    mkdir(strcat(fileDirectory,'sv_for_video_frame_variance\variance_5_step',num2str(step)));
    Variance(1:height,1:width,:)=0;      

    for i = 1:size(var_vol,3)-4
        Variance(:,:,i)=var(var_vol(:,:,i:i+4),0,3);
        imwrite(uint8(255*mat2gray(Variance(:,:,i))),strcat(fileDirectory,'sv_for_video_frame_variance\variance_5_step',num2str(step),'\','IVF-After20min_20x_992x1000_40fs_',num2str(i),'.tif'));
    end
   
    
end
