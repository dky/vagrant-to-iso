#Vagrant Kickstart iso template

Use this to build custom kickstart iso's when we need to do hands off installs. 

##Usage

- Copy isolinux_template.cfg to isolinux.cfg and update with your custom parameters and kickstart server.

- cdbuild.sh script is small script to: 
	- Mount iso 
	- Copy contents to a build directory 
	- Copy isolinux.cfg   and 
	- Create a new iso file and drop into /vagrant
