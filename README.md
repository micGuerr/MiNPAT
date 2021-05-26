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

Relevant Features
=================

...

Structure
=========

LongitudinalMRI is divided in three processing streamlines, each for a different type of data:
* **Structural**, for anatomical data (T1w, T2w, ...).
*  **Diffusion**, for diffusuib data.
*   **Functional**, for functional data.

Each processing streamline is further divided into sub-streams.
The **structural** stream is divided into:
* Pre FreeSurfer (preFS)
* FreeSurfer (FS)
* Post FreeSurfer (postFS)

The **diffusion** stream is divided into:
* Pre model fitting (preMF)
* Model fitting (MF)
* Post model fitting (postMF)

The **functional** stream is divided into:
* ...
* ...
* ...



Prerequisites
=============

Software
--------

FSL (https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation)

DTI-TK (http://dti-tk.sourceforge.net/pmwiki/pmwiki.php)

FreeSurfer (https://surfer.nmr.mgh.harvard.edu/)

ANTs (http://stnava.github.io/ANTs/)

...

