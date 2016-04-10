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
## @deftypefn  {Function File} {} sec_level (@var{gt}, @var{value})
## Set or query security level. Default: low
## Allowed values: low | medium | high
## @end deftypefn

function ret = sec_level (gt, value)

  if (nargin == 1)
    ## query
    fputs (gt.in, "sec-level\n");
    ret = _read_reply_ (gt.out, "sec-level:");
    ## remove LF
    ret(ret == "\n") = [];
  elseif (nargin == 2 && ischar (value))
    fputs (gt.in, sprintf ("sec-level %s\n", value));
    ## No reply, recursive query call
    ret = sec_level (gt);
  else
    print_usage ();
  endif

endfunction
