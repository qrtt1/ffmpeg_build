target_dir=/opt/apps

if [ "ec2-user" == $(whoami) ]; then
  sudo mkdir -p $target_dir
  sudo mkdir -p /opt/ffmpeg
  sudo chown -R ec2-user:ec2-user $target_dir
  sudo chown -R ec2-user:ec2-user /opt/ffmpeg
fi

git submodule init
git submodule update --recursive
origin=$(pwd)
cd libmp3lame && ./configure && make -j8 install
cd $origin
cd x264 && ./configure --prefix=$target_dir --enable-static && make -j8 install
cd $origin
cd ffmpeg && PATH=$PATH:$target_dir/bin \
    PKG_CONFIG_PATH=$target_dir/lib/pkgconfig \
    CFLAGS=-I$target_dir/include \
    LDFLAGS="-L$target_dir/lib -lgnutls -lgcrypt" \
    ./configure  --enable-libx264 --enable-libmp3lame --enable-gpl --enable-gnutls && make -j8 install
