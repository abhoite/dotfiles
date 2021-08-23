#!/usr/bin/env bash
set -e
set -x

# Installing Homebrew for macOS/Linux
if [[ $(uname) == "Darwin" ]]; then
	if ! xcode-select --print-path &>/dev/null; then
		xcode-select --install &>/dev/null
	fi
	set +e
	command -v brew >/dev/null 2>&1
	BREW_CHECK=$?
	if [ $BREW_CHECK -eq 0 ]; then
		echo "Brew already installed"
	else
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
elif [[ $(uname) == "Linux" ]]; then
	set +e
	command -v brew >/dev/null 2>&1
	BREW_CHECK=$?
	if [ $BREW_CHECK -eq 0 ]; then
		echo "Brew already installed"
	else
		bash -c \
			"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
		test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	fi
	if [ ! -d /home/linuxbrew/.linuxbrew/var/homebrew/linked ]; then
		sudo mkdir -p /home/linuxbrew/.linuxbrew/var/homebrew/linked
		sudo chown -R "$(whoami)" /home/linuxbrew/.linuxbrew/var/homebrew/linked
	fi
fi

export PYENV_ROOT="$HOME/.pyenv"

if [ ! -d "$PYENV_ROOT" ]; then
	git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"
	git clone https://github.com/pyenv/pyenv-update.git "$PYENV_ROOT/plugins/pyenv-update"
	git clone https://github.com/pyenv/pyenv-virtualenv.git "$PYENV_ROOT/plugins/pyenv-virtualenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
	DEFAULT_PYTHON_VERSION=$(pyenv install --list | grep -v - | grep -v a | grep -v b | grep -v rc | tail -1 | awk '{ print $1 }')
	pyenv install "$DEFAULT_PYTHON_VERSION"
	pyenv global "$DEFAULT_PYTHON_VERSION"
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
	# eval "$(pyenv virtualenv-init -)"
	pip install --upgrade pip pip-tools
	pip-sync "requirements.txt"
else
	export PATH="$PYENV_ROOT/bin:$PATH"
	eval "$(pyenv init --path)"
	eval "$(pyenv init -)"
	# eval "$(pyenv virtualenv-init -)"
fi

if [[ $(uname) == "Darwin" ]]; then
	FONTS_DIR="$HOME"/Library/Fonts
elif [[ $(uname) == "Linux" ]]; then
	FONTS_DIR="$HOME"/.fonts
fi

if [[ ! -d "$FONTS_DIR" ]]; then
	mkdir -p "$FONTS_DIR"
fi

if [[ ! -f "$FONTS_DIR/MesloLGS NF Regular.ttf" ]]; then
	cd "$FONTS_DIR"
	curl -L https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf >"MesloLGS NF Regular.ttf"
	if [[ $(uname) == "Linux" ]]; then
		fc-cache -vf "$FONTS_DIR"
	fi
	cd -
fi
