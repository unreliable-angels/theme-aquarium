function fish_greeting -d 'Show greeting in login shell'
    set -l fish_emojis
    set fish_emojis $fish_emojis 🐠
    set fish_emojis $fish_emojis 🐟
    set fish_emojis $fish_emojis 🐡
    set fish_emojis $fish_emojis 🐬
    set fish_emojis $fish_emojis 🐳
    set fish_emojis $fish_emojis 🐋
    set fish_emojis $fish_emojis 🦀
    set fish_emojis $fish_emojis 🐙
    set fish_emojis $fish_emojis 🐢

    if not set -q aquarium_nogreeting
        set -l line ''
        for fish_emoji in $fish_emojis
            set line "$line$fish_emoji  "
        end
        set_color cyan
        echo 'Aquarium Theme for fish'
        echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~
        set_color -b cyan
        echo $line
        set_color -b normal
        echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~
        echo
        echo 'Hint:'
        echo (set_color blue)'*' Run (set_color brown)aquarium_toggle_right_prompt \
             (set_color blue)if you want to toggle show/hide the right prompt.
        echo (set_color blue)'*' (set_color brown)set -g aquarium_nogreeting \'true\' \
             (set_color blue)if you want to disable this greeting message.
        echo (set_color blue)'*' (set_color brown)set -g aquarium_show_ruby_version \'false\' \
             (set_color blue)if you want to hide ruby version.
        echo (set_color blue)'*' (set_color brown)set -g aquarium_show_node_version \'false\' \
             (set_color blue)if you want to hide node version.
        echo (set_color blue)'*' (set_color brown)set -g aquarium_no_right_prompt \'true\' \
             (set_color blue)if you want to completely disable the right prompt.
        set_color normal
        echo
    end
end
