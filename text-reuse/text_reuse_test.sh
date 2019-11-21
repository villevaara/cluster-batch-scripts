#!/bin/bash
#SBATCH --job-name=textReuseECCO
#SBATCH --account=Project_2000230
#SBATCH --partition=small
#SBATCH --time=05:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=128G
#SBATCH --output=std.out
#SBATCH --error=std.err
#SBATCH --mail-type=ALL
#SBATCH --mail-user=villepvaara@gmail.com

cd /scratch/project_2000230/txt_reuse/blast_ecco/
module load python-data/3.7.3-1
rm -r venv
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cd /scratch/project_2000230/txt_reuse/blast_ecco/code/work
export PATH="/scratch/project_2000230/txt_reuse/ncbi-blast-2.5.0+-src/c++/ReleaseMT/bin:$PATH"
srun python data_preparer.py --data_location="/scratch/project_2000230/txt_reuse/chunks_test/" --output_folder="/scratch/project_2000230/txt_reuse/blast_work_test/" --language="ENG" --threads=1
