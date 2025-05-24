
DeLiBA
===========================================
This repository contains the source code for Development of Linux Block I/O Accelerators (DeLiBA) which is being developed at ESA group. DeLiBA lifts key functionality of Linux block I/O layer up into userspace, enabling the use of a wide spectrum of programming tools. For an initial proof-of-concept DeLiBA in current state uses Ceph based libraries. And to accelerate the Linux block I/O stack computations, it currently uses FPGA-based based hardware accelerators.

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



Contributions and Issues
-------------------------
Any contributions you make are greatly appreciated. Simply open a pull request, or open an issue.


Publication (Citation)
----------------------
- B. Khan, C. Heinz and A. Koch, "DeLiBA: An Open-Source Hardware/Software Framework for the Development of Linux Block I/O Accelerators," 2022 32nd International Conference on Field-Programmable Logic and Applications (FPL), Belfast, United Kingdom, 2022, pp. 183-191, https://doi.org/10.1109/FPL57034.2022.00038
 
- Babar Khan, Carsten Heinz, and Andreas Koch. 2024. The Open-source DeLiBA2 Hardware/Software Framework for Distributed Storage Accelerators. ACM Trans. Reconfigurable Technol. Syst. 17, 2, Article 23 (June 2024), 32 pages. https://doi.org/10.1145/3624482
  
- B. Khan and A. Koch, "DeLiBA-K: Speeding-up Hardware-Accelerated Distributed Storage Access by Tighter Linux Kernel Integration and Use of a Modern API," SC24-W: Workshops of the International Conference for High Performance Computing, Networking, Storage and Analysis, Atlanta, GA, USA, 2024, pp. 531-544, https://doi.org/10.1109/SCW63240.2024.00075.

