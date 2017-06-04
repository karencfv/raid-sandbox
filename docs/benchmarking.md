## Benchmarking IO Performance

#### Method 1 (hdparm):

- For device read timings run the following command substituting `[PATH]` with the disk path to test
```
$ sudo hdparm -t [PATH]
```

- For cached read timings as follows:
```
$ sudo hdparm -T [PATH]
```
**From hdparm manual:** This operation should be repeated 2-3 times on an otherwise inactive system (no other active processes) with at least a couple of megabytes of free memory.
