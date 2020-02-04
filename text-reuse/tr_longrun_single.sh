# takes one parameter
# 1$ batch number
echo "tr longrun i$1"
sbatch --job-name=tr_i$1 --output=logs/tr_i$1.out --error=logs/err/tr_i$1.err text_reuse_blast_batches_main_longrun_single.sh $1
