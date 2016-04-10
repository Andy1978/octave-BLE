# permanent Entfernung messen und per eSpeak ausgeben

addpath (canonicalize_file_name ("../"))

## Mit dem Leica Disto D110 verbinden
if (!exist ("mydisto", "var"))
  system ("killall gatttool");
  mydisto = d110 ("hci0", "C4:3D:E5:CD:0C:75")
  laser (mydisto, 0);
endif

function ret = dist2de (d, n)
  ret = strrep (sprintf ( strcat("%.", num2str (n), "f"), d), ".", ",");
  ret = strrep (ret, "-", "minus");
endfunction

while (isempty (kbhit (1)))
  empty_read(mydisto, 0.1)
  d = capture_distance (mydisto);
  cmd = sprintf ("espeak -v german-mbrola-5 \"Entfernung=%s\"", dist2de(d, 2))
  system (cmd);
endwhile
