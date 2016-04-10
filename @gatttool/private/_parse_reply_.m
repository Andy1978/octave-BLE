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

function ret = _parse_reply_ (reply, kwords, len)

  ## gatttool from bluez 5.24 returns a blue colored MAC address output which
  ## gets overwritten with CR (\r). See the raw output uint8(reply) and notive the ESC[0;94 sequences

  fields = strrep (kwords, " ", "_");

  ## get rid of CR
  reply(reply == 13) = [];
  tmp    = strsplit (reply, "\n");

  ## remove first and last line
  #printf("first line length = %i\n", numel (tmp{1}));
  tmp(1) = [];
  tmp(end) = [];

  num_records = numel (tmp);

  block = char (tmp);
  for k = 1:numel (kwords)
    start_idx = cell2mat(strfind(tmp, kwords{k})) + numel(kwords{k}) + 2;
    ret.(fields{k}) = cell (num_records, 1);
    for j = 1:numel (tmp)
      ret.(fields{k}){j} = tmp{j}(start_idx(j):(start_idx(j) + len(k)-1));
    endfor
  endfor

endfunction
