function d = read_distance (disto)

  # Read without triggering
  # (wait until meassure button is pressed)
  d = typecast (read_indication (disto.gt, 0x000e), "single");

endfunction
