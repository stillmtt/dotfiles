
# =========================================================
# Completion
# =========================================================

# Make Arch's extra completion definitions available.
fpath=(/usr/share/zsh/site-functions $fpath)

autoload -Uz compinit
compinit

# Enable interactive completion menu selection
zstyle ':completion:*' menu select

# Color the completion suggestions
zmodload zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu


# =========================================================
# History
# =========================================================

HISTFILE=~/.zsh_history   # where history is saved
HISTSIZE=10000            # commands kept in the current shell
SAVEHIST=10000            # commands saved to the history file

setopt APPEND_HISTORY       # add history instead of replacing the file
#setopt INC_APPEND_HISTORY   # write each command to the file as it runs
setopt SHARE_HISTORY        # share history between open shells
setopt HIST_IGNORE_DUPS     # skip a command if it matches the previous one
#setopt HIST_IGNORE_ALL_DUPS # remove older copies of a command
#setopt HIST_REDUCE_BLANKS   # trim extra spaces when saving
setopt HIST_IGNORE_SPACE    # don't save commands that start with a space
setopt EXTENDED_HISTORY     # save timestamps and command duration


# =========================================================
# Shell behaviour
# =========================================================

# AUTO_MENU — after an ambiguous completion, the next completion key can show or cycle through the matches.
# MENU_COMPLETE — pressing the completion key selects the first match immediately instead of inserting the longest common prefix.

setopt AUTO_MENU # MENU_COMPLETE

# NO_CASE_GLOB — filename glob patterns match regardless of letter case. For example, *.jpg can match photo.JPG.
# NO_CASE_MATCH — completion matching ignores case. It affects completion behavior, not general shell pattern matching in the same way as NO_CASE_GLOB.
setopt NO_CASE_GLOB NO_CASE_MATCH

# Allows filename globs to match dotfiles. For example, * can include .zshrc. Without it, dotfiles usually need a pattern that starts with a dot.
setopt GLOBDOTS


# Make a shell alias suspend to run > systemctl suspend
alias suspend='systemctl suspend'

# =========================================================
# Fuzzy finder
# =========================================================

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh


# =========================================================
# Custom Prompt
# =========================================================

autoload -U colors && colors

NEWLINE=$'\n'
PROMPT="${NEWLINE}%K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ "
echo -e "${NEWLINE}\x1b[38;5;137m\x1b[48;5;0m it's $(print -P '%D{%_I:%M%P}\n') \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m"

# =========================================================
# Plugins
# =========================================================

# zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting

# Choose colors for commands and arguments
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=red'
ZSH_HIGHLIGHT_STYLES[argument]='fg=cyan'

# Load highlighting after other Zsh setup
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# =========================================================
# Custom Configurations
# =========================================================

# bat:
# is a syntax-highlighting version of cat. It can color file contents—for example, source code or config files

# Use bat's pager for man pages
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat --language=man --plain'"
# Make `cat` use bat, while keeping plain output when piped
alias cat='bat --paging=never'


