# takes two parameters
# 1$ start batch
# 2$ end batch
echo "tr small i$1-$2"
sbatch --job-name=tr_i$1-$2 --output=logs/tr_i$1-$2.out --error=logs/err/tr_i$1-$2.err text_reuse_blast_batches_main_small_range.sh $1 $2
