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

function ret = _read_reply_ (out, reply_prefix)
  ## wait for reply
  EAGAIN = errno ("EAGAIN");
  done = false;
  do
    s = fgets (out);
    if (ischar (s))
      #fputs (stdout, ["[read_reply OUT:]",s]);
      idx = strfind(s, reply_prefix);
      if (idx)
        ret = s(idx+numel(reply_prefix)+1:end);
        done = true;
      endif
    else  #(errno () == EAGAIN)
      #disp("EAGAIN")
      sleep (0.1);
      fclear (out);
#    else
#      error("unexpected error %i", errno ());
    endif
  until (done)
endfunction
