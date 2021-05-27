LongitudinalMRI
===============
Michele Guerreri

May 2021

Purpose
=======

LongitudinalMRI provides a set of tools for MRI data processing and analysis, with a specific focus on longitudinal acquisitions.

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









