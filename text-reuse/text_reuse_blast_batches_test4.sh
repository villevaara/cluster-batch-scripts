#!/bin/bash
#SBATCH --job-name=TR_bb_t4_e-15
#SBATCH --account=Project_2000230
#SBATCH --partition=small
#SBATCH --time=72:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=20G
#SBATCH --gres=nvme:280
#SBATCH --output=std_t4.out
#SBATCH --error=std_t4.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

cd /scratch/project_2000230/txt_reuse/blast_ecco/
module load python-data/3.7.3-1
pip install -r requirements.txt --user
cd /scratch/project_2000230/txt_reuse/blast_ecco/code/work
export PATH="/scratch/project_2000230/txt_reuse/ncbi-blast-2.5.0+-src/c++/ReleaseMT/bin:$PATH"

echo "SHELLSCRIPT - $(date) - Copying data to LOCAL_SCRATCH"
scp -r /scratch/project_2000230/txt_reuse/blast_work $LOCAL_SCRATCH
echo "SHELLSCRIPT - $(date) - Copying done to LOCAL_SCRATCH"
srun python blast_batches.py  --output_folder="$LOCAL_SCRATCH/blast_work" --batch_folder="$LOCAL_SCRATCH/blast_work/data_out" --threads=20 --text_count=5203431 --qpi=100 --iter=0 --e_value=0.000000000000001
echo "BLAST CONF: --threads=20 --text_count=5203431 --qpi=100 --iter=0 --e_value=0.000000000000001"
echo "SHELLSCRIPT - $(date) - Python script done. Copying results."
cd /scratch/project_2000230/txt_reuse/blast_work_full_testsets_results
mkdir set4
scp -r $LOCAL_SCRATCH/blast_work/data_out /scratch/project_2000230/txt_reuse/blast_work_full_testsets_results/set4
echo "SHELLSCRIPT - $(date) - Job finished."