vsc() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
      ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e


  printf "${BLUE}Installing Fira Code fonts...${NORMAL}\n"
  mkdir -p ~/.local/share/fonts
  for type in Bold Light Medium Regular Retina
  do 
      wget -O ~/.local/share/fonts/FiraCode-$type.ttf "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-$type.ttf?raw=true"
  done
  fc-cache -f
  printf "${YELLOW}Fira Code fonts installed${NORMAL}\n"
 
  ###################################
  # Visual Studio Code (Microsoft)
  printf "${BLUE}Installing Visual Studio Code (Microsoft)...${NORMAL}\n"
  sudo apt-get -y install git libgtk2.0-0 libgconf-2-4 libasound2 libnss3 libxtst6 gtk-chtheme light-themes
  
  # get last version of Visual Studio Code:
  wget https://go.microsoft.com/fwlink/?LinkID=760868 -O /tmp/vscode-amd64.deb
  sudo dpkg -i /tmp/vscode-amd64.deb

  if [ ! -d ~/.vscode ]; then
      mkdir ~/.vscode
  fi

  if [ ! -e ~/.vscode/settings.json ]; then
      cat > ~/.vscode/settings.json <<EOF
{
    "go.buildOnSave": true,
    "go.lintOnSave": true,
    "go.vetOnSave": true,
    "go.buildTags": "",
    "go.buildFlags": [],
    "go.lintFlags": [],
    "go.vetFlags": [],
    "go.coverOnSave": false,
    "go.useCodeSnippetsOnFunctionSuggest": false,
    "go.formatOnSave": true,
    "go.formatTool": "goreturns",
    "go.goroot": "~/go",
    "go.gopath": "~/git",
    "go.gocodeAutoBuild": false,
    "editor.fontFamily": "Fira Code",
    "editor.fontLigatures": true
}
EOF
    fi

    if [ ! -e ~/.vscode/launch.json ]; then
      cat > ~/.vscode/launch.json <<EOF
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch",
            "type": "go",
            "request": "launch",
            "mode": "debug",
            "program": "${workspaceRoot}",
            "env": {},
            "args": []
        }
    ]
}
EOF
    fi

    printf "${YELLOW}Go plugin Visual Studio Code: install it with <Ctrl+Shift+P> and then 'ext install go'...${NORMAL}\n"
}

# Check if reboot is needed
vsc
