# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="robbyrussell"
#ZSH_THEME="smoothmonkey"
#ZSH_THEME="agnoster" # see https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#agnoster
#ZSH_THEME="passion"
#ZSH_THEME="candy"
ZSH_THEME="simple"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    vscode
    kubectl
    aliases
    copyfile
    minikube
    terraform
    thefuck
    vault
    dotnet
)

source $ZSH/oh-my-zsh.sh
SAVEHIST=1000  # Save most-recent 1000 lines
HISTFILE=~/.zsh_history
autoload -U compinit; compinit

###### My Custom config:
# C#
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools"

# Thefuck
eval $(thefuck --alias)

# Fuzzy Search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Advanced Git Aliases
alias revertlast="git revert HEAD --no-edit && git push"
openpr() {
  current_branch=$(git symbolic-ref --short HEAD)
  gh pr create --base main --head "$current_branch" --title "Automated via 'gh pr create': $1"
}

unalias g 2>/dev/null
g() {
  if [ $# -eq 0 ]; then
    git status
  else
    git "$@"
  fi
}

# Other Aliases
alias l='ls -GFh'
alias c='clear'