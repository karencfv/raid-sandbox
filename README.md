## Software RAID Sandbox / Experimental LAMP Multiple Machine VM 

The purpose of this Vagrant environment is to explore/play around with a multi-machine set up. 

It includes 2 Apache web servers and 5 MySQL databases set up in different RAID level arrays.

### RAID levels

The diferent RAID level arrays used are:

#### RAID 0
Data is broken down into blocks and each block is written to a separate disk drive (striped disk array). 
A minimum of 2 disk drives are needed to implement.

#### RAID 1
Data is mirrored across disk drives, 100% redundancy of data.
A minimum of 2 disk drives are needed to implement.

#### RAID 5
Data is striped as in RAID 0, but with the slight difference that an extra data block containing parity information will be written on each disk drive as well.
A minimum of 3 disk drives are needed to implement.

#### RAID 6
Basically same as RAID 5 but each disk drive will have 2 blocks with parity information instead of 1.
Requires n+2 (where n is the number of data disks) disk drives to implement.

#### RAID 10
Combination of RAID 0 and RAID 1, data is both mirrored and striped.
A minimum of 4 disk drives are needed to implement.

Benchmarking information and results can be found [here](https://github.com/karencfv/raid-sandbox/blob/master/docs/benchmarking.md)

_**Note:** As it's a sandbox it's pretty barebones, feel free to play around_
