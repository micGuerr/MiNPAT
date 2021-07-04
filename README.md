# LongAnMRI

The Longitudinal MRI analysis (LongAnMRI) provides a set of tools for MRI data pre-processing, image phenotype derivation and data analysis, with a specific focus on longitudinal acquisitions.

# Requirements, download and Installation

The Software is compatible with both Linux and macOS based machines. It can be used with Windows operating system, but a few [extra steps]() need to be taken.
If not specified, all the steps indicated here apply to all platforms (with some small adaptations).

You can find the instruction to download and install LongAnMRI [here](doc/installation/longan.md).

## Matlab and Python

Most of LongAnMRI core features are written in Bash and can be run from command line. Nonetheless, **[Matlab](https://it.mathworks.com/products/matlab.html)** scripts and functions are used to organize and simplify the diffent steps of the analysis, hence it is essential to have the software installed.

Also, both a version of Python-2 and Python-3 should be installed, as they are needed in a number of different situations. Check [here] for more info. 

## Download and install extenral softwares

LongAnMRI makes use of a numeber of external softwares. Below you can find the instructions on how to download them and, for some of them, a brief summary on the installation steps.

- **[DTI-TK](doc/installation/dtitk.md)**.
- **[FSL](doc/installation/fsl.md)**.
- **[FreeSurfer](doc/installation/fs.md)**.
- **[NODDI MATLAB toolbox](doc/installation/nodditbx.md)**.
- **[dcm2niix/dcm2bids](doc/installation/dcm2nii.md)**.

NB: It is important to keep track of the locations where the softwares are installed. This information will be used for their configuration, later.

## Setup paths/variables in MATLAB

Motivation
==========

Increased sensitivity to subtle changes in clinical studies has important benefits: it can reveal changes otherwise invisible; it can determine earlier disease detection, which in turns may reduce trial duration (less money needed); it can increase the statistical power, reducing the numerosity of the participant cohorts. 
Longitudinal studies has the potential of increasing the sensitivity, as compared to more standard orthogonal studies, which add unwanted inter-subject cofounding effects.

It is established that an unbiased analysis of longitudinal, needed to boost the achievable sensitivity, is non-trivial, involving specific strategies such as treating all the time-points in the same way.
A number of tools is available which tackle such issue.
However, no pipelines have been presented which integrate such tools.

The aim of LongitudinalMRI is to fil this gap.  

Semi-standardized data organization
===================================

LongitudinalMRI offers a way to organize the numerous files originating from processing and analysis in a semi-standardized fashion. This is useful as it homogenazie the output organization at it makes the output of the analysis more easy to read. To access this utility the [set_longAn](doc/set_longAn.md) function must be run first.

Structure
=========

LongitudinalMRI is divided in three processing streamlines, each for a different type of data.
Each processing streamline is further divided into sub-streams:

* [Structural streamline](structural.md)
* [Diffusion stramline](diffusion.md)
* [Functional stramline](functional.md)

Additional Featuers
===================

LongitudinalMRI is BIDS compatible.
It can uses information from sidecar files to run the tools.
This makes the command easie to run and less prone to errors.

LongitudinalMRI provides quality check files for each step of the processing, which should be used by the user befor advancing ro the next step

Prerequisites
=============

Softwares
---------

FSL (https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation)

DTI-TK (http://dti-tk.sourceforge.net/pmwiki/pmwiki.php)

FreeSurfer (https://surfer.nmr.mgh.harvard.edu/)

ANTs (http://stnava.github.io/ANTs/)

...

Download and installation
=========================

The following commands are meant to be run from a command window.

Download
--------

Download the toolbox as .zip or git clone using
```bash
git clone https://github.com/micGuerr/LongitudinalMRI.git
```

Installation
------------

Unizp the file using e.g.
```bash
unzip LongitudinalMRI.zip
```

Move the toolbox folder into the desired folder, e.g. (note that root priviledges are needed for this)
```bash
sudo mv LongitudinalMRI /usr/local/
```

Open the .bashrc file
```bash
nano ~/.bashrc
```

Add the following line at the end of the file
```bah
export PATH="/usr/local/LongitudinalMRI/bin:${PATH}"
```









