# UETRV-PCORE-Linux
**Introduction**
This Makefile is designed to facilitate the process of booting Linux on the UET-RV-PCORE platform. Authored by Wajid Ali, Abdullah Azhar, Uneeb Kamal and Massoma Zia ,an Undergraduate Students specializing in Electrical Engineering at the Department of Electrical Engineering, University of Engineering and Technology Lahore (UET Lahore), this Makefile is crafted as part of the Digital Design Research Lab (DDRC) at UET Lahore.

**System Requirements**
RISC-V toolchain

**Installing the RISC-V GNU Toolchain**
Pre-Requisites
Install the necessary pre-requisite packages by running:

`sudo apt-get install autoconf automake autotools-dev curl python3 python3-pip libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev ninja-build git cmake libglib2.0-dev`

Cloning the Repository
Clone the RISC-V GNU Toolchain repository from GitHub using the following command:

`git clone https://github.com/riscv/riscv-gnu-toolchain.git`

Navigating to the Directory
Change your working directory to the riscv-gnu-toolchain directory:

`cd riscv-gnu-toolchain`

Configuring the Toolchain
Configure the toolchain with the desired installation path (in this example, we use /opt/riscv) using the following command:

`./configure --prefix=/opt/riscv --with-arch=rv32ima`

Building the Toolchain
Build and install the RISC-V GNU Toolchain for Linux with administrative privileges using sudo:

`sudo make linux`

Optionally, use multiple cores for faster compilation (replace <n> with the number of cores):

`sudo make -j<n> linux`

Add the following line to ~/.bashrc to add the toolchain to your PATH:

`export PATH="/opt/riscv/bin:$PATH"`

After updating ~/.bashrc, either restart your terminal or run:

`source ~/.bashrc`

Now, your RISC-V GNU Toolchain is installed and ready for use on your system.

**Usage**
Clone the repository:

`git clone https://github.com/wajidali4907/UET-RV-PCORE-Linux.git`

Navigate to the project directory:

`cd UET-RV-PCORE-Linux`

Run the Makefile:

`make -f Makefile.mk`

Configuring BusyBox Network Utilities
During the BusyBox configuration, open the configuration panel for BusyBox.
Navigate to Networking Utilities and open the configuration.
Set the hostname as desired.

Follow on-screen instructions during the kernel build process. If prompted, press "n" (no), followed by "1" (one), then press "n" (no) again, and finally, press Enter to proceed with the default options.








