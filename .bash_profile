#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

shopt -q login_shell && $(pkill gpg; startx)
