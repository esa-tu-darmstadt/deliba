
# DeLiBA

This repository contains the source code for the **De**velopment of **Li**nux **B**lock I/O **A**ccelerators (DeLiBA) framework, which is being developed by the Embedded Systems and Applications (ESA) Group within the Computer Science department at the Technical University of Darmstadt, Germany.

## Rationale behind DeLiBA (background)
At its core, DeLiBA is a block storage (block I/O) framework. The goal has been to accelerate block I/O on specialized hardware accelerators like FPGA (Field Programmable Gate Array). Both new and relatively new FPGA frameworks designed to accelerate I/O in systems require a critical reassessment of decades-old system calls that were prevalent in earlier FPGA frameworks. Despite the significant accceleration achieved by various FPGA frameworks, we contend that existing system calls do not always perform their intended functions effectively.


## Architecture Overview

![deliba](https://github.com/user-attachments/assets/601a0f15-2b9d-49e6-af84-67ad395bc033)

## Repository structure

The source directory has the following repository structure:

    .
    ├── deliba1                    # Source code corresponding to the first publication (2022)
    ├── deliba2                   # Source code corresponding to the second publication (2023)
    ├── deliba3                   # Source code corresponding to the third publication (2024)

To date, three research publications have been produced as part of the DeLiBA project. For convenience, the DeLiBA source code repository includes separate directories for each publication.    
 
## Supported FPGA devices
DeLiBA is primarily PCIe based framework. To this end DeLiBA supporrts PCIe cards namely VC709, NetFPGA-SUME, and Alveo U280



## Profiling and Benchmark Tools
Following profiling and benchmark tools have been used during our work on this framework:

- [Intel VTune](https://www.intel.com/content/www/us/en/developer/tools/oneapi/vtune-profiler.html#gs.afanri)
- [Valgrind](https://valgrind.org/)
- [fio](https://fio.readthedocs.io/en/latest/fio_doc.html)




# Publication (Citation)

- B. Khan, C. Heinz and A. Koch, "DeLiBA: An Open-Source Hardware/Software Framework for the Development of Linux Block I/O Accelerators," 2022 32nd International Conference on Field-Programmable Logic and Applications (FPL), Belfast, United Kingdom, 2022, pp. 183-191, https://doi.org/10.1109/FPL57034.2022.00038
 
- Babar Khan, Carsten Heinz, and Andreas Koch. 2024. The Open-source DeLiBA2 Hardware/Software Framework for Distributed Storage Accelerators. ACM Trans. Reconfigurable Technol. Syst. 17, 2, Article 23 (June 2024), 32 pages. https://doi.org/10.1145/3624482
  
- B. Khan and A. Koch, "DeLiBA-K: Speeding-up Hardware-Accelerated Distributed Storage Access by Tighter Linux Kernel Integration and Use of a Modern API," SC24-W: Workshops of the International Conference for High Performance Computing, Networking, Storage and Analysis, Atlanta, GA, USA, 2024, pp. 531-544, https://doi.org/10.1109/SCW63240.2024.00075.


# DeLiBA talks

- [Tenth International Workshop on Heterogeneous High-performance Reconfigurable Computing](https://h2rc.cse.sc.edu/2024/slides/05_khan.pdf)
- [SC 2023](https://babarzkhan.github.io/https:/sc23.supercomputing.org/)
- [FPL 2022](https://www.esa.informatik.tu-darmstadt.de/assets/publications/materials/2022/2022_FPL_BK_slides.pdf)


# Acknowledgements
DeLiBA work has been co-funded by the German Federal Ministry for Education and Research (BMBF) with the funding ID 01 IS 19018 B under the project Software Defined and Distributed Accelerated Storage (SODDAS). We would also like to thanks Amazon Research for research credits. We would also like to thank our industry partner, a global leader in DBMSs and cloud operations.


Contributions and Issues
-------------------------
Any contributions you make are greatly appreciated. Simply open a pull request, or open an issue.
