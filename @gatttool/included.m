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
## @deftypefn  {Function File} {[@var{start_grp}, @var{end_grp}, @var{uuid}]} included (@var{gt}, [@var{start_hnd}, [@var{end_hnd}]])
## Find Included Services
## @end deftypefn

function ret = included (gt, start_hnd, end_hnd)

  if (nargin == 1)
    ## Read all
    cmd = "included";
  elseif (nargin == 2 && isscalar (start_hnd))
    ## Read included services from start_hnd
    cmd = sprintf ("included %x", start_hnd);
  elseif (nargin == 3 && isscalar (start_hnd) && isscalar (end_hnd))
    ## Read included services from start_hnd to end_hnd
    cmd = sprintf ("included %x %x", start_hnd, end_hnd);
  else
    print_usage ();
  endif

  fputs (gt.in, strcat (cmd, "\n"));
  printf ('Waiting for reply to "%s":     0/    0', cmd);
  reply = _read_until_cmd_ (gt.out, cmd);

  ## Known possible replies:
  ## No included services found for this range

  ## TODO: I don't own a device which has included services
  ## please implement me!

  disp(reply)
  error ("Parsing not yet implemented!")

endfunction
