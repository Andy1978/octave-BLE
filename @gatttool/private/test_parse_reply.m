## TODO: irgendwie in die tests für @gatttool einbauen
more off
load ("reply_testdata.log")

kwords = {"attr handle"; "end grp handle"; "uuid"};
len = [6, 6, 36];

r = _parse_reply_(reply, kwords, len);
r

## sanity check
start_hnd = str2num(cell2mat(r.attr_handle));
end_hnd = str2num(cell2mat(r.end_grp_handle));
assert(start_hnd(2:end), end_hnd(1:end-1)+1)

## more ????
