# set_longAn


## Purpose
To create a semi-standard folder structure in which to store all the files originating from processing and analysing input MRI data.

## Problem
The result of data processing and analysis in MRI studies can be complex, with a lot of different.
There is no consensus about the output file organization.
This can lead to misunderstanding, errors and time wasted rearranging the data.
set_longAn sets a standardized backbone folder strucutre which is capitalized by the other LongitudinaMRI tools to create a semi-standard output file organization.

```bash
dataProcessing/
└── anat
 │  └── preFS
 │  │   └── sub-01
 │  │   │   ├── ses-01
 │  │   │   ├── ses-02
 │  │   │   └── ...
 │  │   └── ...
 │  ├── FS
 │  │   └── ...
 │  │
 │  ├── postFS
 │      └── ...
 ├── dwi
 │   └── preMF
 │   ├── MF
 │   └── postMF
 └── func
     └── ...
```

## Usage

### Input

There are two compulsory imputs:
* The path to the working folder, the folder where the structure of folders will be created. The working folder does't need to exist. 
* The path to the subject text file, where the IDs of the subjects to be analyzed is listed.

The inputs are specified by the flags **--wrkdir** and **--subjid**, e.g.:
```bash
set_longAn --wrkdir=~/DataProcessing --subjid=~/subjectList.txt
```

### Output

The programme will **create** a folder named *DataProcessing*.
It will create three sub-folders named 

```bash
DataProcessing/anat
DataProcessing/dwi
DataProcessing/func
```
one for each analysis stream.
Within each stream subfolder, the sub-stram folders will be created:
```bash
DataProcessing/anat/preFs
DataProcessing/anat/FS
DataProcessing/anat/postFS
DataProcessing/dwi/preMF
DataProcessing/dwi/MF
DataProcessing/dwi/postMF
DataProcessing/func/...
...
```

Finally, within each sub-folder, a folder for each subject ID, specified by the subject list, will be created.

If the subjectList.txt file is:
```text
subj-01
subj-02
...
```

the following folders will be created
```bash
DataProcessing/anat/preFs/subj-01
DataProcessing/anat/preFs/subj-02
...
DataProcessing/func/.../subj-XX
```

### Optional argument

* a set of sessions (corresponding for example to acquisitions in different timepoints) can be also input, by specifing the path to a sesseion text file, constructed similarly to the subject text file.

  This is done via the optional flag **--sessid**.
  ```bash
  set_longAn --wrkdir=~/DataProcessing --subjid=~/sessionList.txt
  ```

  The sessionList.txt file being something like:
  ```text
  ses-01
  ses-02
  ...
  ```
  the following folders will be created
  ```bash
  DataProcessing/anat/preFS/subj-01/ses-01
  DataProcessing/anat/preFS/subj-01/ses-02
  ...
  DataProcessing/func/.../subj-XX/ses-YY
  ```
  
* Specific streams can be selsectively initiated usign the glags **--anat**, **--dwi**, **--func**.
  
  For example, running the command
  ```bash
  set_longAn --wrkdir=~/DataProcessing --anat --func
  ```
  Only the structural and functional streams will be initializated.
