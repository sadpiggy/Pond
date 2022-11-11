if [[ $# != 1 && $# != 2 ]]; then
    echo ""
    echo "Run all workloads: $0 w.txt"
    echo "Run one workload:  $0 w.txt 2 --> run the 2nd workload in w.txt"
    echo ""
    exit
fi

WF=$1
WID=$2

if [[ $# == 1 ]]; then
    warr=($(cat $WF | awk '{print $1}'))
    marr=($(cat $WF | awk '{print $2}'))
elif [[ $# == 2 ]]; then
    warr=($(cat w.txt | awk -vline=$WID 'NR == line {print $1}'))
    marr=($(cat w.txt | awk -vline=$WID 'NR == line {print $2}'))
fi


# WF=$1
# WID=$2

# if [[ $# == 1 ]]; then
#     warr=($(cat $WF | awk '{print $1}'))
#     marr=($(cat $WF | awk '{print $2}'))
# elif [[ $# == 2 ]]; then
#     warr=($(cat w.txt | awk -vline=$WID 'NR == line {print $1}'))
#     marr=($(cat w.txt | awk -vline=$WID 'NR == line {print $2}'))
# fi


echo $WF
echo $WID
echo $warr
echo $marr