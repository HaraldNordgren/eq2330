function bitrate_kbps = calculate_bitrate(bits, framerate, frames)

bit_sum = sum(bits(:));

bitrate = bit_sum * framerate / frames;
bitrate_kbps = bitrate / 1000;

end