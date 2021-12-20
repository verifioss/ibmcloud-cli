#!/bin/bash

# ibmcloud cli bash autocompletion
[[ -f /usr/local/ibmcloud/autocomplete/bash_autocomplete ]] && source /usr/local/ibmcloud/autocomplete/bash_autocomplete
export PS1="\[\033[38;5;6m\][\[$(tput sgr0)\]\[\033[38;5;4m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;1m\]\H\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;11m\]\w\[$(tput sgr0)\]\[\033[38;5;6m\]]\[$(tput sgr0)\]\[\033[38;5;34m\]:\[$(tput sgr0)\] \[$(tput sgr0)\]"