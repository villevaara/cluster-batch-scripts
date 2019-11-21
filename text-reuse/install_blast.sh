module load python-data/3.7.3-1
cd /scratch/project_2000230/txt_reuse
wget http://bionlp-www.utu.fi/blast_hum/ncbi-blast-2.5.0+-src.tar.gz
tar -xvf ncbi-blast-2.5.0+-src.tar.gz
cd ncbi-blast-2.5.0+-src/
cd c++/
./configure
make
export PATH="/scratch/project_2000230/txt_reuse/ncbi-blast-2.5.0+-src/c++/ReleaseMT/bin:$PATH"
