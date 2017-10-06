# Vagrant Kickstart iso template

Use this to build custom kickstart iso when we need to do hands off installs. 

## Usage

- Copy isolinux_template.cfg to isolinux.cfg and update with your custom parameters and kickstart server.

### cdbuild.sh script is small script to: 
	- Mount iso 
	- Copy contents to a build directory 
	- Copy custom isolinux.cfg to new iso build directory
	- Create a new iso file and drop into /vagrant
	- Run this if you just want a one-off custom CD
	- staticip.sh script is used to:
		- Create iso files with static IP addresses for specific sites
		- Used to label iso files for more than one CD creation
