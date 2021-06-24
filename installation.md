# Download and Installation

## Download the toolbox
In order to install the software you should either clone this GitHub folder
```bash
git clone https://github.com/micGuerr/LongitudinalMRI.git
```
or Download it as a .zip file.

## Set the paths

### Bash scripts
Next, you should add the path to the LongitudinalMRI folder. This depends on what system you are using.
For bash shell the following command should work
```bash
export PATH="<path_to_folder>/LongitudinalMRI/bin:${PATH}"
```
In order to make this changes permanent you should add the command to a bash file such as ~/.bashrc.

### Matlab scripts
In order to add the path to the matlab scripts you should open matlab and type from command window:
```matlab
addpath(genpath(('<path_to_folder>/LongitudinalMRI/matlab')))
```
To make the changes permanent you should add the folder via ...

## Requirements

The toolbox make use of several different components which should be separately downloaded and installed:
* MRIcron (https://www.nitrc.org/projects/mricron)
* Anaconda (https://www.anaconda.com/products/individual)
* Dcm2Bids (https://github.com/UNFmontreal/Dcm2Bids)
* FSL (https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation)
* DTI-TK (http://dti-tk.sourceforge.net/pmwiki/pmwiki.php)
* FreeSurfer (https://surfer.nmr.mgh.harvard.edu/)

## ...

