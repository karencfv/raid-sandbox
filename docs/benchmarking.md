## Benchmarking IO Performance

### Method 1 (hdparm):

- For device read timings run the following command substituting `[PATH]` with the disk path to test
```
$ sudo hdparm -t [PATH]
```

- For cached read timings as follows:
```
$ sudo hdparm -T [PATH]
```
**From hdparm manual:** This operation should be repeated 2-3 times on an otherwise inactive system (no other active processes) with at least a couple of megabytes of free memory.

_This method didn't really give useful data, not much difference between RAID levels_

### Method 2 (dd):

For write time `dd` can be used to create a large file as quickly as possible.

If drive doesn't have a filesystem use the following command:
```
sudo time sh -c "dd if=/dev/zero of=[PATH] bs=[BLOCK_SIZE]k count=[LOOPS] && sync"
```

Testing was done with the following parameters to write a file that is 400MB:
```
[PATH] = /dev/md0
[BLOCK_SIZE] = 4k
[LOOPS] = 100000
```
_**sync** forces the process to write the entire file to disk before completing. Time command output will include the sync to disk time._

Write times between RAID0 and RAID6:

- RAID0
```
vagrant@db-raid0:~$ sudo time sh -c "dd if=/dev/zero of=/dev/md0 bs=4k count=100000 && sync"
100000+0 records in
100000+0 records out
409600000 bytes (410 MB) copied, 0.842593 s, 486 MB/s
0.02user 0.39system 0:00.98elapsed 42%CPU (0avgtext+0avgdata 1960maxresident)k
128inputs+800000outputs (3major+248minor)pagefaults 0swaps
vagrant@db-raid0:~$ sudo time sh -c "dd if=/dev/zero of=/dev/md0 bs=4k count=100000 && sync"
100000+0 records in
100000+0 records out
409600000 bytes (410 MB) copied, 1.00361 s, 408 MB/s
0.02user 0.57system 0:01.08elapsed 55%CPU (0avgtext+0avgdata 1792maxresident)k
1000inputs+800000outputs (9major+235minor)pagefaults 0swaps
vagrant@db-raid0:~$ sudo time sh -c "dd if=/dev/zero of=/dev/md0 bs=4k count=100000 && sync"
100000+0 records in
100000+0 records out
409600000 bytes (410 MB) copied, 0.867683 s, 472 MB/s
0.02user 0.59system 0:00.99elapsed 62%CPU (0avgtext+0avgdata 1956maxresident)k
96inputs+800000outputs (3major+239minor)pagefaults 0swaps
```

- RAID6
```
vagrant@db-raid6:~$ sudo time sh -c "dd if=/dev/zero of=/dev/md0 bs=4k count=100000 && sync"
100000+0 records in
100000+0 records out
409600000 bytes (410 MB) copied, 1.86484 s, 220 MB/s
0.01user 0.22system 0:02.30elapsed 10%CPU (0avgtext+0avgdata 1788maxresident)k
48inputs+800000outputs (2major+240minor)pagefaults 0swaps
vagrant@db-raid6:~$ sudo time sh -c "dd if=/dev/zero of=/dev/md0 bs=4k count=100000 && sync"
100000+0 records in
100000+0 records out
409600000 bytes (410 MB) copied, 2.0986 s, 195 MB/s
0.02user 0.28system 0:02.43elapsed 12%CPU (0avgtext+0avgdata 1588maxresident)k
1400inputs+800000outputs (11major+239minor)pagefaults 0swaps
vagrant@db-raid6:~$ sudo time sh -c "dd if=/dev/zero of=/dev/md0 bs=4k count=100000 && sync"
100000+0 records in
100000+0 records out
409600000 bytes (410 MB) copied, 2.23976 s, 183 MB/s
0.02user 0.22system 0:02.64elapsed 9%CPU (0avgtext+0avgdata 1984maxresident)k
32inputs+800000outputs (2major+249minor)pagefaults 0swaps
```

`dd` is destructive and should really not be used much, as I found out. According to virtualbox I now have 64Z of storage capacity which I have used up already. ¬_¬ 
```
vagrant@db-raid0:~$ df -h -x devtmpfs -x tmpfs
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1       9.2G  1.3G  7.5G  15% /
/dev/md0         64Z   64Z  973M 100% /mnt/md0
```
