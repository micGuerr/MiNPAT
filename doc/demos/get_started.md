# Get started

In oreder to get started, make sure you added the `LongAnMRI/matlab` folder to your MATLAB PATH ( check the [installation page](doc/installation/longan.md) for more info).

## Start a new analysis project

The first step to start a new analysis is to create the folder structure in which all the unprocessed (*raw*) data, pre-processed data, and analysed data will be stored.
You can do this via the `newAalysis()` MATLAB function.

Launch MATLAB and run the following command from command window:
```matalb
newAalysis('<path_to_new_project_folder>', '<path_DICOM_data>')
```

`'<path_to_new_project_folder>'` being the path to the folder where the output of the analysis will be stored. For example, it could be something like `/Users/<username>/myAnalyses/NewPlasticityProject`

`'<path_DICOM_data>'` being the path to the parent folder in which your acquired DICOM data are stored. This should NOT include subject subfolders. For example, if your DICOM data are organized in the following way:
```bash
/Users/<username>/myProjectDICOMs/
├── subj-01
│   ├── ses-01
│   └── ses-02
├── subj-02
│   ├── ses-01
│   └── ses-02
├── subj-03
│   ├── ses-01
│   └── ses-02
├──...
```
The `'<path_DICOM_data>'` should be `'/Users/<username>/myProjectDICOMs'`.

NOTE: DICOM data are note compulsory but highly recommended. Check [here]() if you don't have access to DICOM data.


## Setup paths/variables in MATLAB

[Add](https://it.mathworks.com/help/matlab/matlab_env/add-remove-or-reorder-folders-on-the-search-path.html) the folder containing the source code of LongAnMRI to your [MATLAB PATH](https://it.mathworks.com/help/matlab/matlab_env/what-is-the-matlab-search-path.html).

Copy the file LongAn_Setup.txt and rename it to LongAn_Setup.m. Modify its content to set the paths to your specific needs, as follows:

### Software paths
- `DCM2NIIX`: path to the folder containing the *dcm2niix* software (e.g. `/Users/username/Apps/dcm2niix`).
- `DCM2BIDS`: path to the folder containing the *Dcm2Bids* software (e.g. `/Users/username/.local/bin/dcm2bids`).
- `FSLDIR`: path to the folder containing the *dcm2niix* software (e.g. `/bin/local/fsl`).
- `DTITK`: path to the folder containing the *dcm2niix* software (e.g. `/Users/username/Apps/DTI-TK`).
- `FREESURFER_HOME`: path to the folder containing the *dcm2niix* software (e.g. `/Users/username/Apps/freesurfer-7.X.X`).
- `LONGANMRI`: path to the folder containing the *dcm2niix* software (e.g. `/Users/username/Apps/LaonAnMRI`).
- `NODDI` : path to the folder containing the *dcm2niix* software (e.g. `/Users/username/MATLAB/NODDI_toolbox_vXXX`).

 ### Data analysis paths
- `DCMDIR`: path to the folder where the DICOM data are stored. `DICOMDIR` should contain subfolders containing data for the different subjects.
- `CONFIGFILE`: configuration file (*json* format) which tells Dcm2Bids what file to expect and how to organize the DICOM conversion output. Check [here](https://unfmontreal.github.io/Dcm2Bids/docs/2-tutorial/) for more information.
- `RAWDIR`: path to the folder where NIfTI converted **unprocessed** data will be stored.
- `PROCDIR`: path to the folder where processed data will be stored.
