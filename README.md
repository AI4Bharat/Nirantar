# Nirantar

We present Nirantar based on a large-scale effort to collect extempore and conversational speech data from participants spanning 22 languages across diverse locations in India. Given the extensive number of languages and locations involved, data is collected in incremental batches. Each batch introduces new languages, new domains (locations), or both, creating a practical playground for continual learning (CL). Nirantar contains a total of 3240 hours of human-transcribed speech data covering 208 Indian districts across 22 languages, with 1780 hours newly released as a part of this work. The data inflow and resulting multilingual multi-domain episodes are based on real-world data collection rather than simulated episodes commonly found in existing CL datasets. In particular, the amount of data collected, and the number of languages and domains involved is not uniform across episodes, reflecting a practical and real world continual learning scenario. This dataset serves as a playground for training and evaluating CL approaches in three different scenarios: Language-Incremental (LIL), Domain-Incremental (DIL), and the novel Language-Incremental Domain-Incremental Learning (LIDIL). To establish the dataset's usefulness, we evaluated several existing CL approaches within these scenarios. Our findings indicate that the behavior of these algorithms varies across the three scenarios, emphasizing the need for detailed independent studies of each.

# Resources

### Audio Data


|[Part 1](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/AUDIOS.tgz.aa) | [Part 2](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/AUDIOS.tgz.ab) | [Part 3](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/AUDIOS.tgz.ac) | [Part 4](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/AUDIOS.tgz.ad) | [Part 5](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/AUDIOS.tgz.ae) |
|-|-|-|-|-|

For extraction, please use the following command
    
    cat AUDIOS.tgz.* > AUDIOS.tgz
    tar -xzvf AUDIOS.tgz

### Episodic Manifests: 
These episodic manifests hold the labels (i.e transcript) for three scenatios viz, Language Incremental Learning (LIL), Domain Incremental Learning (DIL) and Language and Domain Incremental Learning (LIDIL). In addition to the transcript, the manifests also contains additional information viz speaker_id, gender, age-group, state, district etc.

| **Scenario** | [LIL](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/LIL.tgz) | [DIL](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/DIL.tgz) | [LIDIL](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/LIDIL.tgz) |
|-|-|-|-|

<br>

**Folder structure:**

    ROOT
    ├── DIL
    │   ├── episode0
    │   │   ├── episode0_train.json
    │   │   ├── episode0_valid.json
    │   │   ├── episode0_replay.json
    │   ├── episode1
    │   ├── ...
    │   └── episode11
    ├── LIDIL
    │   ├── episode0
    │   │   ├── episode0_train.json
    │   │   ├── episode0_valid.json
    │   │   ├── episode0_replay.json
    │   ├── episode1
    │   ├── ...
    │   └── episode9
    └── LIL
        ├── episode0
        │   ├── episode0_train.json
        │   ├── episode0_valid.json
        │   ├── episode0_replay.json
        ├── episode1
        ├── ...
        └── episode9



### Evaluation Splits
The evaluation is not splitted into episodes but is continually evolving. The episodic evaluations can be run using the language, state and district information as shared in the Metadata section

|Test| [Nirantar](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/LIDIL.tgz) |
|-|-|

<br>

**Folder structure**
        
    ROOT
    ├── audios
    │   ├── audio1.wav
    │   ├── audio2.wav
    │   ├── ...
    │   └── audioX.wav
    └── test.json

### Metadata
The following `CSVs` hold the mapping of episode number with the language, state and district of an audio file. For fine-grained evaluation on the test split, the metadata can be used.

| Metadata | [LIL.csv](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/LIL.csv) | [DIL.csv](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/DIL.csv) | [LIDIL.csv](https://indic-asr-public.objectstore.e2enetworks.net/nirantar/LIDIL.csv) |
|-|-|-|-|
 
<br>

**Manifest format (train/test splits)**

    {
        "audio_filepath": "audios/2533274790514854_chunk_4.wav",                                 # Points to the wav file
        "text": "<TRANSCRIPT>",                       # Transcript for audio, we use Normalized version of the transcript
        "duration": <DURATION>,                                                              #  audio duration in seconds
        "lang": "<LANG_CODE(ISO)>",                                          # ISO code for language (given in meta data)
        "samples": <NUMBER_OF_SAMPLES>,                                                               # Number of samples
        "verbatim": "<VERBATIM VERSION OF TRANSCRIPT>",                              # Verbatim version of the transcript
        "normalized": "<NORMALIZE>",                                               # Normalized version of the transcript
        "speaker_id": "S4258780200341914",                                                            # Unique speaker ID
        "scenario": "Extempore",                                                                           # Type of data
        "task_name": "KYP - Traveling",                                                                       # Task name
        "gender": "Male",                                                                         # Gender of the speaker
        "age_group": "18-30",                                                                  # Age group of the speaker
        "job_type": "Student",                                                                  # Job type of the speaker
        "qualification": "Undergrad and Grad.",                                            # Qualification of the speaker
        "area": "Rural",                                                            # Area from which the speaker belongs
        "district": "Barpeta",                                                  # District from which the speaker belongs
        "state": "Assam",                                                          # Dtate from which the speaker belongs
        "occupation": "Private tutor",                                                              # Speakers occupation
        "verification_report": "{}"                                        # Verification markers as given by the QA team
        "chunk_name": "2533274790514854_chunk_4.wav"}                                                  # audio chunk name




# Training and Inference

- Install [NeMo](https://github.com/AI4Bharat/NeMo.git) 
- For Training

    ```
    # -------------------- DIL Full Finetune Example ------------------------------------
    type=DIL
    config=dil_ep3_full_finetune # config name
    name=${config} # name of the experiment
    checkpoint_path=<starting_checkpoint>
    resume=false # helpful for resuming training
    bash training/scripts/train_hms.sh ${type} ${config} ${name} ${checkpoint_path} $resume

    bash avg_checkpoint.sh TIDIL dil_ep3_full_finetune # averaging the top 5 checkpoints
    ```

- For Inference

    ```
    OMP_NUM_THREADS=64 python ${RUNNER_PATH}/transcribe_speech.py \
        model_path=$model_path \
        dataset_manifest=<PLACEHOLDER>/$language.json \
        output_filename=$SAVE_PATH \
        langid=$LANGUAGE_ID \
        batch_size=$BATCH_SIZE \
        compute_timestamps=False \
        compute_langs=False \
        cuda=$CUDA_DEVICE_ID \
        amp=True \
        append_pred=False 
    ```

# Contact
- Tahir Javed (tahir@cse.iitm.ac.in)
- Kaushal Bhogale (CS22D006@cse.iitm.ac.in)
- Mitesh M. Khapra (miteshk@cse.iitm.ac.in)
    



