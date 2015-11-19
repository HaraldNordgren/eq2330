function plot_histogram(X)

%figure;
figure('visible','off');

unscaled_image = image(X);
unscaled_image_data = unscaled_image.CData;

%scaled_image = imagesc(X);
%scaled_image_data = scaled_image.CData;

%hold on;
figure('visible','on');

%figure
plot(imhist(unscaled_image_data(:,:,2)))
%plot(imhist(scaled_image_data(:,:,2)))