## Mit dem Leica Disto D110 einige Messwerte gemacht, vom Display
## abgelesen und in den Vektor dist eingetragen.

## Die Werte in reply kommen von gatttool:
# $ sudo hcitool lescan
# LE Scan ...
# C4:3D:E5:CD:0C:75 DISTO 43161227

# $ gatttool -b C4:3D:E5:CD:0C:75 --interactive (hier fehlt random address)
# [C4:3D:E5:CD:0C:75][LE]> connect
# Attempting to connect to C4:3D:E5:CD:0C:75
# Connection successful
# [C4:3D:E5:CD:0C:75][LE]> char-write-req f 0200
# Characteristic value was written successfully
# Indication   handle = 0x000e value: 06 12 94 3e

1;
function ret = str2single(str)
  tmp = sscanf(str, "%x");
  ret = typecast (uint8(tmp), "single");
endfunction

# vom Display abgelesen [m]
dist = [0.349 0.374 0.737 0.822 3.125 0.959 1.246 1.478 2.464 2.095 9.765];

# handle 0x000e, siehe oben
reply ={"05 a3 b2 3e",
        "d2 6f bf 3e",
        "08 ac 3c 3f",
        "41 82 52 3f",
        "47 03 48 40",
        "cf 66 75 3f",
        "09 8a 9f 3f",
        "b8 1e bd 3f",
        "bb b8 1d 40",
        "65 19 06 40",
        "42 3e 1c 41"
        };

reply_single = zeros (numel(dist), 1);
[dist, i] = sort(dist);
for k=1:numel(dist)
  reply_single(k) = str2single (reply {i(k)});
endfor

plot(dist, reply_single, "-o")
title ("handle 0x000e vs. Display-Entfernung")
xlabel ("Entfernung vom Display abgelesen in m")
ylabel ("handle 0x000e als single, little endian")
grid
