# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/asiri/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	history-substring-search
	zsh-autosuggestions
	zsh-syntax-highlighting
    tmux
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


#################### asiri #######################

## cheat
export EDITOR=/usr/bin/vim
export CHEATCOLORS=true

## history config
setopt hist_ignore_all_dups
setopt hist_ignore_space

## theme
export DEFAULT_USER='asiri' # to be used in agnoster theme. setting this will hide the current user in the prompt.

## zsh plugins
### added to plugins according to https://github.com/zsh-users/zsh-autosugestions/blob/master/INSTALL.md
### added to pligins according to https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
### added to plugins according to https://github.com/zsh-users/zsh-history-substring-search

## docker command completion
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

## nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## Add fasd plugin
eval "$(fasd --init auto)"

## fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

## git alias
# deletes local branches for those which remotes have been deleted.
function cleanGitBranches() {
  git fetch -p

  for branch in `git branch -vv | grep ': gone]' | awk '{print $1}'`
  do
    git branch -D $branch;
  done
}

function setUpstream() {
  current_branch = `git rev-parse --abbrev-ref HEAD`
  git push --set-upstream origin $(current_branch)
}

alias gbc="cleanGitBranches"
alias gsup="setUpstream"
alias gmnc='git merge --no-ff --no-commit'
alias zconf="subl ~/.zshrc"

## misc
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

## virtualenv
export WORKON_HOME=$HOME/.virtualenv
export PROJECT_HOME=$HOME/Development
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'

source $HOME/.local/bin/virtualenvwrapper.sh

## python
# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=false

# create commands to override pip restriction.
# use `gpip` or `gpip3` to force installation of a package in the global python environment
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}

gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

## golang
export GOROOT=/usr/local/go
export GOPATH=$HOME/Development/go
export PATH=$PATH:/usr/local/go/bin

## fzf 
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi 

#################### asiri #######################

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/asiri/.sdkman"
[[ -s "/home/asiri/.sdkman/bin/sdkman-init.sh" ]] && source "/home/asiri/.sdkman/bin/sdkman-init.sh"

source /home/asiri/.config/broot/launcher/bash/br

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
