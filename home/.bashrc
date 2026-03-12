# Enable case-insensitive tab completion
bind "set completion-ignore-case on"

# Git completions
[ -f /opt/homebrew/etc/bash_completion ] && . /opt/homebrew/etc/bash_completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Function to get git branch and status
git_prompt() {
    # Check if we're in a git repo
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Get branch name
        local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
        
        # Get git status indicators
        local git_status=""
        
        # Check for uncommitted changes
        if [[ $(git status --porcelain 2> /dev/null) ]]; then
            git_status="${git_status}*"
        fi
        
        # Check for staged changes
        if git diff --cached --quiet 2> /dev/null; then
            :
        else
            git_status="${git_status}+"
        fi
        
        # Check if ahead/behind remote
        local upstream=$(git rev-parse --abbrev-ref --symbolic-full-name @{u} 2> /dev/null)
        if [[ -n "$upstream" ]]; then
            local ahead=$(git rev-list @{u}..HEAD --count 2> /dev/null)
            local behind=$(git rev-list HEAD..@{u} --count 2> /dev/null)
            
            if [[ $ahead -gt 0 ]]; then
                git_status="${git_status}↑${ahead}"
            fi
            
            if [[ $behind -gt 0 ]]; then
                git_status="${git_status}↓${behind}"
            fi
        fi
        
        # Format the output with colors
        echo -e " \033[35m($branch$git_status)\033[0m"
    fi
}

# Homebrew and environment setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Silence bash deprecation warning
export BASH_SILENCE_DEPRECATION_WARNING=1

# PATH configuration
export PATH="/usr/local/bin:$PATH:$HOME/go/bin"
export PATH="$PATH:/usr/bin/sourcekit-lsp"
export PATH="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# SDK configuration for compiling native code (Rust, C++, etc)
# This ensures non-Apple tools can find system libraries
export SDKROOT=$(xcrun --sdk macosx --show-sdk-path 2>/dev/null || echo "")

# Set colorful prompt with git info
PS1='\[\033[32m\]\u@\h\[\033[0m\]:\[\033[34m\]\w\[\033[0m\]$(git_prompt)\$ '

# Aliases for efficiency
alias sr='git submodule update --init --recursive'
carthageupdate() { carthage update "$1" --use-xcframeworks --cache-builds --platform iOS; }
alias deleteBranch='git branch -D'
alias fuckxcode='rm -rf ~/Library/Developer/Xcode/DerivedData'
alias gitclean='git branch | egrep -v "(master|marcus-experiments|\*)" | xargs git branch -D'
alias fclean='git co . && git clean -df'
alias rip='swift-format -rip'
alias bink='/usr/bin/ssh-add --apple-use-keychain'
alias nb='npm run build'
alias nl='npm run lint -- --fix'
alias cargodeeznuts='cargo run'
alias xx='xcodes select'
alias ghd='gh dash'
alias ytd='yt-dlp -S ext:mp4:m4a --cookies-from-browser vivaldi -P $HOME/Movies/'
alias ytdmax='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" -P $HOME/Movies/'
alias ac='aicommits'
alias aca='git add . && aicommits'
alias xg='xcodegen generate'
alias vim='nvim'
alias vi='nvim'
alias c='clear'
alias ise="xcrun simctl boot 'iPhone SE (3rd generation)'"
alias sb='swift build'
alias st='swift test'

# Tuist
alias ti='tuist install'
alias tg='tuist generate'
alias tc='tuist cache'
alias te='tuist edit'

# Function definitions
function run_tests() {
    local project_path="$1"
    local scheme="$2"
    xcodebuild test -project "$project_path" -scheme "$scheme" -destination 'platform=iOS Simulator,name=iPhone SE (3rd generation),OS=latest'
}

[ -f "$HOME/.secrets" ] && . "$HOME/.secrets"

case $- in
    *i*)
        # Only run in interactive shells
        eval "$(ssh-agent -s)" >/dev/null 2>&1
        ssh-add ~/.ssh/id_ed25519 >/dev/null 2>&1
        ;;
esac

# Claude Code
alias cc="CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1 ENABLE_BACKGROUND_TASKS=1 ~/.local/bin/claude --dangerously-skip-permissions"
alias ccc="CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1 ENABLE_BACKGROUND_TASKS=1 ~/.local/bin/claude --dangerously-skip-permissions --continue"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
alias ccu="claude update"

alias vpnon='sudo tailscale set --exit-node=arch'
alias vpnoff='sudo tailscale set --exit-node='

# OpenCode
alias oc='opencode'
