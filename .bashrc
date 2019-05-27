# .bashrc

# Source global definitions

# set LANG
#export LANG=ja_JP.eucJP
#export LC_ALL=ja_JP.eucJP
export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# 'ls' color setting
export LSCOLORS="ExFxCxDxBxEGEDABAGACAD"
export TERM="xterm-color"

# set aliases
alias ls='\ls -FGv'
alias ll='\ls -lhaGv'
alias la='\ls -aGv'
alias eng='LANG=C LANGUAGE=C LC_ALL=C'
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"


#ctags setting
if [ -x /usr/local/bin/ctags ]; then
        alias ctags='/usr/local/bin/ctags'
fi   

alias vimD='vim -u NONE -N'
alias cmakeclean='rm -rf CMakeCache.txt cmake_install.cmake && rm -rf CMakeFiles && rm -rf Makefile'

#rbenv setting
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#nodebrew setting
export PATH=$HOME/.nodebrew/current/bin:$PATH

git_branch() {
  echo $(git branch --no-color 2>/dev/null | sed -ne "s/^\* \(.*\)$/\1/p")
}
PS1='\n\[\033[36m\]\u\[\033[0m\]\[\033[32m\]\w\[\033[0m\]:\[\033[35m\]$(git_branch)\[\033[0m\] $ '

