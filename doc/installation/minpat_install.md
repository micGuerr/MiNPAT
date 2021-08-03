# MiNPAT Download and installation

## Download

There are a few different ways to Download a GitHub project, below we list some of them.

NB: Independently from the option you pick out, make sure to keep track of the path to the MiNPAT folder, as it will be needed for configuration, later.

### Download via terminal

The standard way to download the software is via a [terminal](https://towardsdatascience.com/a-quick-guide-to-using-command-line-terminal-96815b97b955), using the `git` command.
To do so, make sure you have `git` installed by typing on a teminal window the following command:
```bash
git --version
```
Something like `git version 2.17.1` should be prompted.
In case you get an error instead, you can install git following [this](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) simple guide.

Next, navigate to the folder where you would like to save MiNPAT via the `cd` command. Run the following command from terminal, substituting the <path_to_folder> with the path of your target folder:
```bash
cd <path_to_folder>
```
An appropriate folder choice is be `/usr/local` but you will need [superuser privileges](https://en.wikipedia.org/wiki/Superuser).
Alternatively, you can use other locations such as `/Users/<username>/myApps`.

Once you changed directory you can run the following command:
```bash
git clone https://github.com/micGuerr/MiNPAT.git
```
If you need/have superuser privileges run:
```bash
sudo git clone https://github.com/micGuerr/MiNPAT.git
```

### Download via MATLAB

Matlab provides a simple GUI to download a Git respository. The documentation of this functionality is available [here](https://it.mathworks.com/help/simulink/ug/clone-git-repository.html). You can find the process illustrated by the following set of screenshots: [step1](figs/matlabGitRetrieval1.png), [step2](figs/matlabGitRetrieval2.png), [step3](figs/matlabGitRetrieval3.png).

### Other downloading options
Alternatively, you can download the .zip file from the main [MiNPAT](https://github.com/micGuerr/MiNPAT) page, by pressing on the *code* button and then on *Download ZIP*.

Assuming the file has been downloaded in the `/Users/<username>/Downloads/` folder, move the file into a target location, e.g.:
```bash
mv /Users/<username>/Downloads/MiNPAT /Users/<username>/myApps/
```

Next, navigate to the target directory, e.g.:
```bash
cd /Users/<username>/myApps/
```
Unzip the compressed file (you will need to have the `zip` command installed):
```bash
unzip MiNPAT.zip
```
## Installation

### MATLAB paths setup

Add the `MiNPAT/matlab` folder to your MATLAB PATH. 

Check [here](https://it.mathworks.com/help/matlab/matlab_env/add-remove-or-reorder-folders-on-the-search-path.html) if you don't know how to do it.
Check [here](https://it.mathworks.com/help/matlab/matlab_env/what-is-the-matlab-search-path.html) if you don't know what the MATLAB PATH is.

### Bahs paths setup (optional)

In order for you to use the bash scripts, which are available in MiNPAT, from the terminal, you should add the `MiNPAT/bin` folder to the terminal searching paths.
You can do so by typing the following command from command line:
```bash
export PATH="<path_to_folder>/LongitudinalMRI/bin:${PATH}"
```
In order to make this change permanent you should add this line to the appropriate configuration file (this depends on your operating system).







