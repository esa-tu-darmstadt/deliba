
DeLiBA
===========================================
This repository contains the source code for Development of Linux Block I/O Accelerators (DeLiBA) which is being developed at ESA group. DeLiBA lifts key functionality of Linux block I/O layer up into userspace, enabling the use of a wide spectrum of programming tools. For an initial proof-of-concept DeLiBA in current state uses Ceph based libraries. And to accelerate the Linux block I/O stack computations, it currently uses FPGA-based based hardware accelerators.

> **Note**
Still missing some upstreams. Going to push in next days.

Repository structure
----------------------
The source directory has the following repository structure:

    .
    ├── nbd                    # network block device libraries
    ├── ceph                   # selective Ceph libraries as indicated in DeLiBA publication
    ├── fpga                   # task-based APIs to launch requests from host software on FPGA
 

Profiling and Benchmark Tools
---------------
Following profiling and benchmark tools have been used during our work on this framework:

- [Intel VTune](https://www.intel.com/content/www/us/en/developer/tools/oneapi/vtune-profiler.html#gs.afanri)
- [Valgrind](https://valgrind.org/)
- [fio](https://fio.readthedocs.io/en/latest/fio_doc.html)


Dependencies
-------------
-
-
-
-

Future Roadmap
----------------


Contributions and Issues
-------------------------
Any contributions you make are greatly appreciated. Simply open a pull request, or open an issue.


Publication (Citation)
----------------------
DeLiBA: An Open-Source Hardware/Software Framework for the Development of Linux Block I/O Accelerators – by Babar Khan, Carsten Heinz, and Andreas Koch 
