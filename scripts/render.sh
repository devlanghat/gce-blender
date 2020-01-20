#!/bin/bash
gsutil cp -r gs://blend/assets .
gsutil cp gs://blend/blender/$BLEND_FILE .
/blender/blender -b -noaudio -E CYCLES -P force_gpu.py $BLEND_FILE -f 1
TS=`date "+%Y%m%d-%H%M%S"`
gsutil cp /tmp/0001.png gs://blend/output/$BLEND_FILE.$TS.png
