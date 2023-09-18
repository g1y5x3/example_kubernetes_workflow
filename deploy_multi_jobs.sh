#!/bin/bash
var1="name"
base_num=73
# 40 for vowels
# 73 for voices

for var2_value in {41..72};
do
    var1_value="cpu-job-$(($var2_value + $base_num))"

    # Use yq to update the YAML file
    yq eval ".metadata.${var1} = \"${var1_value}\"" -i EXP_LOO_Vowels_Job.yaml
    yq eval '.spec.template.spec.containers[0].args[0] |= sub("-s [0-9]+", "-s '$var2_value'")' -i EXP_LOO_Vowels_Job.yaml
    kubectl apply -f EXP_LOO_Vowels_Job.yaml
    
    # yq eval ".metadata.${var1} = \"${var1_value}\"" -i EXP_LOO_Voices_Job.yaml
    # yq eval '.spec.template.spec.containers[0].args[0] |= sub("-s [0-9]+", "-s '$var2_value'")' -i EXP_LOO_Voices_Job.yaml
    # kubectl apply -f EXP_LOO_Voices_Job.yaml
done