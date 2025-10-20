export XDG_RUNTIME_DIR="/run/user/`id -u`" # created/mounted by root/init
export ENV="/vol/datafs/x/repos/repo/_dotfiles/env"

# ssh agent
[ -z "$SSH_AGENT_PID" ] && eval `ssh-agent`

# pipewire/wireplumber
/vol/datafs/x/local/appbin/audio-helper &
