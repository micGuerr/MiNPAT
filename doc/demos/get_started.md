# Get started

In oreder to get started, make sure you added the `MiNPAT/matlab` folder to your MATLAB PATH ( check the [installation page](../installation/minpat_install.md) for more info).

## 1. Start a new analysis project

The first step to start a new analysis is to create the folder structure in which all the unprocessed (*raw*) data, the pre-processed data, the [image derived phenotypes](), and the analysed data will be stored and organized.
You can do this by running the `startNewProcessing()` function from Matlab:

1. First, launch Matlab. We strongly recommend to do so from the terminal. If you don't know how to do it, open Matlab the way you normally do and type from command window `matlabroot`. Keep track of the output and close Matlab. Now open a terminal, copy and paste the outptut from previous command and add `/bin/matlab` with no spaces. Type enter.

On Mac the command should look something like this:
```bash
/Applications/MATLAB_R2018b.app/bin/matlab
```

2. Now run the `startNewProcessing()` function from Matlab command window, making sure you select the appropriate inputs (see Input subsection below):
```matalb
startNewProcessing('<path_to_new_project_folder>', '<path_DICOM_data>')
```

### Input

* `<path_to_new_project_folder>` is the path to the folder where the output of the analysis will be stored. For example, `/Users/<username>/myAnalyses/NewPlasticityProject`. If the folder doesn't exist, it will be automatically created.

* `<path_DICOM_data>` is the path to the parent folder in which your acquired DICOM data are stored. This should NOT include subject subfolders. For example, if your DICOM data are organized in the following way:
```bash
/Users/<username>/myProjectDICOMs/
├── S01/
│   ├── s12345/
│   └── s12346/
├── S02/
│   ├── s12347/
│   └── s12348/
├── S03/
│   ├── s12349/
│   └── s12350/
├──...
```
The `'<path_DICOM_data>'` should be `'/Users/<username>/myProjectDICOMs'`.

NOTE: DICOM data are note compulsory but highly recommended. Check [here]() if you don't have access to DICOM data.

### Output

The `startNewProcessing()` function creates a set of folders and files organized in the following way:
```bash
<path_to_new_project_folder>
├── config/
│   └── pathSetup.m
├── dataAnalysis/
├── dataProcessing/
├── logs/
└── rawData/
```
* `<path_to_new_project_folder>/rawData/`: Is the folder in which the unprocessed (raw) data will be stored after conversion fron DICOM to NIfTI format.
* `<path_to_new_project_folder>/dataProcessing/`: Is the folder in which the pre-processed data, as well as the image derived phenotypes and their derivatives, will be stored.
* `<path_to_new_project_folder>/dataAnalysis/`: This folder will store the output of population based analysis.
* `<path_to_new_project_folder>/logs/`: The *log* folder stores matlab script in which each step of the analysis, from conversion to data analysis will be stored and documented.
* `<path_to_new_project_folder>/config/`: It is a folder where several configuration files will be stored.
* `<path_to_new_project_folder>/config/pathSetup.m`: It is a Matlab function used for configuration. The user should set it up only once, before starting the analysis (see next section).

## 2. pathSetup.m file configuration

After creatig the analysis framework, next step is to make sure the `<path_to_new_project_folder>/config/pathSetup.m` file is well configured. This function is used to configure all the relevant external software. If the software are already well configured into your system there will be very little you will need to do. Otherwise, you will need to fill in the full paths to each missing software.

1. Open `<path_to_new_project_folder>/config/pathSetup.m` in Matlab. 
2. Fill in the paths to the software consistently. The field you should change are clearly labeled.

Below, an explanation of each of the fields.

### Software paths
- `DICOM2NIIX`: path to the folder containing the *dcm2niix* software (e.g. `/Users/username/Apps/dcm2niix`).
- `DICOM2BIDS`: path to the folder containing the *Dcm2Bids* software (e.g. `/Users/username/.local/bin/dcm2bids`).
- `FSLDIR`: path to the folder containing the *dcm2niix* software (e.g. `/bin/local/fsl`).
- `DTITK`: path to the folder containing the *dcm2niix* software (e.g. `/Users/username/Apps/DTI-TK`).
- `FREESURFER_HOME`: path to the folder containing the *dcm2niix* software (e.g. `/Users/username/Apps/freesurfer-7.X.X`).
- `MINPAT`: path to the folder containing the *dcm2niix* software (e.g. `/Users/username/Apps/MiNPAT`).
- `NODDI` : path to the folder containing the *dcm2niix* software (e.g. `/Users/username/MATLAB/NODDI_toolbox_vXXX`).

 ### Data analysis paths
