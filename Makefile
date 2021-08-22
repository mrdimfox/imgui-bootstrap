ifeq ($(OS),Windows_NT)
	PRESET=windows
else
	RM=linux
endif

ifeq ("$(wildcard vcpkg)", "")
	clone_vcpkg=git clone https://github.com/microsoft/vcpkg.git
else
	clone_vcpkg=@echo Skipping cloning because vcpkg already exists.
endif

.PHONY: vcpkg-init init configure build

vcpkg-init:
	$(clone_vcpkg)

init: vcpkg-init configure

configure:
	cmake --preset=$(PRESET) .

build:
	cmake --build build

all: init configure build
