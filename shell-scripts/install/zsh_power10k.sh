#!/usr/bin/env bash
# https://gist.github.com/aveao/988b0e311d802a723ccdcd6d326c167b
echo "Welcome to ZSH Setup script of Avery of ave.zone. This script is XKCD 1654 compliant."
cd ~

(which sudo &>/dev/null && echo "sudo found") || (echo "sudo not found, exiting" && exit 1) #Checks if sudo is installed
(which pkg &>/dev/null && sudo pkg install -y zsh git wget) || echo "pkg not found, moving on" # Checks for FreeBSD-like OSes
(which pacman &>/dev/null && sudo pacman -Sy zsh git wget --noconfirm  --needed) || echo "pacman not found, moving on" # Checks for Arch-like OSes
(which apt-get &>/dev/null && (sudo apt-get update;sudo apt-get install zsh git wget -y)) || echo "apt-get not found, moving on" # Checks for Ubuntu-like or Debian-like OSes
(which yum &>/dev/null && (sudo yum upgrade;sudo yum install zsh git wget --assumeyes)) || echo "yum not found, moving on" # Checks for RedHat-like OSes
(which zyyper &>/dev/null && (sudo zyyper upgrade;sudo zyyper install zsh git wget -y)) || echo "zyyper not found, moving on" # Checks for SUSE-like OSes

if [[ "$OSTYPE" == "darwin"* ]]; then # Checks if OS is MacOS
        (which brew &>/dev/null && (echo "brew found";brew install zsh wget git)) || echo "brew not found, exiting. See https://brew.sh for instructions on how to install"; exit 1 # If OS is macOS, checks if brew is instaleld. If not, it exits and warns user, if it is, it then installs the stuff from brew.
fi

# Powerline time!
git clone https://github.com/powerline/fonts.git /tmp/fonts && cd /tmp/fonts/ && ./install.sh; cd ~

# Let's install ohmyzsh now.
ZSH=~/.oh-my-zsh
USERNAME=$(whoami)
git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH

# And switch to zsh. Stolen from oh my zsh setup.
TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
  if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    # If this platform provides a "chsh" command (not Cygwin), do it, man!
    if hash chsh >/dev/null 2>&1; then
      printf "Time to change your default shell to zsh!\n"
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
    # Else, suggest the user do so manually.
    else
      printf "I can't change your shell automatically because this system does not have chsh.\n"
      printf "Please manually change your default shell to zsh!\n"
    fi
  fi

export ZSH=$ZSH

# Install zsh-completions plugin and powerline9k theme.
git clone https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone git://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Now that we got the extras, let's start editing zshrc
echo """
export LANG="en_US.UTF-8"
export ZSH=$ZSH
ZSH_THEME=\"powerlevel10k/powerlevel10k\"
DEFAULT_USER=\"$USERNAME\"
UPDATE_ZSH_DAYS=10
COMPLETION_WAITING_DOTS=\"true\"
plugins=(git common-aliases git-extras screen sudo history zsh-completions zsh-syntax-highlighting zsh-autosuggestions)
autoload -U compinit && compinit
source \$ZSH/oh-my-zsh.sh
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator ssh time)
POWERLEVEL9K_TIME_FORMAT=\"%D{%I:%M:%S %p}\"
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
""" > .zshrc

curl -fsSL https://raw.githubusercontent.com/medeirosinacio/library/master/my-conf/.p10k.zsh > .p10k.zsh

# done.
echo "Done! Don't forget to change your terminal to a powerline font."
zsh