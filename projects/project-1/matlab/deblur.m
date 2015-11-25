function im_deblurred = deblur(im_blurry, h, noise_var)

im_blurry = double(im_blurry);
estimated_nsr = noise_var / var(im_blurry(:));

%Handles sharp edges
im_blurry_tapered = edgetaper(im_blurry, h);

im_deblurred = deconvwnr(im_blurry_tapered, h, estimated_nsr);

end