#!/usr/bin/env bash
# author: Matt

DIR="tests"
HEAP_SIZE=4997

make
cd $DIR

LOOP_NUM=0
MATCHING=0

for IN_FILE in $(ls da*.in)
do
    LOOP_NUM=$((LOOP_NUM+1))

    printf "\n"
    echo "Test number $LOOP_NUM: $IN_FILE"
    BASE_FILE=${IN_FILE%.in}
    
    OUT_FILE="$BASE_FILE.out"
    ../test3 $HEAP_SIZE < $IN_FILE &> $OUT_FILE

    EXP_FILE="$BASE_FILE.exp"
    if ! [ -f $EXP_FILE ]
    then
        echo "!!! Can't find the file $EXP_FILE !!!"
        continue
    fi

    DIFF=$(diff $OUT_FILE $EXP_FILE &)
    if [ "$DIFF" != "" ]
    then
        printf "\n"
        echo ""
        echo "Different output!"
        echo "${DIFF:0:100}"
        printf "\n\n"
    else
        echo " - Same output"
        MATCHING=$((MATCHING+1))
    fi
done

printf "\n================================\n\n"
echo " < < <   Matching $MATCHING/$LOOP_NUM   > > >"
printf "\n"