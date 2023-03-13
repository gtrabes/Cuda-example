#!/bin/bash

MODEL=CellDEVSSirDVFS
COMPUTER=Desktop
FILENAME="./results/TimeGPU${MODEL}${COMPUTER}.csv"
ITERATIONS=1
#SIZE=1000
#TIMES=(1000 2000 3000 4000 5000 6000 7000 8000 9000 10000)

SIZE=1000
TIMES=(1 2 3 4 5 6 7 8 9 10)
FREQUENCIES=(300, 630, 960, 1290, 1620, 1950)

mkdir -p results



for FREQ in ${FREQUENCIES[@]}
    for TIME in ${TIMES[@]}; do

        echo "FREQUENCY: $FREQUENCY"
        echo "FREQUENCY: $FREQUENCY" >> $FILENAME
        
        sudo nvidia-smi -i 0,1 -lgc $FREQ,$FREQ



#    TIME_SEQUENTIAL=0.0
#    TIME_STATIC=0.0
        TIME_GPU=0.0
        TIME_MULTI_GPU=0.0    
        
        echo "SIZE: $SIZE"
        echo "SIZE: $SIZE" >> $FILENAME
        echo "TIME: $TIME"
        echo "TIME: $TIME" >> $FILENAME
    
#    echo "SEQUENTIAL"
#    echo "SEQUENTIAL" >> $FILENAME
#    for i in `seq 1 $ITERATIONS`; do
#        echo "ITERATION: ${i}"
#        ITERATION=$(bin/celldevs_benchmark_sequential $SIZE $TIME)
#        echo $ITERATION
#        TIME_SEQUENTIAL=$(echo "$TIME_SEQUENTIAL + $ITERATION" | bc -l)
#    done
    
#    TIME_SEQUENTIAL=$(echo "$TIME_SEQUENTIAL / $ITERATIONS" | bc -l)
#    echo $TIME_SEQUENTIAL >> $FILENAME

#    echo "STATIC PARALLEL WITH 8 THREADS"
#    echo "STATIC PARALLEL WITH 8 THREADS" >> $FILENAME
#    for i in `seq 1 $ITERATIONS`; do
#        echo "ITERATION: ${i}"
#        ITERATION=$(bin/celldevs_benchmark_static_parallel_numa $SIZE $TIME 6)
#        echo $ITERATION
#        TIME_STATIC=$(echo "$TIME_STATIC + $ITERATION" | bc -l)
#    done
    
#    TIME_STATIC=$(echo "$TIME_STATIC / $ITERATIONS" | bc -l)
#    echo $TIME_STATIC >> $FILENAME

#    echo "NAIVE GPU"
#    echo "NAIVE GPU" >> $FILENAME
#    for i in `seq 1 $ITERATIONS`; do
#        echo "ITERATION: ${i}"
#        ITERATION=$(bin/celldevs_sir_naive_gpu $SIZE $TIME)
#        echo $ITERATION
#        TIME_NAIVE_GPU=$(echo "$TIME_NAIVE_GPU + $ITERATION" | bc -l)
#   done
    
            TIME_NAIVE_GPU=$(echo "$TIME_NAIVE_GPU / $ITERATIONS" | bc -l)
            echo $TIME_NAIVE_GPU >> $FILENAME
    
            echo "GPU"
            echo "GPU" >> $FILENAME
            for i in `seq 1 $ITERATIONS`; do
                echo "ITERATION: ${i}"
                ITERATION=$(bin/celldevs_sir_gpu $SIZE $TIME)
                echo $ITERATION
                TIME_GPU=$(echo "$TIME_GPU + $ITERATION" | bc -l)
            done
    
            TIME_GPU=$(echo "$TIME_GPU / $ITERATIONS" | bc -l)
            echo $TIME_GPU >> $FILENAME
    
            echo "MULTIGPU"
            echo "MULTIGPU" >> $FILENAME
            for i in `seq 1 $ITERATIONS`; do
                echo "ITERATION: ${i}"
                ITERATION=$(bin/celldevs_sir_multi_gpu $SIZE $TIME)
                echo $ITERATION
                TIME_MULTI_GPU=$(echo "$TIME_MULTI_GPU + $ITERATION" | bc -l)
            done
    
            TIME_MULTI_GPU=$(echo "$TIME_MULTI_GPU / $ITERATIONS" | bc -l)
            echo $TIME_MULTI_GPU >> $FILENAME
    done
done
