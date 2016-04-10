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

##reads until timeout [s]
function ret = _read_until_timeout_ (out, timeout)
  ret = "";
  start = time;
  do
    s = fread (out);
    t = time ();
    if (numel (s) > 0)
      ret = strcat (ret, char(s)');
      #numel(s)
      #fflush(stdout);
    else
      printf("%s%4.1fs", char (8(ones(1, 5))), timeout - (t - start));
      fflush (stdout);
      sleep (0.1);
      fclear (out);
    endif
  until ((t - start) >= timeout)
  printf ("\n");
endfunction
