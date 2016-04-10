## CC2541 in einer Schleife pollen und Daten visualisieren

## Bedienung:
## $ sudo hciconfig hci0 up
## $ sudo hcitool lescan
## seitlichen Knopf am SensorTag drücken, MAC ablesen
## LE Scan ...
## 34:B1:F7:D4:F2:E7 SensorTag

more off;
#debug_on_error (1);

addpath (canonicalize_file_name ("../"))
MAC = '34:B1:F7:D4:F2:E7';

if (!exist ("mygt", "var"))
  system ("killall gatttool");
  mygt = gatttool ("hci0", MAC, "public")
endif

firmware_revision = char (char_read_hnd (mygt, 24))

# IR aktivieren
char_write_cmd (mygt, 41, 1);

# Beschleunigungsmesser aktivieren
char_write_cmd (mygt, 49, 1);

# Conversion algorithm for target temperature
function tObj = calcTmpTarget(T_amb, V_obj)
  Tdie2 = T_amb + 273.15;

  ##TODO: mal genau kalibrieren
  S0 = 6.4e-14;            # Calibration factor
  #S0 = 5.9e-14;            # Calibration factor

  a1 = 1.75e-3;
  a2 = -1.678e-5;
  b0 = -2.94e-5;
  b1 = -5.7e-7;
  b2 = 4.63e-9;
  c2 = 13.4;
  Tref = 298.15;
  S = S0*(1+a1*(Tdie2 - Tref)+a2*((Tdie2 - Tref).^2));
  Vos = b0 + b1*(Tdie2 - Tref) + b2*((Tdie2 - Tref).^2);
  fObj = (V_obj - Vos) + c2*((V_obj - Vos).^2);
  tObj = ((Tdie2.^4) + (fObj/S)).^(1/4);
  tObj = (tObj - 273.15);
endfunction

unwind_protect
  len = 100;
  m = zeros(len, 4);

  while (1)
    ## IR Sensor
    ir = char_read_hnd (mygt, 37);
    object_raw = double (typecast(ir(1:2), "int16"));
    ambient_raw = double(typecast(ir(3:4), "int16"));

    T_amb = ambient_raw/128.0;
    # sbos518c.pdf page 8; LSB is 156.25 nV
    V_obj = object_raw * 156.25e-9;
    T_obj = calcTmpTarget(T_amb, V_obj);

    ## Beschleunigungen
    ## Range +/- 2g pro Byte -> /64
    a = double(typecast(char_read_hnd (mygt, 45), "int8"))/64;

    m = shift(m, -1);
    m(end, 1) = T_amb;
    m(end, 2) = T_obj;
    m(end, 3) = a(1)*10;
    m(end, 4) = a(2)*10;
    #m
    plot(m, "linewidth", 3)
    legend("ambient Temp.", "object Temp.", "acc. X*10", "acc. Y*10");
    set(gca, "ylim", [-10 30])
    grid on
    drawnow

  endwhile
unwind_protect_cleanup
  close (mygt);
  clear mygt
end_unwind_protect
