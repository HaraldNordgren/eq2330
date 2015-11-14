function show_components(path)

%X = imread('4748167.jpg');
X = imread(path);

for i = 1:3
    subplot(2,3,i), image(X(:,:,i))
    subplot(2,3,i+3), imagesc(X(:,:,i))
end

colormap gray(256)
end