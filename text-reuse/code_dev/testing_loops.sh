# created: Feb 3, 2020
# author: Ville Vaara

# usage:
# You can pass an argument after the script as if you were running it directly on the shell like this:
# sbatch text_reuse_blast_batches_main_small_generic.sh [firstindex] [lastindex]
# eg.:
# sbatch text_reuse_blast_batches_main_small_generic.sh 700 709
# And then the arguments will be available inside the shell script as $1 $2
# for i in $(seq $1 $2)
# for i in {$1..$2}
# for ((i=$1; i<=$2; i++))
for i in `seq $1 $2`
do
   echo "Testing $i"
done
