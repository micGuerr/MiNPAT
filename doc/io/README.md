# Inputs and Outputs

## Inputs

MiNPAT is designed to  provide a set of tools and an analysis framework for the detection of microstructural brain changes.
MiNPAT main input is thus a set of diffusion MRI (dMRI) data. MiNPAT also integrate structural MRI data in the processing which can help improve the analysis.
Functional MRI (fMRI) data stream of analysis is currently not implemented.

MiNPAT has been specifically designed for the analysis of neuroplastic changes. To monitor this type of changes multiple acquisitions, at different time points (so called longitudinal acquisitions), must be acquired for each subject, hance the toolbox offers specific analysis features for the processing of data where multiple acquisitions are available for each subject.
However, the pipeline offers strams of analysis for single session acquisitions as well.

MiNPAT offers a framework for the data analysis. For this reason it requires a minimal standardization of the input data. Specifically, it expects the unprocessed (raw) data to follow the [Brain Imaging Data Structure (BIDS)](https://bids.neuroimaging.io/) structure. This organization can be automatically achieved by the toolbox if the input data are in DICOM format. If your data have already been converted to NIfTI format, and you don't have access to its DICOM version, you can still use the software, but you will need to manually organize your raw data. Check out [here]() for more info.

## Workflow

The pipeline can be diveded in three *levels (or units) of analysis*:

1. The first level is the [**session level analysis**](). In this unit we separately process the data from each time point (or *session*) of each subject. This step is ment to pre-process the data and to compute all the imaging features needed for that specific acquisition session. For example, DTI and NODDI maps from diffusion data or surface definition and cortical and sub-cortical segmentation from a T1w image.

2. The second level is the [**subject level analysis**]().


## Output
