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
## @deftypefn  {Function File} {} gatttool (@var{adapter}, @var{mac}, @var{addr_type})
## Create bidirectional pipe to gatttool and connect to
## BLE/Smart/Bluetooth 4.0 device with address @var{mac}.
## @end deftypefn

function ret = gatttool (adapter, mac, addr_type)
  if (nargin != 3)
    print_usage ();
  endif

  if (! strcmp (addr_type, "public") && ! strcmp (addr_type, "random"))
    error ('Valid values for addr_type are "public" or "random"');
  endif

  if (ischar (mac) && numel (mac) == 6*2+5)  # 6Bye + 5 Doppelpunkte
    # TODO: uses regex to check for MAC
    gt.adapter = adapter;
    gt.mac = mac;
    gt.addr_type = addr_type;

    params = {'-I', '-i', gt.adapter, '-b', gt.mac, '-t', gt.addr_type};
    [gt.in, gt.out, gt.pid] = popen2 ('gatttool', params);

    fputs (gt.in, "connect\n");
    printf ("Waiting for connection...     ");

    connect_timeout = 20;
    gt.connected = false;
    do
      connect_reply = _read_until_timeout_ (gt.out, 1);
      if ( any (strfind ( connect_reply, "Error")))
        error ( strrep (connect_reply, "Error: ", ""));
      elseif (strfind ( connect_reply, "Connection successful"))
        gt.connected = true;
      else
        connect_timeout--;
        if (connect_timeout <= 0)
          error ("Timeout when trying to connect");
        endif
        printf ("Couldn't connect within 1s, will wait even longer...     ");
      endif
    until (gt.connected)

    ## read device name 0x2A00
    ## TODO: Check if all BLE device have this
    gt.device_name = char (_char_read_uuid_ (gt.in, gt.out, "0x2A00"));

    ret = class (gt, "gatttool");

  else
    error ("No valid remote Bluetooth address")
  endif
endfunction
