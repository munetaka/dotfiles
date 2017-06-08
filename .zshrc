export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst
setopt transient_rprompt

# Default shell configuration
# colors enables us to identify color by $fg[red].
# プロンプトに色を付ける
autoload -U colors;colors
case ${UID} in
0)
    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
*)
    #
    # Color
    #
    DEFAULT=$'%{\e[1;0m%}'
    RESET="%{${reset_color}%}"
    GREEN="%{${fg[green]}%}"
    BLUE="%{${fg[blue]}%}"
    RED="%{${fg[red]}%}"
    CYAN="%{${fg[cyan]}%}"
    WHITE="%{${fg[white]}%}"
    # POH="( ꒪⌓꒪) $"
    POH="┌(┌ ^o^)┐❤ ➜"

    #
    # Prompt
    #
    PROMPT='%{$fg[cyan]%}ⓤ ${USER}⚡%m ${RESET}${WHITE}${POH} ${RESET}'
    RPROMPT='${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)% ${WHITE}]${RESET}'

#   #
#   # vi入力モードでPROMPTの色を変える
#   # http://memo.officebrook.net/20090226.html
#   function zle-line-init zle-keymap-select {
#       case $KEYMAP in
#           vicmd)
#           PROMPT='%{$fg[cyan]%}${USER}@%m ${RESET}${WHITE}${POH} ${RESET}'
#           ;;
#           main|viins)
#           PROMPT='%{$fg[blue]%}${USER}@%m ${RESET}${WHITE}${POH} ${RESET}'
#           ;;
#       esac
#       zle reset-prompt
#   }
#   zle -N zle-line-init
#   zle -N zle-keymap-select

#   # Show git branch when you are in git repository
#   # http://d.hatena.ne.jp/mollifier/20100906/p1

#   autoload -Uz add-zsh-hook
#   autoload -Uz vcs_info

#   zstyle ':vcs_info:*' enable git svn hg bzr
#   zstyle ':vcs_info:*' formats '(%s)-[%b]'
#   zstyle ':vcs_info:*' actionformats '(%s)-[%b|%a]'
#   zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
#   zstyle ':vcs_info:bzr:*' use-simple true

#   autoload -Uz is-at-least
#   if is-at-least 4.3.10; then
#       # この check-for-changes が今回の設定するところ
#       zstyle ':vcs_info:git:*' check-for-changes true
#       zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
#       zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
#       zstyle ':vcs_info:git:*' formats '(%s)-[%c%u%b]'
#       zstyle ':vcs_info:git:*' actionformats '(%s)-[%c%u%b|%a]'
#   fi

#   function _update_vcs_info_msg() {
#       psvar=()
#       LANG=en_US.UTF-8 vcs_info
#       psvar[2]=$(_git_not_pushed)
#       [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
#   }
#  add-zsh-hook precmd _update_vcs_info_msg

#   # show status of git pushed to HEAD in prompt
#   function _git_not_pushed()
#   {
#       if [ "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = "true" ]; then
#           head="$(git rev-parse HEAD)"
#           for x in $(git rev-parse --remotes)
#           do
#               if [ "$head" = "$x" ]; then
#                   return 0
#               fi
#           done
#           echo "|?"
#       fi
#       return 0
#   }

#    # git のブランチ名 *と作業状態* を zsh の右プロンプトに表示＋ status に応じて色もつけてみた - Yarukidenized:ヤルキデナイズド :
#    # http://d.hatena.ne.jp/uasi/20091025/1256458798
#
#     autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
#
#    setopt prompt_subst
#    setopt re_match_pcre
#
#    function rprompt-git-current-branch {
#        local name st color gitdir action pushed
#        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
#            return
#        fi
#
#        name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
#        if [[ -z $name ]]; then
#            return
#        fi
#
#        gitdir=`git rev-parse --git-dir 2> /dev/null`
#        action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"
#        pushed="`_git_not_pushed`"
#
#        st=`git status 2> /dev/null`
#        if [[ "$st" =~ "(?m)^nothing to" ]]; then
#            color=%F{green}
#        elif [[ "$st" =~ "(?m)^nothing added" ]]; then
#            color=%F{yellow}
#        elif [[ "$st" =~ "(?m)^# Untracked" ]]; then
#            color=%B%F{red}
#        else
#            color=%F{red}
#        fi
#
#        echo "[$color$name$action$pushed%f%b]"
#    }
#
#    RPROMPT='`rprompt-git-current-branch`${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)${WHITE}]${RESET}'

    # 上記のpcreが動かないversion用
    # ${fg[...]} や $reset_color をロード
    autoload -U colors; colors

    function rprompt-git-current-branch {
        local name st color

        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi
        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=${fg[green]}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=${fg[yellow]}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=${fg_bold[red]}
        else
                color=${fg[red]}
        fi

        # %{...%} は囲まれた文字列がエスケープシーケンスであることを明示する
        # これをしないと右プロンプトの位置がずれる
        echo "%{$color%}$name%{$reset_color%}"
    }

    # プロンプトが表示されるたびにプロンプト文字列を評価、置換する
    setopt prompt_subst

