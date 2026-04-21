# 1. PROFILING & INSTANT PROMPT
# zmodload zsh/zprof
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${USER}.zsh"
fi

# 2. ENVIRONMENT VARIABLES
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/WolframEngine/SystemFiles/Kernel/Binaries/Linux-x86-64/WolframKernel"
export LS_COLORS="$LS_COLORS:ow=00;38;5;109:tw=00;38;5;109:"
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# 3. OPTIONS & ZSTYLES
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups
setopt hist_save_no_dups hist_ignore_dups hist_find_no_dups

zstyle :compinstall filename '/home/crisp/.zshrc'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# 4. OPTIMIZED COMPINIT WITH COMPILATION
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
# Compile the dump file for faster loading next time
zcompile "${ZDOTDIR:-$HOME}/.zcompdump"

# 5. THEME & P10K CONFIG
source ~/Programs/git_repos/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 6. BINDINGS & ALIASES
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
alias ls='ls --color'
alias c='clear'
alias e='exit'
alias q='exit'
alias nvimm='NVIM_APPNAME=nvim-0.12 ~/Programs/nvim-linux-x86_64.appimage'
alias nvim-pack='NVIM_APPNAME=nvim-vim-pack ~/Programs/nvim-linux-x86_64.appimage'

# 7. SHELL INTEGRATIONS
eval "$(zoxide init --cmd cd zsh)"
eval "$(fzf --zsh)"

# 8. PLUGINS
source /usr/share/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 9. LAZY-LOAD CONDA
# This replaces the heavy 'conda init' block to speed up startup
conda() {
    unset -f conda
    __conda_setup="$('/opt/anaconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/opt/anaconda/etc/profile.d/conda.sh" ]; then
            . "/opt/anaconda/etc/profile.d/conda.sh"
        else
            export PATH="/opt/anaconda/bin:$PATH"
        fi
    fi
    conda "$@"
}

# 10. END PROFILING
# zprof >! test2.txt
