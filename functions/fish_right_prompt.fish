if not set -q aquarium_show_ruby_version
    set -g aquarium_show_ruby_version 'true'
end

if not set -q aquarium_show_node_version
    set -g aquarium_show_node_version 'true'
end

if not set -q aquarium_show_python_version
    set -g aquarium_show_python_version 'true'
end

function aquarium_toggle_right_prompt -d 'Toggle right prompt of aquarium theme'
    if not set -q aquarium_no_right_prompt
        set -g aquarium_no_right_prompt 'false'
    end

    if test $aquarium_no_right_prompt = 'true'
        set aquarium_no_right_prompt 'false'
    else
        set aquarium_no_right_prompt 'true'
    end

    commandline -f repaint
end

function aquarium_toggle_ruby_version -d 'Toggle Ruby version on right prompt of aquarium theme'
    if test $aquarium_show_ruby_version = 'true'
        set aquarium_show_ruby_version 'false'
    else
        set aquarium_show_ruby_version 'true'
    end

    commandline -f repaint
end

function aquarium_toggle_node_version -d 'Toggle Node version on right prompt of aquarium theme'
    if test $aquarium_show_node_version = 'true'
        set aquarium_show_node_version 'false'
    else
        set aquarium_show_node_version 'true'
    end

    commandline -f repaint
end

function aquarium_toggle_python_version -d 'Toggle Python version on right prompt of aquarium theme'
    if test $aquarium_show_python_version = 'true'
        set aquarium_show_python_version 'false'
    else
        set aquarium_show_python_version 'true'
    end

    commandline -f repaint
end

function __aquarium_get_ruby_version
    if test $aquarium_show_ruby_version != 'true'
        return
    end

    if type rbenv >/dev/null ^/dev/null
        echo \((set_color red)rbenv: (set_color normal)(rbenv version-name)\)
        return
    end

    if type ruby >/dev/null ^/dev/null
        echo \((set_color red)ruby: (set_color normal)(ruby -v)\)
        return
    end

    echo \((set_color red)no ruby(set_color normal)\)
end

function __aquarium_get_node_version
    if test $aquarium_show_node_version != 'true'
        return
    end

    if type fnm >/dev/null ^/dev/null
        echo \((set_color green)fnm: (set_color normal)(node -v)\)
        return
    end

    if type nodebrew >/dev/null ^/dev/null
        echo \((set_color green)nodebrew: (set_color normal)(node -v)\)
        return
    end

    if type node >/dev/null ^/dev/null
        echo \((set_color green)node: (set_color normal)(node -v)\)
        return
    end

    echo \((set_color green)no node(set_color normal)\)
end

function __aquarium_get_python_version
    if test $aquarium_show_python_version != 'true'
        return
    end

    if type pyenv >/dev/null ^/dev/null
        echo \((set_color yellow)pyenv: (set_color normal)(pyenv version-name)\)
        return
    end

    if type python >/dev/null ^/dev/null
        echo \((set_color yellow)python: (set_color normal)(python -V ^&1 | awk '{print $2}')\)
        return
    end

    echo \((set_color yellow)no python(set_color normal)\)
end

function fish_right_prompt
    if test "$aquarium_no_right_prompt" = 'true'
        return
    end

    echo -n -s (__aquarium_get_ruby_version) \
               (__aquarium_get_python_version) \
               (__aquarium_get_node_version)
end
