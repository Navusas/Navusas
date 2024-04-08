# Ubuntu Dev Environment

```bash
## Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Add brew to the path
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/navus/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

## Packages
sudo apt install git
sudo apt install zsh
sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

brew install gh
brew install node

# Couple of other stuff
npm install pnpm --global
sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0 && \
  sudo apt-get install -y aspnetcore-runtime-8.0

## Big Tools
sudo snap install code --classic
sudo snap install rider --classic

## Login to github and follow the steps
git config --global user.name "Navusas"
git config --global user.email "D.Giedraitis7@gmail.com"
gh auth login
```