- `DICOMDIR`: path to the folder where the DICOM data are stored. `DICOMDIR` should contain subfolders containing data for the different subjects.
- `RAWDIR`: path to the folder where NIfTI converted **unprocessed** data will be stored.
- `SUBANDIR`: path to the folder where subject level and session leve analysis will be stored.
- `POPANDIR`: path to the folder where processed data will be stored.

## 3. Setup a new session/subject analysis

Let's see now how to start the analysis of a new session of a specific subject. This can be done via the `startNewSesAnalysis()` Matlab function.
This function will create all you need to run the session analysis.

### Input

The input you need to run this function are:

* A subject ID you would like to assigne to the target subject. This should remain the same every time you start the analysis of a new session of the same subject (e.g. `001`).
* A session ID you would like to assigne to the target session. The subject ID and the sesison ID together will uniquely identify your session (e.g. `01`).
* The name of the folder (NOT the path to the folder) containing the DICOM data of the target subject (e.g. `S01`).
* The name of the folder (NOT the path to the folder) containing the DICOM data of the target session (e.g. `s12345`).
* The path to the session specific *.json* configuration file nedded for [DICOM to NIfTI conversion](https://unfmontreal.github.io/Dcm2Bids/docs/3-configuration/) (e.g. `/Users/<username>/myBIDSconfigFile.json`)
* (This is a bit tricky): Representative ...
* There are some processes which can exploit parallel computing. You can enter the number of cores you would like to use. Leave empty if you don't know what toinput.

An example input for this command is:
```matlab
startNewSesAnalysis('001', '01', 'S01', 's12345', '/Users/<username>/myBIDSconfigFile.json', {'localizer', 'noise'}, 4);
```
or alternatively
```matlab
startNewSesAnalysis('001', '01', 'S01', 's12345', '/Users/<username>/myBIDSconfigFile.json', '', '');
```

It may happen that the same session DICOM data is stored in multiple different folders.
If this is the case you can use the following command:
```matlab
startNewSesAnalysis('001', '01', 'S01', {'s12345a', 's12345b', 's12345c'}, '/Users/<username>/myBIDSconfigFile.json', {'localizer', 'noise'}, 4);
```
where `s12345a`, `s12345b`, `s12345c` are the names of the folders containing that specific session DICOM data.

### Output

This step creates the following folders and files into the folder structure previously created by the `startNewProcessing()` function:

```bash
<path_to_new_project_folder>
├── config/
├── dataAnalysis/
├── dataProcessing/
├── logs/
    └── sub-<subID>/
        ├── ses-<sesID>
        │   └── sub-<subID>_ses-<sesID>_log.txt
        └── log_sub<subID>.m
```

* `<path_to_new_project_folder>/logs/sub-<subID>/`: It creates a specific folder for the target subject, using the input subject ID.
* `<path_to_new_project_folder>/logs/sub-<subID>/ses-<sesID>/`:It creates a specific folder for the target session, using the input session ID.
* `<path_to_new_project_folder>/logs/sub-<subID>/log_sub<subID>.m`: It is a matlab function which will be used to run the specific session and subject level analysis. It also serves as log file f the analysis, since all the deviation form standard processing should be recorded there.
* `<path_to_new_project_folder>/logs/sub-<subID>/ses-<sesID>/sub-<subID>_ses-<sesID>_log.txt`:It is an empty text file which will store all the standard outputs from the different tools used in the analysis.

### Setup a new session analysis on the same subject

In order for you to setup the analysis of a different session on the same subject, you will simply need to re-run the `startNewSesAnalysis()` funtion using the same subject ID, but assigning a new session ID and changing consistently the other inputs.

This command will add a new chunck of code to the `<path_to_new_project_folder>/logs/sub-<subID>/log_sub<subID>.m` file.

## Setup a subject level analysis

Once you processes all the time points of a subject, you will e able to run the [subject levle analysis](). You can do this via the function `startSubLevelAnalysis()`.

### Input

### Output


You are now ready to run the session/subject level analysis. Check out the [run session level analysis](runSesLevelAn.md) and [run subject level analysis](runSubLevelAn.md) sections for more info.
