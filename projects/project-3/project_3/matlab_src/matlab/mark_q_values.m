function mark_q_values(Qs, mode, bitrates, psnr)

a = Qs';
b = strcat([mode 'q'], num2str(a));
%b = strcat('q', num2str(a));
c = cellstr(b);

dx = 1.1; dy = 1.1;
text(bitrates+dx, psnr+dy, c);