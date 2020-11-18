# Ungzip
find . -name "*.nii.gz" | xargs -i gunzip {}

# Define
COMMAND_MATLAB=$(command -v matlab)
SPM=.'/spm8'
NIFTI='./NIfTI_20130306'

for SUB in $(ls -F Data | grep / | cut -d / -f1); do
    # Define
    INPUT_L="./Data/${SUB}/1mm_ROI_L_3_MNI_relabel_group.nii"
    INPUT_R="./Data/${SUB}/1mm_ROI_R_3_MNI_relabel_group.nii"
    OUTPUT=""./Data/${SUB}""
    REFIMG="./Data/${SUB}/b0.nii"
    MAT="./Data/${SUB}/diff2MNI_sn.mat"

    # Apply Deformation for left ROI
    echo "SUBDIR: ${SUB}"
    echo "INPUT_L: ${INPUT_L}"
    echo "INPUT_R: ${INPUT_R}"
    echo "OUTPUT: ${OUTPUT}"
    echo "REFIMG: ${REFIMG}"
    echo "MAT: ${MAT}"
    ${COMMAND_MATLAB} -nodisplay -nosplash -r \
        "addpath('${PIPELINE}');addpath('${SPM}');addpath('${NIFTI}');\
spm_util_deform_inv('${INPUT_L}','${OUTPUT}','${REFIMG}','${MAT}');\
exit"

    # Apply Deformation for Right ROI
    ${COMMAND_MATLAB} -nodisplay -nosplash -r \
        "addpath('${PIPELINE}');addpath('${SPM}');addpath('${NIFTI}');\
spm_util_deform_inv('${INPUT_R}','${OUTPUT}','${REFIMG}','${MAT}');\
exit"

done
