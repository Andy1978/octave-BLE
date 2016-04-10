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

function status = char_write_req (gt, handle, value)
  value_str = dec2hex (value);
  ## make len multiple of bytes
  value_str = dec2hex (value, ceil (numel (value_str)/2) * 2);
  tmp = sprintf ("char-write-req %x %s\n", handle, value_str);
  fputs (gt.in, tmp);

  ## Known reply:
  ## Characteristic value was written successfully
  ## Error: Characteristic Write Request failed: Attribute can't be written

  reply = _read_reply_ (gt.out, "Characteristic");
  status = any (strfind (reply, "value was written successfully"));

endfunction
