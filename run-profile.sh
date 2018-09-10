function runProfile() {
    pritunl-client daemon
    pritunl-client import $1
    profileId=`pritunl-client list | awk 'NR==2{print $1}'`
    pritunl-client start $profileId
}

export -f runProfile