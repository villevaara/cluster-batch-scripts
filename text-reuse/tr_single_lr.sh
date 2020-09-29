# takes three parameters
# -c [number of cores to use]
# -s [first iteration]
# -e [last iteration]

usage()
{
    echo "usage: tr_single_lr.sh [-c cores (default 40)] [-i iter] [-t time (default 14 days)]"
}

cores=40
iter=-1
time=336
error=0

while [ "$1" != "" ]; do
    case $1 in
        -c | --cores )          shift
                                cores=$1
                                ;;
        -i | --iter )          shift
                                iter=$1
                                ;;
        -t | --time )           shift
                                time=$1
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ $cores -eq -1 ]
then
    echo "Set cores (-c | --cores) to value between 1-40."
    error=1
fi
if [ $iter -eq -1 ]
then
    echo "Set iter (-i | --iter) value."
    error=1
fi
if [ $error -eq 1 ]
then
    exit 1
fi

echo "i$iter cores: $cores timelim: $time h"

sbatch --job-name=tr_q_i$iter --output=logs/s_i${iter}_%j.out --error=logs/err/s_i${iter}_%j.err --time=$time:00:00 --cpus-per-task=$cores text_reuse_blast_batches_main_small_qpi100_single_cores_lr.sh $cores $iter
