# Microstructural NeuroPlasticity Analysis Toolbox (MiNPAT)

This software intends to provide a set of tools and an analysis framework for the detection of microstructural brain changes.

It has been specifically designed for the analysis of neuroplastic changes. To monitor this type of changes multiple acquisitions, at different time points, are conventionally acquired for each subject, hance the toolbox offers specific analysis features for the processing of data where multiple acquisitions are available for each subject.

Nonetheless, the pipeline offers strams of analysis for single session acquisitions as well.

# Download and Installation

The Software is compatible with both Linux and macOS based machines. It can also be used with Windows operating system, but some [extra requirements]() are needed.

You can find the instructions to download and install MiNPAT [here](doc/installation/minpat_install.md).

# Requirements

## Matlab and Python

The analysis framework is based on **[Matlab](https://it.mathworks.com/products/matlab.html)** scripts and functions, hence you must have an installed Matlab version (minumum version ??).

Also, both a Python-2 and Python-3 versions should be installed, as they are needed in a number of different situations. Check [here]() for more info.

## Extenral softwares

MiNPAT makes use of a numeber of external software which must be donwloaded and installed.
The full list is reported below.
Clicking on the links you will find a brief overview on how to donwload and install each of them.

- **[DTI-TK](doc/installation/dtitk.md)**.
- **[DTI-TK addons](doc/installation/dtitk_addons.md)**.
- **[FSL](doc/installation/fsl.md)**.
- **[FreeSurfer](doc/installation/fs.md)**.
- **[NODDI MATLAB toolbox](doc/installation/nodditbx.md)**.
- **[dcm2niix/dcm2bids](doc/installation/dcm2nii.md)**.
- **[opencv-python](doc/installation/opencv-python.md)**.

NB: It is important to keep track of the location on your machine (paths) where the softwares are installed. This information will be used for their configuration (check next steps).


## Getting Started

Tutorials/demos are provided in the folder [`doc/demos/`](doc/demos/) to help you get started with the MiNPAT framework.

