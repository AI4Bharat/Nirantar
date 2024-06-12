# -------------------- DIL Full Finetune Example
type=DIL
config=dil_ep3_full_finetune # config name
name=${config} # name of the experiment
checkpoint_path=<starting_checkpoint>
resume=false # helpful for resuming training
bash train_hms.sh ${type} ${config} ${name} ${checkpoint_path} $resume

bash avg_checkpoint.sh TIDIL dil_ep3_full_finetune # averaging the top 5 checkpoints

# -------------------- LIDIL EWC ------------------------------------
type=LIDIL
config=dil_ep3_full_finetune # config name
name=${config} # name of the experiment
prev_episode_model=lidil_ep0_ewc # name of prev config
checkpoint_path=EXPERIMENTS_PATH/TIDIL/experiments/${prev_episode_model}/checkpoints/${prev_episode_model}-averaged.nemo
resume=false # helpful for resuming training
bash train_hms.sh ${type} ${config} ${name} ${checkpoint_path} $resume

bash avg_checkpoint_last.sh TIDIL dil_ep3_full_finetune