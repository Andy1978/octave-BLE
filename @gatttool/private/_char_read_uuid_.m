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

function ret = _char_read_uuid_ (in, out, uuid)
  reply_prefix = "value:";
  tmp = sprintf ("char-read-uuid %s\n", uuid);
  fputs (in, tmp);

  reply = _read_reply_ (out, reply_prefix);
  ret = uint8 ( sscanf (reply, "%x"))';
endfunction
