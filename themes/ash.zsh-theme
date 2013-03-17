# ZSH Theme by Ash
# git and svn specifc info included in the prompt, if plugins are active.

function current_dir()
{
    if [[ "$PWD" == "$HOME" ]]; then
      echo "%{$terminfo[bold]$fg[blue]%}~%{$reset_color%}" && return
    fi

    local cdir=$(readlink -f $PWD)
    local pdir=$(readlink -f $PWD/../)
    if [[ "$cdir" == "$pdir" ]]; then
      echo "%{$terminfo[bold]$fg[blue]%}${pdir}%{$reset_color%}" && return
    elif [[ "$pdir" == "/" ]]; then
      cdir=${cdir/\//}
      echo "%{$terminfo[bold]$fg[blue]%}${pdir}%{$terminfo[bold]$fg[green]%}${cdir}%{$reset_color%}" && return
    fi

    pdir=${pdir/$HOME/\~}
    echo "%{$terminfo[bold]$fg[blue]%}${pdir}/%{$terminfo[bold]$fg[green]%}%1d%{$reset_color%}"
}

function prompt_char()
{
    git branch &> /dev/null && echo '±' && return
    hg root &> /dev/null && echo '☿' && return
    svn info &> /dev/null && echo 'š' && return
    echo '○'
}

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

local user_name="%{$terminfo[bold]$fg[green]%}%n%{$reset_color%}"
local user_host="%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}"
local git_branch="$(git_prompt_info)%{$reset_color%}"

if [ $UID -eq 0 ]; then CARETCOLOR="red"; else CARETCOLOR="blue"; fi
if [ "$(whoami)" = "root" ]; then
    PROMPTCOLOR="%{$RB%}" PREFIX="-!-";
else
    PROMPTCOLOR="" PREFIX="---";
fi

PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'

PROMPT='╭─${user_name} $(current_dir) %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%}$(svn_prompt_info)%{$reset_color%}
╰─$(prompt_char)%{$fg_bold[red]%}➜ %{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%})%{$fg[yellow]%} ✗ %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) "

ZSH_PROMPT_BASE_COLOR="%{$fg_bold[blue]%}"
ZSH_THEME_REPO_NAME_COLOR="%{$fg_bold[red]%}"

ZSH_THEME_SVN_PROMPT_PREFIX="svn:("
ZSH_THEME_SVN_PROMPT_SUFFIX=")"
ZSH_THEME_SVN_PROMPT_DIRTY="%{$fg[yellow]%} ✘ %{$reset_color%}"
ZSH_THEME_SVN_PROMPT_CLEAN=" "

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:'

