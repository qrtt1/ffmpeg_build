git submodule init
git submodule update --recursive
origin=$(pwd)
cd libmp3lame && ./configure --prefix=/opt/apps && make -j8 install
cd $origin
cd sdl && CC=build-scripts/gcc-fat.sh ./configure --prefix=/opt/apps && CC=build-scripts/gcc-fat.sh make -j8 install
cd $origin
cd x264 && ./configure --prefix=/opt/apps --enable-static && make -j8 install
cd $origin
cd ffmpeg && PATH=$PATH:/opt/apps/bin \
    PKG_CONFIG_PATH=/opt/apps/lib/pkgconfig \
    CFLAGS=-I/opt/apps/include \
    LDFLAGS=-L/opt/apps/lib \
    ./configure --prefix=/opt/ffmpeg --enable-libx264 --enable-libmp3lame --enable-gpl && make -j8 install
