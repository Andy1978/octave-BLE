## gatttool wrapper mit Leica Disto D110 als device testen.

## Bedienung:
## $ sudo hciconfig hci0 up
## Disto D110 einschalten
## $ sudo hcitool lescan
## LE Scan ...
## C4:3D:E5:CD:0C:75 DISTO 43161227

more off;
#debug_on_error (1);

#addpath (canonicalize_file_name ("../"))

if (!exist ("mygt", "var"))
  system ("killall gatttool");
  mygt = gatttool ("hci0", "C4:3D:E5:CD:0C:75", "random")

  # Indication for distance
  assert (char_write_req (mygt, 0x0f, 0x0200));

  # Indication for Bluetooth button
  assert (char_write_req (mygt, 0x12, 0x0200));
endif

## Discover device
tic
[service_start_grp, service_end_grp, service_uuid] = primary (mygt);
toc

tic
[handle, char_properties, char_value_handle, uuid] = characteristics (mygt);
toc

tic
[handle, uuid] = char_desc (mygt);
toc

# Start one measurement
assert (char_write_req (mygt, 0x14, 0x67));
d = typecast (read_indication (mygt, 0x000e), "single")
# always 00 00
read_indication(mygt, 0x0011);

close (mygt)
