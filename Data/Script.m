close all;
clear all;
%dbstop if naninf

%% Global parameters
input_path = '../food/';
output_path = [input_path 'Results/'];
if exist([input_path 'Results/']) == 0
    mkdir([input_path 'Results/'])
end
range = 420:10:1000;

%% Load registerred images
% BG filter + visible polarimetric filter
RGB_filtre_vis_BG_0=(im2double(imread([input_path 'Raw/RGB_filtre_vis_BG_0_aligned.tif'])));
RGB_filtre_vis_BG_45=(im2double(imread([input_path 'Raw/RGB_filtre_vis_BG_45_aligned.tif'])));
RGB_filtre_vis_BG_90=(im2double(imread([input_path 'Raw/RGB_filtre_vis_BG_90_aligned.tif'])));
RGB_filtre_vis_BG_135=(im2double(imread([input_path 'Raw/RGB_filtre_vis_BG_135_aligned.tif'])));

% Y filter + visible polarimetric filter
RGB_filtre_vis_Y_0=(im2double(imread([input_path 'Raw/RGB_filtre_vis_Y_0_aligned.tif'])));
RGB_filtre_vis_Y_45=(im2double(imread([input_path 'Raw/RGB_filtre_vis_Y_45_aligned.tif'])));
RGB_filtre_vis_Y_90=(im2double(imread([input_path 'Raw/RGB_filtre_vis_Y_90_aligned.tif'])));
RGB_filtre_vis_Y_135=(im2double(imread([input_path 'Raw/RGB_filtre_vis_Y_135_aligned.tif'])));

% nir polarimetric filter
NIR_filtre_nir_0=(im2double(imread([input_path 'Raw/NIR_filtre_nir_0_aligned.tif'])));
NIR_filtre_nir_45=(im2double(imread([input_path 'Raw/NIR_filtre_nir_45_aligned.tif'])));
NIR_filtre_nir_90=(im2double(imread([input_path 'Raw/NIR_filtre_nir_90_aligned.tif'])));
NIR_filtre_nir_135=(im2double(imread([input_path 'Raw/NIR_filtre_nir_135_aligned.tif'])));

% Display images
figure;
subplot(341);imshow(RGB_filtre_vis_BG_0);title('RGB BG 0');subplot(342);imshow(RGB_filtre_vis_BG_45);title('RGB BG 45');subplot(343);imshow(RGB_filtre_vis_BG_90);title('RGB BG 90');subplot(344);imshow(RGB_filtre_vis_BG_135);title('RGB BG 135');
subplot(345);imshow(RGB_filtre_vis_Y_0);title('RGB Y 0');subplot(346);imshow(RGB_filtre_vis_Y_45);title('RGB Y 45');subplot(347);imshow(RGB_filtre_vis_Y_90);title('RGB Y 90');subplot(348);imshow(RGB_filtre_vis_Y_135);title('RGB Y 135');
subplot(349);imshow(NIR_filtre_nir_0);title('NIR 0');subplot(3,4,10);imshow(NIR_filtre_nir_45);title('NIR 45');subplot(3,4,11);imshow(NIR_filtre_nir_90);title('NIR 90');subplot(3,4,12);imshow(NIR_filtre_nir_135);title('NIR 135');

%% Load Multispectral images
for i=1:6
    multispectral_0(:,:,i) = im2double(imread([input_path 'Multispectral/multispectral_0.tif'],i));
    multispectral_45(:,:,i) = im2double(imread([input_path 'Multispectral/multispectral_45.tif'],i));
    multispectral_90(:,:,i) = im2double(imread([input_path 'Multispectral/multispectral_90.tif'],i));
    multispectral_135(:,:,i) = im2double(imread([input_path 'Multispectral/multispectral_135.tif'],i));
end

%% Display
figure;
subplot(461);imshow(multispectral_0(:,:,1));title('MS Band 1 0deg');subplot(462);imshow(multispectral_0(:,:,2));title('MS Band 2 0deg');subplot(463);imshow(multispectral_0(:,:,3));title('MS Band 3 0deg');subplot(464);imshow(multispectral_0(:,:,4));title('MS Band 4 0deg');subplot(465);imshow(multispectral_0(:,:,5));title('MS Band 5 0deg');subplot(466);imshow(multispectral_0(:,:,6));title('MS Band 6 0deg');
subplot(467);imshow(multispectral_45(:,:,1));title('MS Band 1 45deg');subplot(468);imshow(multispectral_45(:,:,2));title('MS Band 2 45deg');subplot(469);imshow(multispectral_45(:,:,3));title('MS Band 3 45deg');subplot(4,6,10);imshow(multispectral_45(:,:,4));title('MS Band 4 45deg');subplot(4,6,11);imshow(multispectral_45(:,:,5));title('MS Band 5 45deg');subplot(4,6,12);imshow(multispectral_45(:,:,6));title('MS Band 6 45deg');
subplot(4,6,13);imshow(multispectral_90(:,:,1));title('MS Band 1 90deg');subplot(4,6,14);imshow(multispectral_90(:,:,2));title('MS Band 2 90deg');subplot(4,6,15);imshow(multispectral_90(:,:,3));title('MS Band 3 90deg');subplot(4,6,16);imshow(multispectral_90(:,:,4));title('MS Band 4 90deg');subplot(4,6,17);imshow(multispectral_90(:,:,5));title('MS Band 5 90deg');subplot(4,6,18);imshow(multispectral_90(:,:,6));title('MS Band 6 90deg');
subplot(4,6,19);imshow(multispectral_135(:,:,1));title('MS Band 1 135deg');subplot(4,6,20);imshow(multispectral_135(:,:,2));title('MS Band 2 135deg');subplot(4,6,21);imshow(multispectral_135(:,:,3));title('MS Band 3 135deg');subplot(4,6,22);imshow(multispectral_135(:,:,4));title('MS Band 4 135deg');subplot(4,6,23);imshow(multispectral_135(:,:,5));title('MS Band 5 135deg');subplot(4,6,24);imshow(multispectral_135(:,:,6));title('MS Band 6 135deg');

%% Compute Polarimetric images
load 'A.mat'
for i = 1:size(multispectral_0,3)
    [ multispectral_S0(:,:,i),multispectral_S1(:,:,i),multispectral_S2(:,:,i),multispectral_DOLP(:,:,i),multispectral_AOLP(:,:,i),multispectral_RGBpol(:,:,:,i),multispectral_sRGB_HSV(:,:,:,i),multispectral_HSV(:,:,:,i),multispectral_Unpol(:,:,i)] = Process_images_stokes( multispectral_0(:,:,i),multispectral_45(:,:,i),multispectral_90(:,:,i),multispectral_135(:,:,i),'yes',A(:,:,i)/(max(max(A(:,:,i)))));
end

%% Reflectance plot
load 'M.mat'
pixel_coor = [100 100];
camera_responses(1,:) = multispectral_Unpol(100,100,:);
reflectance = M' * camera_responses';
figure;
plot(420:10:1000,reflectance);

