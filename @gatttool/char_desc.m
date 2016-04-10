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
## @deftypefn  {Function File} {[@var{handle}, @var{uuid}]} char_desc (@var{gt}, @var{start_hnd}, @var{end_hnd})
## Characteristics Descriptor Discovery
## @end deftypefn

function [handle, uuid] = char_desc (gt, start_hnd, end_hnd)
  timeout = 0;
  if (nargin == 1)
    ## Read all characteristic descriptors, this may take some time
    cmd = "char-desc";
  elseif (nargin == 2 && isscalar (start_hnd))
    ## Read from start_hnd
    cmd = sprintf ("char-desc %x", start_hnd);
  elseif (nargin == 3 && isscalar (start_hnd) && isscalar (end_hnd))
    ## Read range
    cmd = sprintf ("char-desc %x %x", start_hnd, end_hnd);
  else
    print_usage ();
  endif

  fputs (gt.in, strcat (cmd, "\n"));
  printf ('Waiting for reply to "%s":     0/    0', cmd);
  reply = _read_until_cmd_ (gt.out, cmd);

  ## Known possible error messages
  ## Error: Discover descriptors failed: Invalid handle
  ## Error: Discover descriptors failed: No attribute found within the given range

  if ( any (strfind (reply, "Error")))
    error (reply);
  endif

  kwords = {"handle"; "uuid"};
  len = [6, 36];
  ret = _parse_reply_(reply, kwords, len);

  handle            = str2num (cell2mat (ret.handle));
  uuid              = cell2mat (ret.uuid);

endfunction
