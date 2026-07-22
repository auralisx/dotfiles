
### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -Ux fish_user_paths $fish_user_paths $HOME/.local/bin

### EXPORT ###
set fish_greeting                                    # Supresses fish's intro message
set TERM "xterm-256color"                            # Sets the terminal type
set -x EDITOR "nvim"                                  # $EDITOR use nvim in terminal
set -x VISUAL "nvim"                                  # $EDITOR use nvim in terminal
# if command -q zeditor
#     set -x VISUAL zeditor
# else
#     set -x VISUAL nvim
# end
set -gx GPG_TTY (tty)

# Prevent directories names from being shortened
set fish_prompt_pwd_dir_length 0
set -x FZF_DEFAULT_OPTS "--color=16,header:13,info:5,pointer:3,marker:9,spinner:1,prompt:5,fg:7,hl:14,fg+:3,hl+:9 --inline-info --tiebreak=end,length --bind=shift-tab:toggle-down,tab:toggle-up"
set -x FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
    # Execute this once per mode that emacs bindings should be used in
    fish_default_key_bindings -M insert

    # Then execute the vi-bindings so they take precedence when there's a conflict.
    # Without --no-erase fish_vi_key_bindings will default to
    # resetting all bindings.
    # The argument specifies the initial mode (insert, "default" or visual).
    fish_vi_key_bindings --no-erase insert
end

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
if command -q sudo-rs
    alias sudo='sudo-rs '
end

#pacman
function cleanup --description 'Remove orphaned packages'
    sudo pacman -Rns (pacman -Qtdq)
end

function update-all --description "Update every package manager"

    echo
    echo "==> Pacman"
    sudo-rs pacman -Syu

    echo
    echo "==> AUR"
    paru -Sua

    echo
    echo "==> Rust toolchain"
    rustup update

    echo
    echo "==> Cargo packages"
    cargo install-update -a

    echo
    echo "==> Yazi plugins"
    ya pkg upgrade

    echo
    echo "Done."

end

alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock

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
