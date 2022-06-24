#!/bin/bash
for((;;)); do
height=$(seid status |& jq -r ."SyncInfo"."latest_block_height")
if ((height>=681000)); then
cd $HOME
sudo systemctl stop seid
cd $HOME && rm $HOME/sei-chain -rf
git clone https://github.com/sei-protocol/sei-chain.git && cd $HOME/sei-chain
git checkout 1.0.4beta
make install
mv ~/go/bin/seid /usr/local/bin/seid
sudo systemctl restart seid
sleep 60
systemctl restart seid
break
else
echo $height
fi
sleep 0.5
done
