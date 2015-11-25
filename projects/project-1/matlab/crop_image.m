function im_cropped = crop_image(im, pad)

im_cropped = im(1+pad(1):end-pad(1), 1+pad(2):end-pad(2));