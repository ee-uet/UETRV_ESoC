# Makefile for BOOTing Linux on UETRV_PCORE


# This makefile is authored by Wajid Ali, an Undergraduate Student specializing in Electrical Engineering
# at the Department of Electrical Engineering, University of Engineering and Technology Lahore (UET Lahore).
# The makefile is crafted as part of the Digital Design Research Lab (DDRC) at UET Lahore and serves the
# purpose of generating imm.bin and imm.txt files, facilitating the seamless booting of the Linux operating
# system on the UET-RV-PCORE platform. The UET-RV-PCORE is a cutting-edge platform for research and
# experimentation in the field of digital design and embedded systems.
# 
# For inquiries, please contact:
# Wajid Ali
# Email: 2021ee79@student.uet.edu.pk
# 
# Note: During the kernel build process, you may encounter prompts. Press "n" (no), followed by "1" (one),
# then press "n" (no) again, and finally, press Enter to proceed with the default options.
# 
# Copyright (c) Digital Design Research Lab (DDRC UET),
# University of Engineering and Technology Lahore. All rights reserved.


# Variables
BUILDROOT_VERSION = buildroot-2021.05
BUILDROOT_CONFIG_URL = https://raw.githubusercontent.com/wajidali4907/Linux1/master/Build_Image/buildroot/.config
BUSYBOX_CONFIG_URL = https://raw.githubusercontent.com/wajidali4907/Linux1/master/Build_Image/buildroot/busybox.config
RC_SCRIPT_URL = https://raw.githubusercontent.com/wajidali4907/Linux1/master/Build_Image/buildroot/rcS
CROSS_COMPILE=riscv32-unknown-linux-gnu-
KERNEL_CONFIG_URL=https://raw.githubusercontent.com/wajidali4907/Linux1/master/Build_Image/Linux/.config
RUN_SH_URL=https://raw.githubusercontent.com/wajidali4907/Linux1/master/Build_Image/Linux/run.sh

# Linux Kernel Variables
KERNEL_VERSION = linux-6.1
KERNEL_URL = https://www.kernel.org/pub/linux/kernel/v6.x/$(KERNEL_VERSION).tar.gz

# OpenSBI Variables
OPENSBI_VERSION = opensbi-0.9
OPENSBI_URL = https://github.com/riscv-software-src/opensbi/archive/refs/tags/$(OPENSBI_VERSION).zip
OPENSBI_ZIP = $(LINUX_BOOT_DIR)/v0.9.zip
OPENSBI_DIR = $(LINUX_BOOT_DIR)/opensbi-$(OPENSBI_VERSION)

# Commands
MAKE = make
TAR = tar
WGET = wget
CURL = curl
UNZIP=unzip

# Directories
LINUX_BOOT_DIR = $(CURDIR)/LinuxBuild
BUILDROOT_DIR = $(LINUX_BOOT_DIR)/$(BUILDROOT_VERSION)
RC_SCRIPT_DIR = $(BUILDROOT_DIR)/output/target/etc/init.d
KERNEL_DIR = $(KERNEL_VERSION)

# Default target
all:buildroot kernel opensbi


#Targets
buildroot:
	# Create the linux_boot directory if not exists
	mkdir -p $(LINUX_BOOT_DIR)

	# Change to the linux_boot directory
	cd $(LINUX_BOOT_DIR)

	# Download Buildroot
	$(WGET) https://buildroot.org/downloads/buildroot-2021.05.tar.gz -O buildroot-2021.05.tar.gz

	# Extract the contents of the Buildroot tarball
	$(TAR) -xvzf buildroot-2021.05.tar.gz -C $(LINUX_BOOT_DIR)
	
	# Configure Buildroot interactively
	$(MAKE) -C $(BUILDROOT_DIR) ARCH=riscv CROSS_COMPILE=$(CROSS_COMPILE) menuconfig

	# Download the golden reference .config file using curl
	$(CURL) -L $(BUILDROOT_CONFIG_URL) -o $(BUILDROOT_DIR)/.config
	
	# Configure BusyBox interactively
	$(MAKE) -C $(BUILDROOT_DIR) ARCH=riscv CROSS_COMPILE=$(CROSS_COMPILE) busybox-menuconfig

	# Download the custom BusyBox .config file
	$(CURL) -L $(BUSYBOX_CONFIG_URL) -o $(BUILDROOT_DIR)/package/busybox/busybox.config

	# Build Buildroot
	$(MAKE) -C $(BUILDROOT_DIR)

	# Download and replace rcS file
	$(CURL) -L $(RC_SCRIPT_URL) -o $(RC_SCRIPT_DIR)/rcS
	
	# Build Buildroot
	$(MAKE) -C $(BUILDROOT_DIR)

