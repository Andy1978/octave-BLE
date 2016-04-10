# octave-BLE
BLE (bluetooth low energy) functions for GNU Octave, for example a wrapper around gatttool






# hardware specific hints

If lsusb tells you, that you have a
```
ID 0a5c:21e8 Broadcom Corp. BCM20702A0 Bluetooth 4.0
```

Then you may download the windoze 8 driver (version 12.0.0.8030) from  von http://www.iogear.com/support/dm/driver/GBU521#display

I've the searched GBU321_421_521_Win8.1_v12.0.0.8030/Win64/bcbtums-win8x64-brcm.inf for hex files and finally found BCM20702A1_001.002.014.1315.1338.hex
the use hex2hcd
