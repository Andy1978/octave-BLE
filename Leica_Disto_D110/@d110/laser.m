function laser (disto, state)

  if(! isscalar (state))
    print_usage ();
  endif

  if (state == 1)
    value = 0x6F;
  elseif (state == 0)
    value = 0x70;
  else
    error ("state not allowed");
  endif

  ok = char_write_req (disto.gt, 0x14, value);
  if (! ok)
    error ("write failed");
  endif

endfunction
