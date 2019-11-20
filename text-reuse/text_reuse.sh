#!/bin/bash
#SBATCH --job-name=textReuseECCO
#SBATCH --account=Project_2000230
#SBATCH --partition=test
#SBATCH --time=24:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=256G

cd /scratch/project_2000230/txt_reuse/blast_ecco/
module load python-data/3.7.3-1
source venv/bin/activate
pip install -r requirements.txt
cd /scratch/project_2000230/txt_reuse/blast_ecco/code/work
srun python data_preparer.py --data_location= "/scratch/project_2000230/txt_reuse/chunks_for_blast/" --output_folder="/scratch/project_2000230/txt_reuse/blast_work/" --language="ENG" --threads=1
