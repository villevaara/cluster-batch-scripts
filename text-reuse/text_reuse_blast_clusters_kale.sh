#!/bin/bash -l
#SBATCH --job-name=TR_clusterizer
#SBATCH --partition=long
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=40
#SBATCH --mem=64G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

#SBATCH --output=logs/tr_clusterizer.out
#SBATCH --error=logs/err/tr_clusterizer.err

# created: Aug 14, 2020
# author: Ville Vaara

# vars:
# 1: number of cores
# 2: iter#
# 3: time

cd /wrk/users/vvaara/blast_ecco
module load Python/3.6.6-intel-2018b
pip install -r requirements.txt --user
cd $WRKDIR/blast_ecco/code/work

export PATH="$WRKDIR/customblast/ncbi-blast-2.6.0+-src/c++/ReleaseMT/bin:$PATH"

echo "----------------------------------------------------------------------" 
echo "CLUSTERIZER"
echo "----------------------------------------------------------------------" 

srun python clusterizer.py --output_folder="$WRKDIR/txt_reuse/blast_work_from_puhti/blast_work" --node_similarity=1 --threads=40 --max_length=10000000
