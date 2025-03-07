# zsh-persistent-aliases.plugin.zsh
#
# A Zsh plugin to add persistent aliases with a single command.
# Usage: add_alias <name> <command>
# Example: add_alias ll "ls -la"
# Aliases are stored in ~/.zsh_persistent_aliases and loaded on shell startup.

# Define the default file for storing aliases
ZSH_PERSISTENT_ALIASES_FILE="${ZSH_PERSISTENT_ALIASES_FILE:-$HOME/.zsh_persistent_aliases}"

# Ensure the alias file exists
[[ ! -f "$ZSH_PERSISTENT_ALIASES_FILE" ]] && touch "$ZSH_PERSISTENT_ALIASES_FILE"

# Source the alias file on plugin load (for new shells)
[[ -f "$ZSH_PERSISTENT_ALIASES_FILE" ]] && source "$ZSH_PERSISTENT_ALIASES_FILE"

add_alias() {
    if [[ $# -ne 2 ]]; then
        echo "Usage: add_alias <name> <command>"
        echo "Example: add_alias ll 'ls -la'"
        return 1
    fi
    local alias_name="$1"
    local alias_command="$2"
    if alias "$alias_name" >/dev/null 2>&1; then
        echo "Warning: Alias '$alias_name' already exists. Overwrite? (y/n)"
        read -r response
        [[ "$response" != "y" ]] && { echo "Alias not modified."; return 1; }
        unalias "$alias_name"
        sed -i.bak "/^alias $alias_name=/d" "$ZSH_PERSISTENT_ALIASES_FILE"
    fi
    alias "$alias_name=$alias_command"
    echo "alias $alias_name='$alias_command'" >> "$ZSH_PERSISTENT_ALIASES_FILE"
    echo "Alias '$alias_name' added and saved to $ZSH_PERSISTENT_ALIASES_FILE."
}

list_aliases() {
    cat "$ZSH_PERSISTENT_ALIASES_FILE"
}

remove_alias() {
    if [[ $# -ne 1 ]]; then
        echo "Usage: remove_alias <name>"
        return 1
    fi
    local alias_name="$1"
    unalias "$alias_name" 2>/dev/null
    sed -i.bak "/^alias $alias_name=/d" "$ZSH_PERSISTENT_ALIASES_FILE"
    echo "Alias '$alias_name' removed."
}

autoload -Uz add_alias list_aliases remove_alias