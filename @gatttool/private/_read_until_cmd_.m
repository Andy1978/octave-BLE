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

## read until minimum length for command is reached

function ret = _read_until_cmd_ (out, cmd)

  if (ischar (cmd))
    ## The MAC prompt "[34:B1:F7:D4:F2:E7][LE]> " is 36 bytes long (with color escape sequences).
    ## We don't know how much reply we get but it should be at least 36 * 2 + numel(cmd) + 1 bytes long

    min_len = 36 * 2 + numel(cmd) + 1;
    ret = _read_until_length_ (out, min_len);
  else
    print_usage ();
  endif
endfunction
