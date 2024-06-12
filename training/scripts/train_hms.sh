ROOT_PATH='PATH_CONTAINING_TRAINING_FODLER'
RUNNER_PATH='RUNNER_PATH_FROM_REPO'
CONFIG_NAME=$2
CONFIG_PATH=${ROOT_PATH}/training/exps/$1/config
LOG_DIR=${ROOT_PATH}/training/exps/$1/experiments/$3
mkdir -p $LOG_DIR
python ${RUNNER_PATH}/speech_to_text_hybrid_rnnt_ctc_bpe.py \
    --config-path=${CONFIG_PATH} \
    --config-name=${CONFIG_NAME} \
    +init_from_nemo_model=$4 \
    trainer.devices=-1 \
    trainer.accelerator="gpu" \
    trainer.strategy="ddp_find_unused_parameters_true" \
    exp_manager.name=$3 \
    exp_manager.wandb_logger_kwargs.name=$3 \
    exp_manager.explicit_log_dir=$LOG_DIR \
    exp_manager.resume_if_exists=$5
