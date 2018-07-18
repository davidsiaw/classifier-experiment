

export ARCHITECTURE=mobilenet_v2_140_224
export LEARNING_RATE=0.001
export BATCH_SIZE=1000
python retrain.py \
        --bottleneck_dir=tf_files/bottlenecks \
        --train_batch_size=$BATCH_SIZE \
        --how_many_training_steps=2500   \
        --model_dir=tf_files/models/  \
        --learning_rate="${LEARNING_RATE}" \
        --summaries_dir=tf_files/training_summaries/"${ARCHITECTURE}/all15-rmsprop/mom-0.5/b${BATCH_SIZE}/LR_${LEARNING_RATE}" \
        --output_graph=tf_files/retrained_graph.pb   \
        --output_labels=tf_files/retrained_labels.txt   \
        --architecture="${ARCHITECTURE}" \
        --tfhub_module=https://tfhub.dev/google/imagenet/mobilenet_v2_140_224/classification/2 \
        --image_dir=neso_photos

