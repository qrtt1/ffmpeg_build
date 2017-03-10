sudo yum update -y
sudo yum install -y git gcc48-c++.x86_64 yasm.x86_64 gnutls-devel.x86_64

KNOWN_HOSTS=~/.ssh/known_hosts
REPO=https://github.com/qrtt1/ffmpeg_build.git

mkdir -p .ssh
touch $KNOWN_HOSTS

if [ "0" == $(grep -c github $KNOWN_HOSTS) ]; then
  ssh-keyscan github.com >> ~/.ssh/known_hosts
fi

git clone $REPO
