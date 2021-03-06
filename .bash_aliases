#!/bin/bash

#function mdview()
#{
#    markdown $* | lynx -dump -raw -stdin
#}

#alias ntpsync='sudo ntpdig -S 3.rs.pool.ntp.org'
#alias ntpsync="sudo chronyc makestep"
#alias ntpsync='doas sntp -s 1.rs.pool.ntp.org'
alias ntpsync='doas ntpdate -b pool.ntp.org; doas hwclock -w'
alias packagemenu="yay -Pc | awk '{print \$1 \" (\" \$2 \")\"}' | dmenu"
alias vib='firejail --profile=Viber /opt/viber/Viber'
alias viv='firejail --private --dns=1.1.1.1 --dns=9.9.9.9 --profile=vivaldi vivaldi-stable'
alias netflix='qtws /usr/share/qtws-apps/netflix/netflix.qtws'

