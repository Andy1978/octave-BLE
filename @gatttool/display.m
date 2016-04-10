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

function display (gt)
  printf("%s = gatttool wrapper for GNU Octave\n", inputname(1));
  sp = repmat(' ',1,length(inputname(1))+3);
  printf("%sMAC address      = %s\n", sp, gt.mac);
  printf("%sadapter          = %s\n", sp, gt.adapter);
  printf("%saddr_type        = %s\n", sp, gt.addr_type);
  printf("%spid              = %i\n", sp, gt.pid);
  printf("%sdevice name      = %s\n", sp, gt.device_name);
  ## only for debugging
  printf("%spipe in          = %i\n", sp, gt.in);
  printf("%spipe out         = %i\n", sp, gt.out);
endfunction
