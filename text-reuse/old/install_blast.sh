# For some reason gcc/9.1.0 doesn't compile BLAST. Go figure.
module load gcc/7.4.0
cd $HOME/customblast
# BLAST from 2.7.1 onward requires LMDB library. This will install it locally.
wget https://github.com/LMDB/lmdb/archive/LMDB_0.9.24.tar.gz
tar -xvf LMDB_0.9.24.tar.gz
cd lmdb-LMDB_0.9.24/libraries/liblmdb
export DESTDIR="$HOME/localinstall"
make
make install
unset DESTDIR
# add the install dir to path and to LMDB_PATH required for compiling BLAST.
export LMDB_PATH="$HOME/localinstall/usr/local"
export PATH="$PATH:$HOME/localinstall/usr/local/bin"
# compile BLAST. Modified version of source at $HOME/customblast/ncbi-blast-271-src-custom.tar.gz
cd $HOME/customblast
tar -xvf ncbi-blast-271-src-custom.tar.gz
cd ncbi-blast-2.7.1+-src/
cd c++/
./configure
make all_r
export PATH="$HOME/customblast/ncbi-blast-2.7.1+-src/c++/ReleaseMT/bin:$PATH"
