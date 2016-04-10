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

## -*- texinfo -*-
## @deftypefn  {Function File} {} mtu (@var{gt}, @var{value})
## Exchange MTU for GATT/ATT. MTU exchange can only occur once per connection,
## @end deftypefn

function mtu (gt, value)

  if (nargin != 1)
    print_usage ();
  endif

  if (mtu < 23)
    ## Is this device dependent?
    error ("Invalid value. Minimum MTU size is 23");
  endif

  cmd = sprintf ("mtu %02x", value);
  fputs (gt.in, strcat (cmd, "\n"));
  printf ('Waiting for reply to "%s":     0/    0', cmd);
  reply = _read_until_cmd_ (gt.out, cmd);
  disp (reply)
  error ("Parsing reply not yet implemented!")

endfunction
