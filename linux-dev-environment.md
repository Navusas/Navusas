# Ubuntu Dev Environment

```bash
## Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Add brew to the path
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/navus/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

## Tools
#cannot install using brew, so go to VS Code download page, download debian package and do
sudo apt-get install ./code.deb

# Packages
brew install node
npm install pnpm --global
```