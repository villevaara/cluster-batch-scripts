# For some reason gcc/9.1.0 doesn't compile BLAST. Go figure.
module load gcc/7.4.0
cd $HOME/customblast
# compile BLAST. Modified version of source at $HOME/customblast/ncbi-blast-2.6.0-src-custom.tar.gz
cd $HOME/customblast
tar -xvf ncbi-blast-2.6.0-src-custom.tar.gz
cd ncbi-blast-2.6.0+-src/
cd c++/
./configure
make all
export PATH="$HOME/customblast/ncbi-blast-2.6.0+-src/c++/ReleaseMT/bin:$PATH"
