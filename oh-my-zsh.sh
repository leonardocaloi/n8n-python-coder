#!/bin/bash

# Instalar Zsh
sudo apt update
sudo apt install -y zsh

# Instalar Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$ZSH/custom"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Configurar tema Spaceship
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
sed -i 's/^ZSH_THEME=".*"/ZSH_THEME="spaceship"/' ~/.zshrc

# Apagar conteúdo do arquivo .zshrc
> ~/.zshrc

# Configurar o Spaceship prompt
cat <<EOT >> ~/.zshrc
# Carregar Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
source \$ZSH/oh-my-zsh.sh

# Configurar tema Spaceship

ZSH_THEME="spaceship"

# Configurar o Spaceship prompt
SPACESHIP_PROMPT_ORDER=(
   time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
#   package       # Package version
#   gradle        # Gradle section
#   maven         # Maven section
#   node          # Node.js section
#   ruby          # Ruby section
#   elixir        # Elixir section
#   xcode         # Xcode section
#   swift         # Swift section
#   golang        # Go section
#   php           # PHP section
#   rust          # Rust section
#   haskell       # Haskell Stack section
#   julia         # Julia section
   docker        # Docker section
#   aws           # Amazon Web Services section
#   gcloud        # Google Cloud Platform section
#   venv          # virtualenv section
   conda         # conda virtualenv section
#   pyenv         # Pyenv section
#   dotnet        # .NET section
#   ember         # Ember.js section
#   kubectl       # Kubectl context section
#   terraform     # Terraform workspace section
#   ibmcloud      # IBM Cloud section
  exec_time     # Execution time
  line_sep      # Line break
#  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CONDA_SHOW=true
SPACESHIP_GCLOUD_SHOW=true
SPACESHIP_GCLOUD_COLOR=2
SPACESHIP_CONDA_COLOR=2
SPACESHIP_DOCKER_SHOW=true
SPACESHIP_DOCKER_COLOR=1

# Carregar tema
source \$ZSH_CUSTOM/themes/spaceship.zsh-theme
EOT

# Instalar Zinit
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
# zinit self-update

# Configurar plugins Zinit
cat <<EOT >> ~/.zshrc
zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
EOT

# Mudar shell padrão para Zsh
chsh -s $(which zsh)

echo "Instalação do Zsh concluída. Abra um novo terminal ou execute 'source ~/.zshrc'"

zsh