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
## Csharp
export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="$PATH:$HOME/.dotnet/tools"

## Thefuck plugin
eval $(thefuck --alias)

export PATH=/Users/domantas.giedraitis/.local/bin:$PATH
export OPENAI_ENDPOINT=
export OPENAI_API_KEY=
