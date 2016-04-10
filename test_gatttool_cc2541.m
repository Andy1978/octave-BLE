## gatttool wrapper mit CC2541 als device testen.

## Bedienung:
## $ sudo hciconfig hci0 up
## $ sudo hcitool lescan
## seitlichen Knopf am SensorTag drücken, MAC ablesen
## LE Scan ...
## 34:B1:F7:D4:F2:E7 SensorTag

more off;
#debug_on_error (1);

#addpath (canonicalize_file_name ("../"))

if (!exist ("mygt", "var"))
  system ("killall gatttool");
  mygt = gatttool ("hci0", "34:B1:F7:D4:F2:E7", "public")
endif

## Discover device
#[service_start_grp, service_end_grp, service_uuid] = primary (mygt);

#nun die characteristics einfüttern

tic
[handle, char_properties, char_value_handle, uuid] = characteristics (mygt);
toc

%~
%~ tic
%~ [handle, uuid] = char_desc (mygt);
%~ toc
%~
%~ [start_grp, end_grp, ret_uuid] = primary (mygt, "180a");
%~ ## TODO: check error message with wrong uuid like 180b
%~
%~ [handle, char_properties, char_value_handle, uuid] = characteristics (mygt, 110);
%~ [handle, char_properties, char_value_handle, uuid] = characteristics (mygt, 110, 118);
%~ [handle, char_properties, char_value_handle, uuid] = characteristics (mygt, 1, 100, "2a00");
%~
%~ [handle, uuid] = char_desc (mygt, 120);
%~ [handle, uuid] = char_desc (mygt, 120, 122);
%~
%~ assert (sec_level (mygt), "low")
%~ assert (sec_level (mygt, "medium"), "medium");
%~ assert (sec_level (mygt, "high"), "high");
%~ assert (sec_level (mygt, "low"), "low");




#close (mygt)
