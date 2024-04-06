# Ubuntu Dev Environment

```bash
## Install git
sudo apt install git

## Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Add brew to the path
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/navus/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

## Env
sudo apt install zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"


## Tools
#cannot install using brew, so go to VS Code download page, download debian package and do
sudo apt-get install ./code.deb

# Packages
brew install node
npm install pnpm --global

sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0

  sudo apt-get update && \
  sudo apt-get install -y aspnetcore-runtime-8.0


  
```
