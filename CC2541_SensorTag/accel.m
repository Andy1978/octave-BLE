len = 300;
m = zeros(len,3);

while(1)
  a = typecast(char_read_hnd(in, out, 0x2d), "int8")'
  m = shift(m, -1);
  m(end, :) = a;
  plot(m)
  grid on
  drawnow
endwhile
