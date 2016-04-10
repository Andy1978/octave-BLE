## Klasse d110 testen

addpath ("../")

if (!exist ("mydisto", "var"))
  system ("killall gatttool");
  mydisto = d110 ("hci0", "C4:3D:E5:CD:0C:75")
endif

capture_distance (mydisto)

for k=1:5
  laser (mydisto, 1);
  sleep (0.3)
  laser (mydisto, 0);
  sleep (0.3)
endfor

capture_distance (mydisto)
