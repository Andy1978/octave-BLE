function d = capture_distance (disto)

  # Start one measurement
  assert (char_write_req (disto.gt, 0x14, 0x67));
  d = typecast (read_indication (disto.gt, 0x000e), "single");

endfunction
