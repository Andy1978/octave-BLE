## alle Handles des Leica Disto D110 auslesen
## um dann ein diff zu machen.

## Bedienung:
## $ sudo hciconfig hci0 up
## $ sudo hcitool lescan
## Disto D110 einschalten, MAC ablesen
## LE Scan ...
## C4:3D:E5:CD:0C:75 DISTO 43161227

more off

MAC = 'C4:3D:E5:CD:0C:75';  # Leica Disto D110

disto = gatttool (MAC)

# handles 0x01 bis 0x1E lesen

n = 0x1E;
data = cell(n, 1);
for h = 1:n
  tmp = char_read_hnd(disto, h);
  data{h} = tmp;
  disp(tmp)
endfor

save("leica_out.log", "data")

close (disto)
