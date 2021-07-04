# LongAnMRI Download and installation

## Download

### Check git is installed
The best way to download the software is from terminal via the `git` command.

Check whether you have `git` installed, by running the following command from [terminal](https://towardsdatascience.com/a-quick-guide-to-using-command-line-terminal-96815b97b955):
```bash
git --version
```
If the programme is installed, something like `git version 2.25.1` should be prompted.
If you get an error instead, you will need to install git by following [this](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) simple guide.

You will also need to sign up to [GitHub](https://github.com/) before proceeding to the next step.

### Clone LongAnMRI
Navigate to the folder where you would like to save LongAnMRI via the `cd` command.
```bash
cd <path_to_folder>
```
An appropriate folder choice could be `/usr/local` but you will need [superuser privileges](https://en.wikipedia.org/wiki/Superuser) to download the LongAnMRI.
Alternatively, you can use other locations such as `/Users/username/Apps`.

Once you changed directory you can run:
```bash
sudo git clone https://github.com/micGuerr/LongitudinalMRI.git
```
If you don't have superuser privileges simply run:
```bash
git clone https://github.com/micGuerr/LongitudinalMRI.git
```
After entering your GitHub username and password the download should start.

NB: Make sure to keep track of the path to the LongAnMRI folder, as it will be needed for configuration, later.

### Other downloading options
Alternatively, you can download the .zip file from the main [LongAnMRI](https://github.com/micGuerr/LongitudinalMRI) page, by pressing on the *code* button and then on *Download ZIP*.

Assuming the file has been downloaded in the `/Users/username/Downloads/` folder, move the file into a target location, e.g.:
```bash
mv /Users/username/Downloads/LongitudinalMRI /Users/username/Apps/
```

Next, navigate to the target directory, e.g.:
```bash
cd /Users/username/Apps/
```
Unzip the compressed file (you will need to have the `zip` command installed):
```bash
unzip LongitudinalMRI.zip
```

### Setup paths
In case *you don't plan* to youse the Matlab scritps, you can add LongAnMRI to the searching paths by typing the following command from command line:
```bash
export PATH="<path_to_folder>/LongitudinalMRI/bin:${PATH}"
```
In order to make this change permanent you should add this line to the appropriate file (based on your operating system).







