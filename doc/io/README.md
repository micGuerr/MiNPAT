# Inputs and Outputs

## Input

MiNPAT is designed to  provide a set of tools and an analysis framework for the detection of microstructural brain changes.
MiNPAT main input is thus a set of **diffusion MRI (dMRI) data**. MiNPAT also integrate **structural MRI** data in the processing which can help improve the analysis.
Functional MRI (fMRI) data stream of analysis is currently not implemented.

MiNPAT has been specifically designed for the analysis of neuroplastic changes. To monitor this type of changes multiple acquisitions, at different time points (so called **longitudinal acquisitions**), must be acquired for each subject, hance the toolbox offers specific analysis features for the processing of data where multiple acquisitions are available for each subject.
However, the pipeline offers strams of analysis for **single session acquisitions** as well.

MiNPAT offers a framework for the data analysis. For this reason it requires a minimal standardization of the input data. Specifically, it expects the unprocessed (raw) data to follow the [Brain Imaging Data Structure (BIDS)](https://bids.neuroimaging.io/) structure. This organization can be automatically achieved by the toolbox if the input data are in **DICOM format**. If your data have already been converted to **NIfTI format**, and you don't have access to its DICOM version, you can still use the software, but you will need to manually organize your raw data. Check out [here]() for more info.

## Output

MiNPAT computes imaging features form the diffusion data (such as DTI and NODDI) as well as finding correspondence between time points and subjects. Different types of correspondence can be obtained via MiNPAT:

* White matter (WM) spatial correspondece, optimaized for WM tracts analysis.
* Cortical surface spatial correspondece, optimaized for cortical gray matter (GM) analysis.
* Region of interest (ROI) correspondece, optimaized for sub-cortical GM analysis.

## Workflow

The pipeline can be diveded in three **levels (or units) of analysis**:

1. The first level is the [**session level analysis**](sesLevelAn.md). In this unit we separately process the data from each time point (or *session*) of each subject. This step is ment to pre-process the data and to compute all the imaging features available from that specific acquisition session. For example, DTI and NODDI maps from diffusion data or cortical surfaces and sub-cortical segmentation from a T1w image.

2. The second level is the [**subject level analysis**](subLevelAn.md). For each subject, this unit integrates the outputs from the session level analysis steps of all subject's time points. Among other things, this step defines a correspondence between time points of a same subject, as the subject head is lickely to change pose between one session and another. This step is not needed if the input data have a single session only.

3. The third level is the [**population level analysis**](popLevelAn.md). This unit integrates the information from all the sessions and all the subjects. It is ment to bring all derived imagin features in a common space mackin possible a comparison.

