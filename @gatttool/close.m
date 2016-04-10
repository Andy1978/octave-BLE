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

function close (gt)
  fputs (gt.in, "disconnect\n");
  _read_until_timeout_ (gt.out, 0.5);
  fputs (gt.in, "exit\n");
  _read_until_timeout_ (gt.out, 1.0);
  fclose (gt.in);
  fclose (gt.out);
  #gt.pid
  #[err, msg] = kill(gt.pid, SIG.TERM)
  [PID, STATUS, MSG] = waitpid (gt.pid);
  if (PID < 0)
    error (MSG);
  endif
endfunction
