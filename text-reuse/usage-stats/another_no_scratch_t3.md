Job ID: 502267
Cluster: puhti
User/Group: vvaara/vvaara
State: COMPLETED (exit code 0)
Nodes: 1
Cores per node: 4
CPU Utilized: 1-19:09:19
CPU Efficiency: 65.85% of 2-17:31:52 core-walltime
Job Wall-clock time: 16:22:58
Memory Utilized: 415.27 MB
Memory Efficiency: 2.53% of 16.00 GB
Job consumed 91.74 CSC billing units based on following used resources
CPU BU: 65.53
Mem BU: 26.21

#!/bin/bash
#SBATCH --job-name=TR_bb_t3
#SBATCH --account=Project_2000230
#SBATCH --partition=small
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --output=std_t3.out
#SBATCH --error=std_t3.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

cd /scratch/project_2000230/txt_reuse/blast_ecco/
module load python-data/3.7.3-1
pip install -r requirements.txt --user
cd /scratch/project_2000230/txt_reuse/blast_ecco/code/work
export PATH="/scratch/project_2000230/txt_reuse/ncbi-blast-2.5.0+-src/c++/ReleaseMT/bin:$PATH"
srun python blast_batches.py  --output_folder="/scratch/project_2000230/txt_reuse/blast_work_full_testsets/set3" --batch_folder="/scratch/project_2000230/txt_reuse/blast_work_full_testsets/set3/data_out_e0_0000000000001_qpi10_i0_threads4" --threads=4 --text_count=5203431 --qpi=10 --iter=0 --e_value=0.0000000000001
