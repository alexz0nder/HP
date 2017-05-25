#!/bin/bash
echo "node name, bios version, bios release date, hdd controller fw version, net interface 1, fw version, net interface 2, fw version, net interface 3, fw version, net interface 4, fw version" > inventory.log
for i in $(cat nodes);
do
    if ! (( ssh -o "StrictHostKeyChecking no" alexz0nder@$i "lscpu | grep Hypervisor" )); then
        scp -o "StrictHostKeyChecking no" ~/collect_firmwares.sh $i:/home/alexz0nder/collect_firmwares.sh
        ssh -o "StrictHostKeyChecking no" alexz0nder@$i "sudo chmod +x ./collect_firmwares.sh"
        ssh -o "StrictHostKeyChecking no" alexz0nder@$i "sudo ./collect_firmwares.sh" | tee -a inventory.log
        ssh -o "StrictHostKeyChecking no" alexz0nder@$i "sudo rm ./collect_firmwares.sh"
    fi
done
