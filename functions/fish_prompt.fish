function aquarium_toggle_emoji_decoration -d 'Toggle emoji decoration of aquarium theme'
    if test "$aquarium_no_emoji_decoration" = 'true'
        set -U aquarium_no_emoji_decoration 'false'
    else
        set -U aquarium_no_emoji_decoration 'true'
    end

    commandline -f repaint
end

function fish_prompt
    set -l last_command_status $status
    set -l cwd (prompt_pwd)

    set -l missing  '?'
    set -l ahead    '↑'
    set -l behind   '↓'
    set -l diverged '⥄'
    set -l dirty    '⨯'
    set -l none     '◦'

    if test "$aquarium_no_emoji_decoration" = 'true'
        # set missing  '?'
        set ahead    '+'
        set behind   '-'
        set diverged '*'
        set dirty    'x'
        set none     'o'
    end

    set -l normal_color     (set_color normal)
    set -l directory_color  (set_color brown)
    set -l repository_color (set_color green)

    if test "$aquarium_no_emoji_decoration" = 'true'
        set_color cyan
        echo -n -s '⋊>' $normal_color ' '
    else
        if test $last_command_status -eq 0
            echo -n -s (__random_fish_emoji) $normal_color '  '
        else
            echo -n -s 👿 $normal_color '  '
        end
    end

    if __git_is_repo
        if test "$theme_short_path" = 'yes'
            set root_folder (command git rev-parse --show-toplevel ^/dev/null)
            set parent_root_folder (dirname $root_folder)
            set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")

            echo -n -s $directory_color $cwd $normal_color
        else
            echo -n -s $directory_color $cwd $normal_color
        end

        echo -n -s ' on ' $repository_color (__git_branch_name) $normal_color ' '

        if __git_is_touched
            echo -n -s $dirty
        else
            echo -n -s (__git_ahead $missing $ahead $behind $diverged $none)
        end
    else
        echo -n -s $directory_color $cwd $normal_color
    end

    echo -n -s ' '
end

function __random_fish_emoji
    set -l fish_emojis
    set fish_emojis $fish_emojis 🐠
    set fish_emojis $fish_emojis 🐟
    set fish_emojis $fish_emojis 🐡
    set fish_emojis $fish_emojis 🐬
    set fish_emojis $fish_emojis 🐳
    set fish_emojis $fish_emojis 🐋
    set fish_emojis $fish_emojis 🦀
    set fish_emojis $fish_emojis 🐙
    set fish_emojis $fish_emojis 🦑
    set fish_emojis $fish_emojis 🦀
    set fish_emojis $fish_emojis 🦐
    set fish_emojis $fish_emojis 🐚
    set fish_emojis $fish_emojis 🐢

    set -l index (math (math (random)%(count $fish_emojis))+1)
    echo $fish_emojis[$index]
end

function __git_is_repo
    test -d .git; or command git rev-parse --git-dir >/dev/null ^/dev/null
end

function __git_branch_name
    command git symbolic-ref --short HEAD ^/dev/null;
        or command git show-ref --head -s --abbrev | head -n1 ^/dev/null
end

function __git_is_touched
    test -n (echo (command git status --porcelain))
end

function __git_ahead -a missing ahead behind diverged none
    set -l commit_count (command git rev-list --count --left-right "@{upstream}...HEAD" ^/dev/null)

    switch "$commit_count"
    case ''
        # no upstream
        echo "$missing"
    case "0"\t"0"
        echo "$none"
    case "*"\t"0"
        echo "$behind"
    case "0"\t"*"
        echo "$ahead"
    case "*"
        echo "$diverged"
    end
end
