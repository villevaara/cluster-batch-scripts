# takes three parameters
# -c [number of cores to use]
# -s [first iteration]
# -e [last iteration]

usage()
{
    echo "usage: tr_arrayrange [-f cores] [-s start (in tens)] [-e end (in tens)] [-a addition] [-t time (default 8)]"
}

cores=-1
start=-1
end=-1
time=8
error=0
addition=0

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

actual_start=$((10*$start+$addition))
actual_end=$((10*$end+9+$addition))

echo -e "\ni$actual_start-$actual_end \ncores: $cores \ntime_limit: $time h \n"
sbatch --array=$start-$end --job-name=tr_q_i$actual_start-$actual_end --output=logs/ar_$actual_start-${actual_end}_i%a_%A.out --error=logs/err/ar_$actual_start-${actual_end}_i%a_%A.err --time=$time:00:00 --cpus-per-task=$cores text_reuse_blast_batches_main_small_qpi100_arrayrange_cores.sh $cores $addition
