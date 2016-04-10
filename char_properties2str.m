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
## @deftypefn  {Function File} {@var{str} = } char_properties2str (@var{v})
## Convert numeric properties to string.
## See BLUETOOTH SPECIFICATION Version 4.1 [Vol 3] page 547
## Chapter GATT 3.3.1.1 Characteristic Properties
## @end deftypefn

function str = char_properties2str (v)

  persistent short_strings = {
      "Broadcast";
      "Read";
      "Write Without Response";
      "Write";
      "Notify";
      "Indicate";
      "Authenticated Signed Writes";
      "Extended Properties" };

  str = "";
  if (v != fix (v) || v<0 || v>255)
    error ("Only integers in the range 0..255 are allowed")
  endif

  if (nargin != 1)
    print_usage ();
  endif

  if (isscalar (v) && v != 0)
    str = sprintf("%s, ", short_strings{find ( fliplr (dec2bin (v, 8) == '1'))});
    str(end-1:end) = [];
  else
    str = arrayfun (@char_properties2str, v, "UniformOutput", false);
  endif

endfunction
