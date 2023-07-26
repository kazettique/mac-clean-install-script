source macos-config.sh
source app-list.sh

# echo "Creating an SSH key for you..."
# ssh-keygen -t rsa

# echo "Please add this public key to Github \n"
# echo "https://github.com/account/ssh \n"
# read -p "Press [Enter] key after this..."

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  # ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update homebrew recipes
echo "Updating homebrew..."
brew update

echo "Installing Git..."
brew install git

echo "Git config"
git config --global user.name "Woody Chang"
git config --global user.email kazettique@gmail.com

echo "Installing brew formulae"
brew install ${brewFormulaeList[@]}

echo "Installing homebrew cask"
# Use command below will show "Error: No available tap homebrew/cask" error & terminate script
# TODO: issue fix later
# brew install caskroom/cask/brew-cask

for brewCaskItem in "${brewCaskList[@]}"
do
  brew install --cask --appdir="/Applications" "$brewCaskItem"
done

# install font-fira-code, not moving into applications folder
brew tap homebrew/cask-fonts
brew install --cask font-fira-code

# Install Zsh & Oh My Zsh
echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

# TODO: need adjust
# echo "Setting up Oh My Zsh theme..."
# cd /Users/${USERNAME}/.oh-my-zsh/themes
# curl https://gist.githubusercontent.com/bradp/a52fffd9cad1cd51edb7/raw/cb46de8e4c77beb7fad38c81dbddf531d9875c78/brad-muse.zsh-theme >brad-muse.zsh-theme

echo "Setting up Zsh plugins..."
cd ~/.oh-my-zsh/custom/plugins
echo "Cloning zsh-syntax-higlighting"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
echo "Cloning zsh-completions"
git clone https://github.com/zsh-users/zsh-completions.git
echo "Cloning zsh-autosuggesstions"
git clone https://github.com/zsh-users/zsh-autosuggestions.git

echo "Copying .zshrc to home directory"
cp .zshrc $HOME

echo "Setting ZSH as shell..."
chsh -s /bin/zsh

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "Installing Apps with Brew Cask..."
brew install --cask --appdir="/Applications" ${brewCaskList[@]}

echo "Installing Apps from Mac App Store with mas"
mas install ${macAppStoreList[@]}

echo "Cleaning up brew"
brew cleanup

echo "Setuping Mac Preference"
# calling setupMacOSPreference function
# setupMacOSPreference

killall Finder

echo "Done!"
