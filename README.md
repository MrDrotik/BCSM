# BCSM
cs 1.6 client in docker

# Executing
`sudo docker run --net=host --device /dev/snd -e "DISPLAY" -v $HOME/.Xauthority:/root/.Xauthority:rw mrdrotik/bcsm`
