config=""

function get_plugin_names(){
    strings=""    
    for i; do 
        if [[ $i == *"kong.plugins."* ]]; then
            tmp=${i#*"[\"kong.plugins."}   # remove prefix
            b="$( cut -d '.' -f 1 <<< "$tmp" )" # get module name
            strings="$strings $b"
        fi
    done
    config="$config $(echo $strings | xargs -n1 | sort -u | xargs | sed 's/ /, /g')"
}

for d in $(find /plugins/ -name *.rockspec -printf "%h\n") ; do
    cd "$d"
    ret=$(grep -r "kong.plugins." *.rockspec) && get_plugin_names $ret && config="$config,"
    cd -
done

config="custom_plugins = $config"
config=${config%,*}   # remove last comma
echo $config


