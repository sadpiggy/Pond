#!/bin/bash

function showArr(){

    a=$1
    local cxl_exparr_name=$1[@]
    local cxl_exparr=( "${!cxl_exparr_name}" )

    echo $cxl_exparr_name
    echo $cxl_exparr

    # for i in ${arr[@]}; do
    #     echo $i
    # done

}

regions=("GZ" "SH" "BJ")

showArr "${regions[*]}"

exit 0