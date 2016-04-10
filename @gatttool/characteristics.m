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
## @deftypefn  {Function File} {[@var{handle}, @var{char_properties}, @var{char_value_handle}, @var{uuid}]} characteristics (@var{gt}, @var{start_hnd}, @var{end_hnd}, @var{uuid})
## Characteristics Discovery
## @end deftypefn

function [handle, char_properties, char_value_handle, uuid] = characteristics (gt, start_hnd, end_hnd, uuid)

  if (nargin == 1)
    ## Read all characteristics, this may take some time
    cmd = "characteristics";
  elseif (nargin == 2 && isscalar (start_hnd))
    ## Read all characteristics beginning from start_hnd
    cmd = sprintf ("characteristics %x", start_hnd);
  elseif (nargin == 3 && isscalar (start_hnd) && isscalar (end_hnd))
    ## Read characteristics start_hnd to end_hnd
    cmd = sprintf ("characteristics %x %x", start_hnd, end_hnd);
  elseif (nargin == 4 && isscalar (start_hnd) && isscalar (end_hnd) && ischar (uuid))
    ## Read characteristics start_hnd to end_hnd with uuid
    cmd = sprintf ("characteristics %x %x %s", start_hnd, end_hnd, uuid);
  else
    print_usage ();
  endif

  fputs (gt.in, strcat (cmd, "\n"));
  printf ('Waiting for reply to "%s":     0/    0', cmd);
  reply = _read_until_cmd_ (gt.out, cmd);

  ## Known possible error messages
  ## Error: Discover all characteristics failed: Invalid handle
  ## Error: Discover all characteristics failed: No attribute found within the given range

  if ( any (strfind (reply, "Error")))
    error (reply);
  endif

  kwords = {"handle"; "char properties"; "char value handle"; "uuid"};
  len = [6, 4, 6, 36];
  ret = _parse_reply_(reply, kwords, len);

  handle            = str2num (cell2mat (ret.handle));
  char_properties   = str2num (cell2mat (ret.char_properties));
  char_value_handle = str2num (cell2mat (ret.char_value_handle));
  uuid              = cell2mat (ret.uuid);

  ## TODO: char_properties aufschlüsseln
  #char_properties2str....
  ## getrennte Helperfunktion dafür?

endfunction
