export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
# export DOTFILES="$HOME/.dotfiles"
# export XDG_CONFIG_HOME="$DOTFILES/config"
# export ZSH_CUSTOM="$DOTFILES/zsh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && alias nvm-load='source "$NVM_DIR/nvm.sh"'

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# - zinit setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# - plugins

# prompt
zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# highlighting
zinit light zsh-users/zsh-syntax-highlighting

# completions
zinit light zsh-users/zsh-completions
# load completions
autoload -U compinit && compinit
# style
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# zstyle ':completion:*' matcher-list "${(s.:.)LS_COLORS}"

# suggestions
zinit light zsh-users/zsh-autosuggestions

# - keybindings
set -o vi
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^y' autosuggest-accept

# - aliases 
alias ls='ls --color'
alias ga='git add .'
alias gp='git push'
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
alias nf='fzf -m  --preview="bat --color=always {}" --bind "enter:become(nvim {+})"'
alias tm='tmux new-session -A -s main'

# - history
HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HITSDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups


[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
