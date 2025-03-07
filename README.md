# zsh-persistent-aliases

A Zsh plugin to add persistent aliases with a single command that are remembered across sessions.

## Features

- Add aliases with add_alias name command (e.g., add_alias ll "ls -la")
- Stores aliases in ~/.zsh_persistent_aliases (customizable via ZSH_PERSISTENT_ALIASES_FILE)
- Prompts before overwriting existing aliases
- List all stored aliases with list_aliases
- Remove aliases with remove_alias name
- Works with standalone Zsh, Oh My Zsh, or Antidote

## Installation

### Oh My Zsh

1. Clone or download this repository into the Oh My Zsh custom plugins directory:
```bash
   git clone https://github.com//zsh-persistent-aliases.git ~/.oh-my-zsh/custom/plugins/zsh-persistent-aliases
```   
2. Add zsh-persistent-aliases to your plugins list in ~/.zshrc:
```zsh
   plugins=(... zsh-persistent-aliases)
```   
3. Reload your shell:
```zsh
   source ~/.zshrc
```   

### Antidote

1. Ensure Antidote is installed (see Antidote docs).
2. Add the plugin to your ~/.zsh_plugins.txt (or wherever you store your Antidote plugins):
```txt
   /NavidMitchell/zsh-persistent-aliases
```   
3. Update your ~/.zshrc to source Antidote and load the plugins (if not already set up):
```zsh
   source ${ZDOTDIR:-~}/.antidote/antidote.zsh
   antidote load
```   
4. Reload your shell or source your ~/.zshrc:
```zsh
   source ~/.zshrc
```
### Standalone Zsh

1. Place zsh-persistent-aliases.plugin.zsh in a directory (e.g., ~/.zsh_plugins/):
```zsh
   mkdir -p ~/.zsh_plugins && cp zsh-persistent-aliases.plugin.zsh ~/.zsh_plugins/
```   
2. Source it in your ~/.zshrc:
```zsh
   source ~/.zsh_plugins/zsh-persistent-aliases.plugin.zsh
```   
3. Reload your shell:
```zsh
   source ~/.zshrc
```

## Usage

- Add an alias:
```zsh
  add_alias ll "ls -la"  # Creates alias 'll' for 'ls -la'
```  
- List all stored aliases:
```zsh
  list_aliases
```  
- Remove an alias:
```zsh
  remove_alias ll
```

Aliases are saved to ~/.zsh_persistent_aliases and loaded automatically on shell startup.

## Customization

Set ZSH_PERSISTENT_ALIASES_FILE to change the storage file:
```zsh
export ZSH_PERSISTENT_ALIASES_FILE="$HOME/.my_custom_aliases"
```
Add this line to your ~/.zshrc before sourcing the plugin.

## Contributing

Feel free to submit issues or pull requests on GitHub!