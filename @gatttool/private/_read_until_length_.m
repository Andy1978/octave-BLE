## Copyright (C) 2016 Andreas Weber <andy.weber.aw@gmail.com>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http:##www.gnu.org/licenses/>.

## read until at least len bytes were read

function ret = _read_until_length_ (out, len)

  if (!isscalar (len))
    print_usage ();
  endif

  ## 10s timeout, I don't know a device which needs longer
  timeout = 10;
  ret = "";
  start = time;
  do
    s = fread (out);
    t = time ();
    if (numel (s) > 0)
      ret = strcat (ret, char(s)');
    else
      sleep (0.1);
      fclear (out);
    endif
    ## Display received bytes
    printf("%s%5i/%5i", char (8(ones(1, 11))), numel (ret), len);
    fflush (stdout);
    if ((t - start) >= timeout)
      error ("Timeout after %is. Read %i bytes from requested %i so far", timeout, numel (ret), len);
    endif
  until (numel (ret) >= len)
  printf ("\n");
endfunction
