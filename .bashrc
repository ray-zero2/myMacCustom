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
alias vgjTunnel="ssh -A -L 10023:192.168.23.189:22 rei.matsuda@52.199.201.198 -p 22"
alias rmDS="find . -type f -name ".DS_Store" -print | xargs rm -f"
alias findDS="find . -type f -name ".DS_Store" -print"

alias fake-dev="nginx -p . -c ~/.fake-dev.conf"

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

#If you need to have ruby first in your PATH run:
  export PATH="/usr/local/opt/ruby/bin:$PATH" 

#For compilers to find ruby you may need to set:
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"

#For pkg-config to find ruby you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

#if you need to have llvm first in your PATH run:
export PATH="/usr/local/opt/llvm/bin:$PATH"

#For compilers to find llvm you may need to set:
export LDFLAGS="-L/usr/local/opt/llvm/lib"
export CPPFLAGS="-I/usr/local/opt/llvm/include"


git_branch() {
  echo $(git branch --no-color 2>/dev/null | sed -ne "s/^\* \(.*\)$/\1/p")
}
PS1='\n\[\033[36m\]\u\[\033[0m\]\[\033[32m\]\w\[\033[0m\]:\[\033[35m\]$(git_branch)\[\033[0m\] $ '

if [ `which tmux` ]; then
  if ! [ -n "$TMUX" ]; then
    tmux a -d || tmux
  else
    . ~/bash/tmux/alias.sh
  fi
fi
