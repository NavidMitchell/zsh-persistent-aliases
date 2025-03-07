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

# Function to add a new alias and save it persistently
add_alias() {
    if [[ $# -ne 2 ]]; then
        echo "Usage: add_alias <name> <command>"
        echo "Example: add_alias ll 'ls -la'"
        return 1
    fi

    local alias_name="$1"
    local alias_command="$2"

    # Check if the alias already exists
    if alias "$alias_name" >/dev/null 2>&1; then
        echo "Warning: Alias '$alias_name' already exists. Overwrite? (y/n)"
        read -r response
        if [[ "$response" != "y" ]]; then
            echo "Alias not modified."
            return 1
        fi
        # Remove the existing alias from the current session
        unalias "$alias_name"
        # Remove the old alias from the file (if it exists there)
        sed -i.bak "/^alias $alias_name=/d" "$ZSH_PERSISTENT_ALIASES_FILE"
    fi

    # Define the alias in the current session
    alias "$alias_name=$alias_command"

    # Append the alias to the persistent file
    echo "alias $alias_name='$alias_command'" >> "$ZSH_PERSISTENT_ALIASES_FILE"

    echo "Alias '$alias_name' added and saved to $ZSH_PERSISTENT_ALIASES_FILE."
}

# Autoload the function
autoload -Uz add_alias