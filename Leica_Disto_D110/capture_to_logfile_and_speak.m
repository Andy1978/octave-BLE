## Entfernungsmessung manuell über Taste an D110 triggern,
## in Logfile speichern und per eSpeak ausgeben

addpath (canonicalize_file_name ("../"))

## Mit dem Leica Disto D110 verbinden
if (!exist ("mydisto", "var"))
  system ("killall gatttool");
  mydisto = d110 ("hci0", "C4:3D:E5:CD:0C:75")
  laser (mydisto, 0);
  fflush (stdout);
endif

function ret = dist2de (d, n)
  ret = strrep (sprintf ( strcat("%.", num2str (n), "f"), d), ".", ",");
  ret = strrep (ret, "-", "minus");
endfunction

fn = "disto_captures.log"
## Werte in Matrix anhängen
if (exist (fn, "file"))
  load (fn)
else
  data = [];
endif

unwind_protect
  while (1)
    d = read_distance (mydisto);
    data = cat(1, data, [now, d]);
    save (fn, "data");
    cmd = sprintf ("espeak -v german-mbrola-5 \"Entfernung %s\"", dist2de(d, 2))
    fflush (stdout);
    system (cmd);
  endwhile
unwind_protect_cleanup
  close (mydisto);
  clear mydisto
end_unwind_protect

