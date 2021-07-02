# dcm2niix and Dcm2Bids Download and Installation

We recommend, if possible, to start the processing from DICOM data.
This way, the chances to make silly mistakes is reduced.

Also, the programme assumes a [BIDS](https://bids.neuroimaging.io/)-like structure of the *raw*, unprocessed, NIfTI data (see [Raw data structure]() for more info).
This can be fairly easily obtained if you have your data in DICOM format.
If your data are in NIfTI format, and you don't have access to the DICOM data, you will have to manually rename your files to match the required format.

We use [Dcm2Bids](https://github.com/UNFmontreal/Dcm2Bids) to perform the conversion and BIDS-like organization, which in tunrs is based on [dcm2niix](https://github.com/rordenlab/dcm2niix).

# dcm2niix

### pip and cmake

`cmake` is needed to compile *dcm2niix*.
We will use `pip3` to download cmake, if missing, and later to download *dcm2bids*.

First, let's check whether pip is available, type the following command from terminal:
```bash
pip3 --version
```
If available, something like `pip 21.0.1 from /home/user/.local/lib/python3.6/site-packages/pip (python 3.6)` should be prompted.
If not available, something like `bash: pip3: command not found` will be prompted.

To install pip you can type the following into the command line, line by line:
```bash
cd
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user
```
By typing
```bash
pip3 --version
```
you should now be able to see the pip version.

We can now check whether *cmake* is installed by typing
```bash
cmake --version
```
which should output the programme version (e.g. `cmake version 3.10.2`).
If something like `bash: cmake: command not found` is output, we can install *cmake* typing
```bash
pip3 cmake
```

### Download and compile dcm2niix
The following commands should do the trick.

First, naviaget to a target location where the programme will be installed, e.g. `~/Documents`.
```bash
cd ~/Documents
```

Next, type the following into your command line, line by line:
```bash
git clone https://github.com/rordenlab/dcm2niix.git
cd dcm2niix
mkdir build
cd build
cmake ..
make
```

NB: keep track of the path to the dcm2niix folder (e.g., `/home/user/Documents/dcm2niix`), as it will be needed for configuration, later.

## Dcm2Bids

To install Dcm2Bids you simply need to type
```bash
pip3 install dcm2bids --user
```
The folder where the scripts are installed should be prompted in a waring message. This should look like `/home/username/.local/bin/dcm2bids`.
Again, keep track of it.

