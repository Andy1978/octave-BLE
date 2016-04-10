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
## @deftypefn  {Function File} {[@var{start_grp}, @var{end_grp}, @var{uuid}]} primary (@var{gt}, @var{uuid})
## Primary Service Discovery
## @end deftypefn

function [start_grp, end_grp, ret_uuid] = primary (gt, uuid)

  if (nargin == 1)

    ## Discover all Services, a typical reply is
    ## [34:B1:F7:D4:F2:E7][LE]> primary
    ## attr handle: 0x0001, end grp handle: 0x000b uuid: 00001800-0000-1000-8000-00805f9b34fb
    ## attr handle: 0x000c, end grp handle: 0x000f uuid: 00001801-0000-1000-8000-00805f9b34fb
    ## attr handle: 0x0010, end grp handle: 0x0022 uuid: 0000180a-0000-1000-8000-00805f9b34fb
    ## attr handle: 0x0023, end grp handle: 0x002a uuid: f000aa00-0451-4000-b000-000000000000
    ## ....

    cmd = "primary";
    fputs (gt.in, strcat (cmd, "\n"));
    printf ('Waiting for reply to "%s":     0/    0', cmd);
    reply = _read_until_cmd_ (gt.out, cmd);

    kwords = {"attr handle"; "end grp handle"; "uuid"};
    len = [6, 6, 36];
    ret = _parse_reply_(reply, kwords, len);
    start_grp = str2num (cell2mat (ret.attr_handle));
    end_grp   = str2num (cell2mat (ret.end_grp_handle));
    ret_uuid  = cell2mat (ret.uuid);

  elseif (nargin == 2)

    ## Discover only start/end for specific uuid, typical reply
    ## [34:B1:F7:D4:F2:E7][LE]> primary 1800
    ## Starting handle: 0x0001 Ending handle: 0x000b

    ## It's also possible to get an error if there is no such uuid
    ## Error: No service UUID found

    cmd = sprintf ("primary %s", uuid);
    fputs (gt.in, strcat (cmd, "\n"));
    printf ('Waiting for reply to "%s":     0/    0', cmd);
    reply = _read_until_cmd_ (gt.out, cmd);

    if ( any (strfind (reply, "No service UUID found")))
      error ('No service with UUID = "%s" found', uuid);
    endif

    kwords = {"Starting handle"; "Ending handle"};
    len = [6, 6];
    ret = _parse_reply_(reply, kwords, len);
    start_grp = str2num (cell2mat (ret.Starting_handle));
    end_grp   = str2num (cell2mat (ret.Ending_handle));
    ret_uuid  = uuid;
  else
    print_usage ();
  endif

endfunction
