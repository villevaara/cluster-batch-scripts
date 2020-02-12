# takes three parameters
# -c [number of cores to use]
# -s [first iteration]
# -e [last iteration]

usage()
{
    echo "usage: tr_small_array_cores [-f cores] [-s start] [-e end]"
}

cores=-1
start=-1
end=-1
time=4
error=0
addition=-1

while [ "$1" != "" ]; do
    case $1 in
        -c | --cores )          shift
                                cores=$1
                                ;;
        -s | --start )          shift
                                start=$1
                                ;;
        -e | --end )            shift
                                end=$1
                                ;;
        -t | --time )           shift
                                time=$1
                                ;;
        -a | --addition )       shift
                                addition=$1
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
if [ $start -eq -1 ]
then
    echo "Set start (-s | --start) value."
    error=1
fi
if [ $end -eq -1 ]
then
    echo "Set end (-e | --end) value."
    error=1
fi
if [ $error -eq 1 ]
then
    exit 1
fi

actual_start=$(($addition+$start))
actual_end=$(($addition+$end))

echo "i$actual_start-$actual_end (addition $addition) cores: $cores timelim: $time h"

sbatch --array=$start-$end --job-name=tr_q_i$actual_start-$actual_end --output=logs/tr_q_i$actual_start-$actual_end_%a_%A.out --error=logs/err/tr_q_i$actual_start-$actual_end_%a_%A.err --time=$time:00:00 --cpus-per-task=$cores text_reuse_blast_batches_main_small_qpi100_array_cores.sh $cores $addition
