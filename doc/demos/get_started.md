# Get started

In oreder to get started, make sure you added the `LongAnMRI/matlab` folder to your MATLAB PATH ( check the [installation page](doc/installation/longan.md) for more info).

## Start a new analysis project

The first step to start a new analysis is to create the folder structure in which all the unprocessed (*raw*) data, pre-processed data, [image derived phenotypes](), and analysed data will be stored and organized.
You can do this via the `newAalysis()` MATLAB function.

Launch MATLAB and run the following command from command window:
```matalb
newAalysis('<path_to_new_project_folder>', '<path_DICOM_data>')
```

### Inputs

*`<path_to_new_project_folder>` is the path to the folder where the output of the analysis will be stored. For example, `/Users/<username>/myAnalyses/NewPlasticityProject`.

*`<path_DICOM_data>` is the path to the parent folder in which your acquired DICOM data are stored. This should NOT include subject subfolders. For example, if your DICOM data are organized in the following way:
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
The `'<path_DICOM_data>'` should be `'/Users/<username>/myProjectDICOMs'`. \\
NOTE: DICOM data are note compulsory but highly recommended. Check [here]() if you don't have access to DICOM data.

### Outputs

The `newAalysis()` functions creates a set of folders and files organized in the following way:
```bash
<path_to_new_project_folder>
├── LongAn_Setup.m
├── dataAnalysis
├── dataProcessing
├── logs
│   └── log_sub-XXX.txt
└── rawData
```
* `<path_to_new_project_folder>/rawData`: Is the folder in which the unprocessed (raw) data will be stored after conversion fron DICOM to NIfTI format.
* `<path_to_new_project_folder>/dataProcessing`: Is the folder in which the pre-processed data, as well as the image derived penotypes and their derivaes, will be stored.
* `<path_to_new_project_folder>/dataAnalysis`: This folder will store the output of population based analysis.
* `<path_to_new_project_folder>/logs`: The *log* folder stores matlab script in which each step of the analysis, from conversion to data analysis will be stored and documented.
* `<path_to_new_project_folder>/logs/log_sub-XXX.txt`: It is a matlab script template saved as a text file to log all the subject specific steps of the analysis. Every time the user start a new subject analysis, he/she should copy and paste the template, modyifing the name consistently with the subject ID and changing the file extension from *.txt* to *.m*.
* `<path_to_new_project_folder>/LongAn_Setup.m`: It is a script used for configuration. The user should set it up only once, before starting the analysis (see next section).

## LongAn_Setup.m file configuration

After creatig the analysis framework, next step is to configure the `LongAn_Setup.m` file. To do so, the user should fill the empty fileds in the script, recording the full paths to the folders of the external sofware and toolboxes used by this software:

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

## Start a new subject analysis

In order to start a new subject analysis the first thing to do is to duplicate the `<path_to_new_project_folder>/logs/log_sub-XXX.txt` file ino the `<path_to_new_project_folder>/log` folder. You should change the file extension from *.txt* to *.m* and modify the file name so to include an ID you would like to assinge to the subject. Assuming the ID is `001`, you could type from commnad line:
```bash
mv <path_to_new_project_folder>/log/log_sub-XXX.txt <path_to_new_project_folder>/log/log_sub-001.m
```

Next step is to fill some of the empty value


