
### ADDING TO THE PATH
fish_add_path $HOME/.local/bin

### EXPORT ###
set fish_greeting                                    # Supresses fish's intro message
set -x EDITOR "nvim"                                  # $EDITOR use nvim in terminal
set -x VISUAL "nvim"                                  # $EDITOR use nvim in terminal
if status --is-interactive
    set -gx GPG_TTY (tty)
end
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'

# VI mode
fish_vi_key_bindings

# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursors to an underscore
set fish_cursor_replace_one underscore
set fish_cursor_replace underscore
# Set the external cursor to a line. The external cursor appears when a command is started.
# The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
set fish_cursor_external line
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

### END OF VI MODE ###

### FUNCTIONS ###

# y shell wrapper with ability to change directory after yazi exits
function y
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	command yazi $argv --cwd-file="$tmp"
	if read -z cwd < "$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end

### END OF FUNCTIONS ###


### ALIASES ###

alias ls='eza -la'

#pacman
function cleanup --description 'Remove orphaned packages'
    set -l orphans (pacman -Qtdq 2>/dev/null)

    if test (count $orphans) -gt 0
        sudo pacman -Rns $orphans
    else
        echo "No orphaned packages."
    end
end

function update-all --description "Update every package manager"

    echo
    echo "==> Pacman"
    sudo pacman -Syu

    # echo
    # echo "==> Rust toolchain"
    # rustup update

    # echo
    # echo "==> Cargo packages"
    # cargo install-update -a

    echo
    echo "==> Yazi plugins"
    ya pkg upgrade

    echo
    echo "Done."

end

alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
alias fzf="fzf --preview 'bat --style=numbers --color=always {}'"

# Color output of ip
alias ip="ip -color"

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'  # human-readable sizes

#free
alias free="free -mt" # show sizes in MB

### Add setups for the shell ###
starship init fish | source

zoxide init fish | source

mise activate fish | source
