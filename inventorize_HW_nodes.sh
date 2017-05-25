#!/bin/bash
echo "node name, bios version, bios release date, hdd controller fw version, net interface 1, fw version, net interface 2, fw version, net interface 3, fw version, net interface 4, fw version" > inventory.log
for i in $(cat nodes);
do
    if ! (( ssh -o "StrictHostKeyChecking no" alexz0nder@$i "lscpu | grep Hypervisor" )); then
        scp -o "StrictHostKeyChecking no" ~/firmware_versions.sh $i:/home/alexz0nder/firmware_versions.sh
        ssh -o "StrictHostKeyChecking no" alexz0nder@$i "sudo chmod +x ./firmware_versions.sh"
        ssh -o "StrictHostKeyChecking no" alexz0nder@$i "sudo ./firmware_versions.sh" | tee -a inventory.log
        ssh -o "StrictHostKeyChecking no" alexz0nder@$i "sudo rm ./firmware_versions.sh"
    fi
done
