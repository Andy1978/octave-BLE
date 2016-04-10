#! /bin/bash
# Test für gatt-server und gatttool von bluez
#
# Vorbereitung:
#   2 BLE Module an den Rechner anschließen
#   bluetoothd starten (sudo ./bluez-5.16/src/bluetoothd -nd)
#   beide Module aktivieren (sudo hciconfig hciX up)

if [ $# -gt 2 ]
then
    echo "usage: $0 [hciX] [hciY] " >&2
    exit 1
fi

if [ $(ascii2uni -v 2>/dev/null; echo $?) -eq 127 ]
then
    echo "Bitte uni2ascii installieren!">&2
    exit 1
fi

GTPATH="${HOME}/src/bluez-5.16/attrib"

HCIX=${1:-"hci0"}
HCIY=${2:-"hci1"}
BTMAC=$(hcitool dev | grep $HCIX | grep -Eo '..(:..){5}')

waitfor ()
{
    #echo waitfor "\"$1\""
    until WLINE=$(grep "$1")
        do
        sleep 0.001
    done
}

tic ()
{
    TICTIME="$(date +%s%N)"
}

LC_NUMERIC=C
toc ()
{
    printf "Elapsed time is %.3f seconds.\n" $(echo "($(date +%s%N) - $TICTIME)*10^-9" | bc -l)
}


sudo hciconfig $HCIX leadv


rm -f gatttool.log
mkfifo gtin
${GTPATH}/gatttool -i $HCIY -b $BTMAC -I <gtin | tee gatttool.log &

exec 4>gtin
sleep 0.5
exec 3<gatttool.log

waitfor "\[$BTMAC\]" <&3

echo connect >&4;
waitfor "Connection successful" <&3

tic
echo char-read-hnd 13 >&4
waitfor "Characteristic value/descriptor:" <&3
printf "\r"; toc
echo $WLINE | sed 's/^.*://' | ascii2uni -qZ" %02X"
tail -n1 gatttool.log

#Wird char-read-uuid verwendet werden nur 19 Byte gelesen?
tic
echo char-read-uuid a00c >&4
waitfor "handle:" <&3
printf "\r" ;toc
echo $WLINE | sed 's/^.*://' | ascii2uni -qZ" %02X"
tail -n1 gatttool.log

#rlwrap -S "$(tail -n1 gatttool.log)" cat >&4

echo exit >&4

sync
exec 4>&- 3<&-
rm gtin
