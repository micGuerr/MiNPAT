# LongAnMRI

The Longitudinal MRI analysis (LongAnMRI) provides a set of tools for MRI data pre-processing, image phenotype derivation and data analysis, with a specific focus on longitudinal acquisitions.

# Requirements, download and Installation

The Software is compatible with both Linux and macOS based machines. It can be used with Windows operating system as well, but a few [extra adjustments]() are needed.

You can find the instructions to download and install LongAnMRI [here](doc/installation/longan.md).

## Matlab and Python

Most of LongAnMRI core features are written in Bash and can be run from command line. Nonetheless, **[Matlab](https://it.mathworks.com/products/matlab.html)** scripts and functions are used to organize and simplify the diffent steps of the analysis, hence the software should be installed.

Also, both a version of Python-2 and Python-3 should be installed, as they are needed in a number of different situations. Check [here]() for more info. 

## Download and install extenral softwares

LongAnMRI makes use of a numeber of external softwares. Below you can find the instructions on how to download them and, for some of them, a brief summary on the installation steps.

- **[DTI-TK](doc/installation/dtitk.md)**.
- **[FSL](doc/installation/fsl.md)**.
- **[FreeSurfer](doc/installation/fs.md)**.
- **[NODDI MATLAB toolbox](doc/installation/nodditbx.md)**.
- **[dcm2niix/dcm2bids](doc/installation/dcm2nii.md)**.

NB: It is important to keep track of the locations where the softwares are installed. This information will be used for their configuration (next step).

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

## Getting Started

Tutorials/demos are provided in the folder [`doc/demos/`]() to help you get started with the LongAnMRI framework.

