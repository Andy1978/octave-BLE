## -*- texinfo -*-
## @deftypefn  {Function File} {} d110 (@var{adapter}, @var{mac})
## Connect to Disto D110
## @end deftypefn

function ret = d110 (adapter, mac)
  if (nargin != 2)
    print_usage ();
  endif

  disto.gt = gatttool (adapter, mac, "random");

  # Indication for distance
  assert (char_write_req (disto.gt, 0x0f, 0x0200));

  # Indication for Bluetooth button
  #assert (char_write_req (disto.gt, 0x12, 0x0200));

  ret = class (disto, "d110");
endfunction
