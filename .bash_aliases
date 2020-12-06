#!/bin/bash

#alias ntpsync='sudo ntpdig -S 3.rs.pool.ntp.org'
#alias ntpsync="sudo chronyc makestep"
alias packagemenu="yay -Pc | awk '{print \$1 \" (\" \$2 \")\"}' | dmenu"
alias vib='firejail --profile=Viber /opt/viber/Viber'

