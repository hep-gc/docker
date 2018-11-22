# .bashrc                                                                                                                                                                                            

# User specific aliases and functions                                                                                                                                                                

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions                                                                                                                                                                          
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

LINE='172.28.5.1      localhost'; FILE=/etc/hosts; grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"