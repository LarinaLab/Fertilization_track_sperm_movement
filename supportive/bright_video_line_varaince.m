clear all;
clc;

fileDirectory='D:\Kohei\';
mkdir(strcat(fileDirectory,'sv_for_video_frame_variance'));
fileName='IVF-After20min_20x_992x1000_40fs.mov';
var_num=7;
height=1000;
width=992;
v = VideoReader(strcat(fileDirectory,fileName));


for k=1:8
    step=2.^k;
    series_num=1000;
    while series_num<1500
    frame = read(v,series_num);
    frame=double(rgb2gray(frame));


    mkdir(strcat(fileDirectory,'sv_for_video\variance_7_step',num2str(step)));

    Variance(1:height-var_num+1,1:width)=0;      

        for i = 1:height-var_num+1
            Variance(i,:)=var(frame(i:i+var_num-1,:),0,1);
        end
    imwrite(uint8(255*mat2gray(Variance)),strcat(fileDirectory,'sv_for_video\variance_7_step',num2str(step),'\','IVF-After20min_20x_992x1000_40fs_',num2str(series_num),'.tif'));
    series_num=series_num+step;
    end 

end
