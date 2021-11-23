# terminator
install_terminator(){
sudo apt-get update
sudo apt-get install terminator
}

# git-cola
install_git_cola(){
	sudo apt install git-cola
}

# docker
install_docker(){
	sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get update
	sudo apt-get install \
	    apt-transport-https \
	    ca-certificates \
	    curl \
	    gnupg-agent \
	    software-properties-common

	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo add-apt-repository \
	   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	   $(lsb_release -cs) \
	   stable"

	 sudo apt-get update
	 sudo apt-get install docker-ce
}

install_nvidia_docker2(){
	# If you have nvidia-docker 1.0 installed: we need to remove it and all existing GPU containers
	docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
	sudo apt-get purge -y nvidia-docker

	# Add the package repositories
	curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
	  sudo apt-key add -
	distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
	curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
	  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
	sudo apt-get update

	# Install nvidia-docker2 and reload the Docker daemon configuration
	sudo apt-get install -y nvidia-docker2
	sudo pkill -SIGHUP dockerd
	sudo systemctl restart docker

	# add yourself to sudo group for docker
	sudo usermod -aG docker $USERNAME

	# Test nvidia-smi with the latest official CUDA image
	docker run --runtime=nvidia --rm nvidia/cuda:9.0-base nvidia-smi
}

setup_docker_permissions(){
	sudo usermod -a -G docker $USER
}

install_pip(){
	sudo apt update
	sudo apt install python-pip
}

install_python_packages(){
	sudo pip install pyyaml
}

install_openssh(){
	sudo apt install openssh-server
}

install_spotify(){
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update
	sudo apt-get install spotify-client
}


install_chrome(){
	cd ~/Downloads
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt install ./google-chrome-stable_current_amd64.deb
}

install_chrome_gnome_shell(){
	sudo apt-get install chrome-gnome-shell
}

install_ulauncher(){
	sudo add-apt-repository ppa:agornostal/ulauncher
	sudo apt update
	sudo apt install ulauncher
}

install_tmux(){
	sudo apt install tmux
}

install_nvidia_driver_11_5(){
	wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
	sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
	wget https://developer.download.nvidia.com/compute/cuda/11.5.0/local_installers/cuda-repo-ubuntu1804-11-5-local_11.5.0-495.29.05-1_amd64.deb
	sudo dpkg -i cuda-repo-ubuntu1804-11-5-local_11.5.0-495.29.05-1_amd64.deb
	sudo apt-key add /var/cuda-repo-ubuntu1804-11-5-local/7fa2af80.pub
	sudo apt-get update
	sudo apt-get -y install cuda
}


# install_sublime
# install_terminator
# install_git_cola
# install_docker
install_nvidia_docker2
# install_pip
# install_python_packages
# install_openssh
# install_spotify
# install_chrome
# install_chrome_gnome_shell
# install_ulauncher
# install_tmux
# setup_docker_permissions
# install_nvidia_driver_11_5
