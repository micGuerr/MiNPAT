# DTI-TK Download and Installation

## Download
The DTI-TK binaries for Linux and Mac/OS can be found at [NITRC](https://www.nitrc.org/frs/?group_id=207).
select the release adapted for your needs and start the downloading.
A file named `NITRC-multi-file-downloads.zip` should be saved somewhere on your machine.

## Installation
Assuming the zipped file has been downloaded in the `~/Downloads` folder, we first need to move the compressed file to the preferred location (e.g., `/Users/username/Apps/`).
Type the following commands from terminal :
```bash
mv  ~/Downloads/NITRC-multi-file-downloads.zip ~/Documents/MATLAB/
```

Next, you can unzip file by typing:
```bash
cd /Users/username/Apps/
unzip NITRC-multi-file-downloads.zip
```

Another step is needed to uncompress and extract the package. Type (replace the *XXX* with the actual version you downloaded):
```bash
tar xvfz dtitk-XXX.tar.gz
```

Make sure to keep track of the path to the DTI-TK uncompressed folder (in this example `/Users/username/Apps/dtitk-XXX`), which will be needed for configuration, later.

Further information about DTI-TK can be found [here](http://dti-tk.sourceforge.net/pmwiki/pmwiki.php?n=Main.HomePage).



