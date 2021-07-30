alias cls="clear"
alias down="cd ~/Downloads"
alias ..="cd .."
alias ....="cd ../.."
alias look="sudo find . -name"
alias search="sudo grep --color -rnw ./ -e "
alias ports="sudo lsof -PiTCP -sTCP:LISTEN"
alias xclip="xclip -selection c"
alias speedtest="wget -O /dev/null cachefly.cachefly.net/100mb.test"
alias vi="nvim"
alias vim="nvim"

# AWS
alias sa='. swa'
alias instances="aws --output table ec2 describe-instances --query 'Reservations[].Instances[].[Tags[?Key==\`Name\`] | [0].Value,InstanceId,State.Name,InstanceType,Placement.AvailabilityZone]'"
alias dbinstances="aws rds describe-db-instances --query 'DBInstances[*].{ID:DBInstanceIdentifier,Size:DBInstanceClass,Status:DBInstanceStatus,AZ:AvailabilityZone,EngineVersion:EngineVersion}' --output table"
alias k='kubectl'


# Terraform
alias tfplan='terraform plan'
alias tfapply='terraform apply'
alias tffmt='terraform fmt'
alias tfinit='terraform init'
alias tflock='terraform providers lock -platform=windows_amd64 -platform=darwin_amd64 -platform=linux_amd64'