#
kernel:
	# Download the Linux kernel
	$(WGET) $(KERNEL_URL) -O $(CURDIR)/$(KERNEL_VERSION).tar.gz

	# Extract the contents of the Linux kernel tarball
	$(TAR) -xvzf $(KERNEL_VERSION).tar.gz -C $(LINUX_BOOT_DIR)

	# Configure the Linux kernel interactively for the RISC-V architecture
	$(MAKE) -C $(LINUX_BOOT_DIR)/$(KERNEL_DIR) ARCH=riscv CROSS_COMPILE=$(CROSS_COMPILE) menuconfig

	# Download and replace .config file
	$(CURL) -L $(KERNEL_CONFIG_URL) -o $(LINUX_BOOT_DIR)/$(KERNEL_DIR)/.config

	# Download and replace run.sh
	$(CURL) -L $(RUN_SH_URL) -o $(LINUX_BOOT_DIR)/$(KERNEL_DIR)/run.sh
	chmod +x $(LINUX_BOOT_DIR)/$(KERNEL_DIR)/run.sh

	# Download and replace uetrv_pcore_defconfig
	$(CURL) -L https://raw.githubusercontent.com/wajidali4907/Linux1/master/Build_Image/Linux/uetrv_pcore_defconfig -o $(LINUX_BOOT_DIR)/$(KERNEL_DIR)/arch/riscv/configs/uetrv_pcore_defconfig

	# Copy rootfs.cpio to linux-6.1 folder
	cp $(BUILDROOT_DIR)/output/images/rootfs.cpio $(LINUX_BOOT_DIR)/$(KERNEL_DIR)
	#chmod +x $(LINUX_BOOT_DIR)/$(KERNEL_DIR)/rootfs.cpio

	$(CURL) -L https://raw.githubusercontent.com/wajidali4907/Linux1/master/Build_Image/Linux/sifive.c -o $(LINUX_BOOT_DIR)/$(KERNEL_DIR)/drivers/tty/serial/sifive.c
	
	# Build the Linux kernel
	$(MAKE) -C $(LINUX_BOOT_DIR)/$(KERNEL_DIR) V=1 ARCH=riscv CROSS_COMPILE=$(CROSS_COMPILE) vmlinux
	
opensbi:
	# Download OpenSBI
	$(WGET) https://github.com/riscv-software-src/opensbi/archive/refs/tags/v0.9.zip -O $(LINUX_BOOT_DIR)/v0.9.zip
	
	# Extract the contents of the OpenSBI zip
	$(UNZIP) $(OPENSBI_ZIP) -d $(LINUX_BOOT_DIR)

	# Copy vmlinux from linux-6.1 to opensbi directory
	cp $(LINUX_BOOT_DIR)/$(KERNEL_DIR)/vmlinux $(LINUX_BOOT_DIR)

	# Copy run.sh
	$(CURL) -L https://raw.githubusercontent.com/wajidali4907/Linux1/master/Build_Image/OpenSBI/run.sh -o $(LINUX_BOOT_DIR)/run.sh
	chmod +x $(LINUX_BOOT_DIR)/run.sh
	
	# Clone the entire Linux1 repository
	git clone --depth=1 https://github.com/wajidali4907/Linux1.git --branch master --single-branch --quiet $(LINUX_BOOT_DIR)/Linux1

	# Move the util folder into place
	mv $(LINUX_BOOT_DIR)/Linux1/Build_Image/OpenSBI/util $(LINUX_BOOT_DIR)/util
	
	#Change to LinuxBuild directory and run the ./run.sh command
	cd $(LINUX_BOOT_DIR) && ./run.sh


	

	
	