#    RPROMPT='[`rprompt-git-current-branch`%~]'
#    RPROMPT='`rprompt-git-current-branch`${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)${WHITE}]${RESET}'
    RPROMPT='[`rprompt-git-current-branch`]${RESET}${WHITE}[${BLUE}%(5~,%-2~/.../%2~,%~)${WHITE}]${RESET}'

     ;;
esac

# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_cd

# cd でTabを押すとdir list を表示
setopt auto_pushd

# ディレクトリスタックに同じディレクトリを追加しないようになる
setopt pushd_ignore_dups

# コマンドのスペルチェックをする
setopt correct

# コマンドライン全てのスペルチェックをする
setopt correct_all

# 上書きリダイレクトの禁止
setopt no_clobber

# 補完候補リストを詰めて表示
setopt list_packed

# auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt list_types

# 補完候補が複数ある時に、一覧表示する
setopt auto_list

# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt magic_equal_subst

# カッコの対応などを自動的に補完する
# setopt auto_param_key

# ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

# {a-c} を a b c に展開する機能を使えるようにする
setopt brace_ccl

# シンボリックリンクは実体を追うようになる
setopt chase_links

# 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_menu

# sudoも補完の対象
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# 色付きで補完する
#zstyle ':completion:*' list-colors di=35 fi=0
zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt multios

# 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除かない
setopt noautoremoveslash

# beepを鳴らさないようにする
setopt nolistbeep


## Keybind configuration
#
# vi like keybind
#
# bindkey -v

# 履歴表示の際にC-p,C-nで履歴を変更できる
# bindkey "^P" up-line-or-history
# bindkey "^N" down-line-or-history

# historical backward/forward search with linehead string binded to ^P/^N
# #
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
# bindkey "\\ep" history-beginning-search-backward-end
# bindkey "\\en" history-beginning-search-forward-end

## Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data

# 登録済コマンド行は古い方を削除
setopt hist_ignore_all_dups

# historyの共有
setopt share_history

# 余分な空白は詰める
setopt hist_reduce_blanks

# history (fc -l) コマンドをヒストリリストから取り除く。
setopt hist_no_store

# ctrl-w, ctrl-bキーで単語移動
bindkey "^W" forward-word
bindkey "^B" backward-word

# URLをコピペしたときに自動でエスケープ
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# エラーメッセージ本文出力に色付け
e_normal=`echo -e "¥033[0;30m"`
e_RED=`echo -e "¥033[1;31m"`
e_BLUE=`echo -e "¥033[1;36m"`

function make() {
    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot¥sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
function cwaf() {
    LANG=C command ./waf "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot¥sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}

## Completion configuration
#
fpath=(~/.zsh/functions/Completion ${fpath})
autoload -U compinit
compinit -u

## Prediction configuration
#
#autoload predict-on
#predict-on
#predict-off

## terminal configuration
##
#unset LSCOLORS
#case "${TERM}" in
#xterm)
#    export TERM=xterm-color
#    ;;
#kterm)
#    export TERM=kterm-color
#    # set BackSpace control character
#    stty erase
#    ;;
#cons25)
#    unset LANG
#    export LSCOLORS=ExFxCxdxBxegedabagacad
#    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#    zstyle ':completion:*' list-colors \
#        'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
#    ;;
#esac

# set terminal title including current directory
# #
case "${TERM}" in
kterm*|xterm*)
    precmd() {
      echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
        'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac



## alias設定
#
[ -f ~/dotfiles/.zshrc.alias ] && source ~/dotfiles/.zshrc.alias

case "${OSTYPE}" in
# MacOSX
darwin*)
    # ここに設定
    [ -f ~/dotfiles/.zshrc.osx ] && source ~/dotfiles/.zshrc.osx
    ;;
# Linux
linux*)
    # ここに設定
    [ -f ~/dotfiles/.zshrc.linux ] && source ~/dotfiles/.zshrc.linux
    ;;
esac

## local固有設定
#
[ -f ~/.zshrc.local ] && source ~/.zshrc.local


test -e "${HOME}/.iterm2_shell_integration.zsh-5.0.2" && source "${HOME}/.iterm2_shell_integration.zsh-5.0.2"
