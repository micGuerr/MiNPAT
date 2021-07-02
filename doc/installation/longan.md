# LongAnMRI Download

The following instructions are compatible with Linux based and macOS systems.
If you use Windows, you can run the same commands from any Linux-based app available for Windows, such as the [Ubuntu app](https://www.microsoft.com/en-gb/search?q=ubuntu).

## Check git is installed
The best way to download the software is from terminal via the `git` command.

Check whether you have `git` installed, by running the following command from [terminal](https://towardsdatascience.com/a-quick-guide-to-using-command-line-terminal-96815b97b955):
```bash
git --version
```
If the programme is installed, something like `git version 2.25.1` should be prompted.
If you get an error instead, you will need to install git by following [this](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) simple guide.

You will also need to sign up to [GitHub](https://github.com/) before proceeding to the next step.

## Clone LongAnMRI
Navigate to the folder where you would like to save LongAnMRI via the `cd` command.
```bash
cd <path_to_folder>
```
An appropriate folder choice could be `/usr/local` but you will need [superuser privileges](https://en.wikipedia.org/wiki/Superuser) to download the LongAnMRI.
Alternatively, you can use other locations such as `~/Documents`.

Once you changed directory you can run:
```bash
sudo git clone https://github.com/micGuerr/LongitudinalMRI.git
```
If you don't have superuser privileges simply run:
```bash
git clone https://github.com/micGuerr/LongitudinalMRI.git
```
After entering your GitHub username and password the download should start.

NB: keep track of the folder where you cloned LongAnMRI, as it will be need for configuration, later.

## Other downloading options
Alternatively, you can download the .zip file from the main [LongAnMRI](https://github.com/micGuerr/LongitudinalMRI) page, by pressing on the *code* button and then on *Download ZIP*.

Next, navigate to the `Downloads` folder:
```bash
cd ~/Downloads
```
Unzip the file (you will need to have the `zip` command installed):
```bash
unzip LongitudinalMRI.zip
```

Move the unzipped folder to a target location, e.g.:
```bash
mv LongitudinalMRI ~/Documents/
```

