ROOT_PATH='/home/asr/tahir/cl-setup'
RUNNER_PATH=${ROOT_PATH}/training/runners
python ${RUNNER_PATH}/checkpoint_averaging.py ${ROOT_PATH}/training/exps/$1/experiments/$2



# name=hi-vistaar-iv-mxm-4x-mn
# steps=77k
# type=hybrid
# bash avg_checkpoint.sh $type ${name}
# mv /mnt/scratch/playground-nemo/training/exps/${type}/experiments/${name}/checkpoints/${name}-averaged.nemo /mnt/scratch/playground-nemo/checkpoints/finetuning/${name}-${steps}-avg.nemo