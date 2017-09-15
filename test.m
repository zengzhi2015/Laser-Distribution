%% Loading images
close all
clear
clc
[height,width] = size(imread('ccd_0_1.png'));
angles = [0,1,2,4,8];
indices = [1,2,3,4,5];
ccd_images = zeros(length(angles),length(indices),height,width);
lenz_images = zeros(length(angles),length(indices),height,width);
for r = 1:length(angles)
    for c = 1:length(indices)
        str_ccd = sprintf('ccd_%d_%d.png',angles(r),indices(c));
        str_lenz = sprintf('lenz_%d_%d.png',angles(r),indices(c));
        ccd_images(uint32(r),uint32(c),:,:) = double(imread(str_ccd))/65535;
        lenz_images(uint32(r),uint32(c),:,:) = double(imread(str_lenz))/65535;
    end
end
%% Image Examination - CCD Only
%scrsz = get(groot,'ScreenSize');
%figure('Name','Image Examination - CCD Only','Position',[1 1 scrsz(3)*2/4 scrsz(4)*3/4])
figure('Name','Image Examination - CCD Only x10','Position',[1 1 960 1024])
sub_plot_idx = 0;
for ang_idx = 1:length(angles)
    for image_idx = 1:length(indices)
        image = squeeze(ccd_images(uint32(ang_idx),uint32(image_idx),:,:));
        sub_plot_idx = sub_plot_idx + 1;
        m = length(angles);
        n = length(indices);
        p = sub_plot_idx;
        disp([ang_idx,image_idx,m,n,p])
        %subplot(m,n,p)
        subtightplot(m,n,p,[0.04 0.00]);
        imshow(image*10)
        title(['\theta = ',num2str(angles(ang_idx)), '^o'])
    end
end
%% Image Examination - with Lenz
figure('Name','Image Examination - with Lenz x10','Position',[1 1 960 1024])
sub_plot_idx = 0;
for ang_idx = 1:length(angles)
    for image_idx = 1:length(indices)
        image = squeeze(lenz_images(uint32(ang_idx),uint32(image_idx),:,:));
        sub_plot_idx = sub_plot_idx + 1;
        m = length(angles);
        n = length(indices);
        p = sub_plot_idx;
        disp([ang_idx,image_idx,m,n,p])
        %subplot(m,n,p)
        subtightplot(m,n,p,[0.04 0.00]);
        imshow(image*10)
        title(['\theta = ',num2str(angles(ang_idx)), '^o'])
    end
end
%% Noise Examination - CCD Only
figure('Name','Noise Examination - CCD Only x1000','Position',[1 1 960 1024])
sub_plot_idx = 0;
for ang_idx = 1:length(angles)
    mean_image = squeeze(mean(ccd_images(uint32(ang_idx),:,:,:),2));
    for image_idx = 1:length(indices)
        image = squeeze(ccd_images(uint32(ang_idx),uint32(image_idx),:,:));
        norm_diff = sqrt((image - mean_image).^2);
        sub_plot_idx = sub_plot_idx + 1;
        m = length(angles);
        n = length(indices);
        p = sub_plot_idx;
        disp([ang_idx,image_idx,m,n,p])
        %subplot(m,n,p)
        subtightplot(m,n,p,[0.04 0.00]);
        imshow(norm_diff*1000)
        title(['\theta = ',num2str(angles(ang_idx)), '^o'])
    end
end
%% Noise Examination - with Lenz
figure('Name','Noise Examination - with Lenz x1000','Position',[1 1 960 1024])
sub_plot_idx = 0;
for ang_idx = 1:length(angles)
    mean_image = squeeze(mean(lenz_images(uint32(ang_idx),:,:,:),2));
    for image_idx = 1:length(indices)
        image = squeeze(lenz_images(uint32(ang_idx),uint32(image_idx),:,:));
        norm_diff = sqrt((image - mean_image).^2);
        sub_plot_idx = sub_plot_idx + 1;
        m = length(angles);
        n = length(indices);
        p = sub_plot_idx;
        disp([ang_idx,image_idx,m,n,p])
        %subplot(m,n,p)
        subtightplot(m,n,p,[0.04 0.00]);
        imshow(norm_diff*1000)
        title(['\theta = ',num2str(angles(ang_idx)), '^o'])
    end
end
%%  Difference Examination - CCD Only
figure('Name','Difference Examination - CCD Only x100','Position',[1 1 960 1024])
mean_images = squeeze(mean(ccd_images,2));
sub_plot_idx = 0;
for r = 1:length(angles)
    for c = 1:length(angles)
        norm_diff = sqrt(squeeze(mean_images(r,:,:) - mean_images(c,:,:)).^2);
        sub_plot_idx = sub_plot_idx + 1;
        m = length(angles);
        n = length(angles);
        p = sub_plot_idx;
        disp([r,c,m,n,p])
        %subplot(m,n,p)
        subtightplot(m,n,p,[0.04 0.00]);
        imshow(norm_diff*100)
        title(['\theta = ',num2str(angles(r)), '^o',' v.s. ',num2str(angles(c)), '^o'])
    end
end
%%  Difference Examination - with Lenz
figure('Name','Difference Examination - with Lenz x10','Position',[1 1 960 1024])
mean_images = squeeze(mean(lenz_images,2));
sub_plot_idx = 0;
for r = 1:length(angles)
    for c = 1:length(angles)
        norm_diff = sqrt(squeeze(mean_images(r,:,:) - mean_images(c,:,:)).^2);
        sub_plot_idx = sub_plot_idx + 1;
        m = length(angles);
        n = length(angles);
        p = sub_plot_idx;
        disp([r,c,m,n,p])
        %subplot(m,n,p)
        subtightplot(m,n,p,[0.04 0.00]);
        imshow(norm_diff*10)
        title(['\theta = ',num2str(angles(r)), '^o',' v.s. ',num2str(angles(c)), '^o'])
    end
end