# DICOM to NIfTI converison step

This step converts the data from one session of one specific subject, from DICOM format into NIfTI format.

## Input

The following inputs are expected:

* Name of the folders containing the target subject DICOM data.
* Name of the folder containing the from the target session DICOM data.
* Configuration file in `.json` format. The file should follow [these criteria](https://unfmontreal.github.io/Dcm2Bids/docs/3-configuration/).
* A subject ID which will be used to identify the subject from which the data belong. This should be the same for all the other time points which will be processed.
* A session ID which together with the subject ID will uniquely identify the session.

## Output

The unprocessed (raw) data in NIfTI format are converted and stored with a pre-defined folder structure and file names (following the BIDS standard).
For each NIfTI file, a sidecar file with same name and `.json` file format is also created, containing supplementary information about the MRI file.

Below is reported an example output, assuming the subject ID `001` and the session ID `01`:

```bash
<myDataAnalysis>/rawData/
├── sub-001
│   └── ses-01
│       ├── anat
│       │   ├── sub-001_ses-01_T1w.json
│       │   ├── sub-001_ses-01_T1w.nii.gz
│       │   ├── sub-001_ses-01_T2w.json
│       │   └── sub-001_ses-01_T2w.nii.gz
│       ├── dwi
│       │   ├── sub-001_ses-01_dir-AP_dwi.bval
│       │   ├── sub-001_ses-01_dir-AP_dwi.bvec
│       │   ├── sub-001_ses-01_dir-AP_dwi.json
│       │   ├── sub-001_ses-01_dir-AP_dwi.nii.gz
│       │   ├── sub-001_ses-01_dir-PA_dwi.bval
│       │   ├── sub-001_ses-01_dir-PA_dwi.bvec
│       │   ├── sub-001_ses-01_dir-PA_dwi.json
│       │   └── sub-001_ses-01_dir-PA_dwi.nii.gz
│       ├── fmap
│       │   ├── sub-001_ses-01_acq-rest_magnitude1.json
│       │   ├── sub-001_ses-01_acq-rest_magnitude1.nii.gz
│       │   ├── sub-001_ses-01_acq-rest_magnitude2.json
│       │   ├── sub-001_ses-01_acq-rest_magnitude2.nii.gz
│       │   ├── sub-001_ses-01_acq-rest_phasediff.json
│       │   └── sub-001_ses-01_acq-rest_phasediff.nii.gz
│       ├── func
│       │   ├── sub-001_ses-01_task-rest_bold.json
│       │   └── sub-001_ses-01_task-rest_bold.nii.gz
│       └── sub-001_ses-01_qc.txt
```

### Extra outputs

At the end of the DICOM to NIfTI converison step the following two files are produced to help the user to perform a quality check:

1. The file `<myDataAnalysis>/rawData/sub-<subID>/ses-<sesID>/sub-<subID>_ses-<sesID>_qc.txt` which ...
2. A 2D image of each of the NIfTI volume input.

## How to QC

What should you check to make sure the step ended successfully?

1. Check the  `<myDataAnalysis>/rawData/sub-<subID>/ses-<sesID>/sub-<subID>_ses-<sesID>_qc.txt` to make sure all the data you would expect are there.
2. Open one by one the Nifti images and check the quality of the data is good enough. You don't know how the data should look like? Check below for some examples.

#### T1w
![t1w](figs/rawData/anat/T1w.png)
#### T2w
![t1w](figs/rawData/anat/T2w.png)
#### DWI with anterior-posterior phase encoding
![t1w](figs/rawData/dwi/AP.png)
#### DWI with posterior-anterior phase encoding
![t1w](figs/rawData/dwi/PA.png)



