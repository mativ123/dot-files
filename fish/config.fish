set -g __fish_git_prompt_show_informative_status 1

if status is-interactive
    export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
    export PATH="$PATH:/home/mathias/.spicetify"
    export PATH="$PATH:/opt/geogebra-5"
    alias lf="lfub"
end
