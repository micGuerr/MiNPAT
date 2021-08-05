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
where `s12345a`, `s12345b`, `s12345c` are the names of the folders containing the specific session DICOM data.

1. First, you need to create a copy of the template file `<path_to_new_project_folder>/logs/log_subXXX.txt`. **A new copy will be needed every time you want to analyze a new subject**. This file will store all the steps of the session and subject level analysis which will be performed for that specific subject. 
    * You should copy the file in the very same folder (`<path_to_new_project_folder>/log`).
    * You should change the file extension from *.txt* to *.m*.
    * You should modify the file name so to include a **unique ID for that subject**.

Assuming the subject ID is `001`, the command from terminal would be:
```bash
mv <path_to_new_project_folder>/log/log_subXXX.txt <path_to_new_project_folder>/log/log_sub001.m
```

2. Next, from Matlab, open the newly created file (` <path_to_new_project_folder>/log/log_sub001.m` in the example) and modify the following components:
    * Modify the function name (1st line) consistently with the name assigned to the file: e.g. `function log_subXXX()` ==> `function log_sub001()`.
    * Define the subject ID, consistently with the one used to name the file (line 24): e.g. `subid = '001';`.
    * Add the name of the folder (NOT the path to the folder) containing the subject DICOM data (line 30): e.g. `dcm_subid = 'S01';`.
    * Insert the number of cores you would like to use in your analysis...

3. In the same file, duplicate the session level analysis (from line 38 to line 57) as many times as the number of session available for that specific subject. Modify the following components:
    * Assigne each session an ID (line 42): e.g. `sesid = '01';`.
    * Add the name of the folder (NOT the path to the folder) containing the session DICOM data (line 43): e.g. `config.dcm2nii.dcm_sesID = 's12345';`.
    * Add the path to the *.json* configuration file for that specific session (line 44): e.g. `config.dcm2nii.configFile = '/Users/<username>/myBIDSconfigFile.json';`.
    * ...
    * Modify the comment line labeling the new session analysis consistently with the ID you used (line 41): e.g. `%% Session # XX` ==> `%% Session # 01`.

4. [Work in progress... At the end of the file, input the session IDs you used into the `subjectLevelAnalysis()` function so to run the session level analsysis taking into account all teh session .].


You are now ready to run the session/subject level analysis. Check out the [run session level analysis](runSesLevelAn.md) and [run subject level analysis](runSubLevelAn.md) sections for more info.
