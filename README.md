
# DeLiBA (Development of Linux Block I/O Accelerators)

This repository contains the source code for the **De**velopment of **Li**nux **B**lock I/O **A**ccelerators (DeLiBA) framework, which is being developed by the Embedded Systems and Applications (ESA) Group within the Computer Science department at the Technical University of Darmstadt, Germany.

## Rationale behind DeLiBA (background) framework
At its core, DeLiBA is a software-hardware co-design block storage (disk block I/O) acceleration framework. It is developed to accelerate block I/O performance using specialized hardware accelerators, particularly FPGAs (Field-Programmable Gate Arrays) deployed as SmartNICs in data centers. As emerging FPGA frameworks aim to accelerate I/O operations (particularly AI workload), there is a growing need to critically reassess traditional system calls in Linux that were originally designed for earlier generations of hardware. Despite the substantial performance gains achieved by modern FPGA-based frameworks, we show that legacy system calls often fail to meet the performance and efficiency demands of today’s high-speed, hardware-accelerated storage environments.

The below composite image illustrates the current state of the Linux block I/O stack, the evolution of HDD technologies over time, and highlights the emergence of cutting-edge HAMR drivess. It also captures the interplay between I/O stacks, storage devices, and AI training workloads in 2024.

![deliba-background](https://github.com/user-attachments/assets/5f3493aa-4567-4cca-b61b-4bf8a7460d06)

## DeLiBA Architecture Overview

Th figure shows the main architecture of DeLiBA framework and it explicitly illustrates the lifecycle of an I/O request in six stages, each corresponding to one of the six major
optimizations of the DeLiBA framework.
![deliba](https://github.com/user-attachments/assets/601a0f15-2b9d-49e6-af84-67ad395bc033)

## Repository structure

The source directory has the following repository structure:

    ├── deliba1                    # Source code corresponding to the first publication (2022)
    ├── deliba2                   # Source code corresponding to the second publication (2023)
    ├── deliba3                   # Source code corresponding to the third publication (2024)

To date, three research publications have been produced as part of the DeLiBA project. For convenience, the DeLiBA source code repository includes separate directories for each publication. Previous versions of the open-source DeLiBA framework, namely DeLiBA-1 (D1) and DeLiBA-2 (D2), demonstrated significant gains in accelerating Linux block I/O operations. 
However, these prior versions still had bottlenecks, specifically in how user programs interacted with the storage stack using decades-old traditional Linux APIs and in their
internal implementation, which incurred many user/kernel context switches. We have carefully considered these performance bottlenecks in our new deliba3 (DeLiBA-K) framework. 
## Supported FPGA devices
DeLiBA is primarily a PCIe-based framework. To this end, it supports PCIe cards such as the VC709, NetFPGA-SUME, and Alveo U280, with the AMD (earlier) Alveo U280 serving as the primary card for all end-to-end implementations. AMD Alveo U280 card, built on 16nm UltraScale architecture, features an FPGA chip with 1.3 million LUTs, 2.72 million registers, 9,024 DSP slices, 2,016 Block RAMs (BRAMs), and 960 UltraRAMs (URAMs), offering 4.5 MB of on-chip BRAM and 30 MB of on-chip URAM. 

## FPGA libraries
- [Vitis 100Gbps TCP/IP:](https://github.com/fpgasystems/Vitis_with_100Gbps_TCP-IP)
- [AMD (earlier Xilinx Partial Reconfiguration technology namely Dynamic Function Exchange (DFX))](https://www.amd.com/en/products/adaptive-socs-and-fpgas/technologies/dynamic-function-exchange.html)
- [AMD (earlier Xilinx open-nic)](https://github.com/Xilinx/open-nic/tree/main)

## Host side libraries, Profiling tools, and Benchmarking tools
- [Ceph:](https://github.com/ceph/ceph)
DeLiBA leverages Ceph as a representative use-case to demonstrate its capability in accelerating distributed storage systems. Specifically, DeLiBA offloads Ceph’s CRUSH data placement algorithms to FPGA hardware, enabling faster object placement and reduced CPU overhead. This integration highlights DeLiBA’s potential to enhance performance in real-world, large-scale storage environments.
- [erasure-coding:]() We benchmark both erasure coding (EC) and replication operations, the two methods used in Ceph for data durability and high availability. 
- [io-uring:](https://github.com/torvalds/linux/tree/master/io_uring) The application end of the DeLiBA-K framework implements the io_uring I/O library, a new asynchronous I/O (AIO) interface introduced in the mainline Linux kernel version 5.1. This modern API allows considerably finer control of I/O than the traditional I/O APIs.

Following profiling and benchmark tools have been used during our work on this framework:

- [Intel VTune](https://www.intel.com/content/www/us/en/developer/tools/oneapi/vtune-profiler.html#gs.afanri)
- [Valgrind](https://valgrind.org/)
- [fio](https://fio.readthedocs.io/en/latest/fio_doc.html)




# Publication (Citation)

- B. Khan, C. Heinz and A. Koch, "DeLiBA: An Open-Source Hardware/Software Framework for the Development of Linux Block I/O Accelerators," 2022 32nd International Conference on Field-Programmable Logic and Applications (FPL), Belfast, United Kingdom, 2022, pp. 183-191, https://doi.org/10.1109/FPL57034.2022.00038 (BEST PAPER AWARD)
 
- Babar Khan, Carsten Heinz, and Andreas Koch. 2024. The Open-source DeLiBA2 Hardware/Software Framework for Distributed Storage Accelerators. ACM Trans. Reconfigurable Technol. Syst. 17, 2, Article 23 (June 2024), 32 pages. https://doi.org/10.1145/3624482
  
- B. Khan and A. Koch, "DeLiBA-K: Speeding-up Hardware-Accelerated Distributed Storage Access by Tighter Linux Kernel Integration and Use of a Modern API," SC24-W: Workshops of the International Conference for High Performance Computing, Networking, Storage and Analysis, Atlanta, GA, USA, 2024, pp. 531-544, https://doi.org/10.1109/SCW63240.2024.00075.

- Babar Khan and Andreas Koch. 2025. Reflecting on the Past 17 Years of Shingled Magnetic Recording for Insights into Future Disk Transitions: A Survey. ACM Trans. Storage Just Accepted (April 2025). https://doi.org/10.1145/3731453
 
# Slides
- [slide deck 1](https://www.esa.informatik.tu-darmstadt.de/assets/publications/materials/2022/2022_FPL_BK_slides.pdf)
- [slide deck 2](https://h2rc.cse.sc.edu/2024/slides/05_khan.pdf)

# DeLiBA talks and Media Coverage 

- [Super Computing (SC) Conference 2024](https://h2rc.cse.sc.edu/2024/slides/05_khan.pdf)
- [Super Computing (SC) Conference 2023](https://babarzkhan.github.io/https:/sc23.supercomputing.org/)
- [FPL 2022](https://www.esa.informatik.tu-darmstadt.de/assets/publications/materials/2022/2022_FPL_BK_slides.pdf)
- [Our SMR publication in renowened Storage online publication](https://www.storagenewsletter.com/2025/04/30/reflecting-on-past-17-years-of-shingled-magnetic-recording-for-insights-into-future-disk-transitions-survey/)



# Acknowledgements
The DeLiBA project has been co-funded by the German Federal Ministry of Education and Research (BMBF) under the Software Defined and Distributed Accelerated Storage (SODDAS) initiative. We gratefully acknowledge Amazon Research for providing research credits. We also extend our sincere thanks to our industry partner, a global leader in database management systems and cloud operations. Additionally, we would like to thank USENIX, Red Hat, Do IT Now, and the Linux Foundation (Dan Kohn Scholarship) for awarding travel grants to the main contributor of DeLiBA framework, Babar Khan.


Contributions and Issues
-------------------------
Any contributions you make are greatly appreciated. Simply open a pull request, or open an issue.
