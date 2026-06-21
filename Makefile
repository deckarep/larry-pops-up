.PHONY: all arm64 x86_64 win verify clean

all: arm64 x86_64 win

arm64:
	zig build -Doptimize=ReleaseSmall -Dtarget=aarch64-macos --prefix zig-out/arm64

x86_64:
	zig build -Doptimize=ReleaseSmall -Dtarget=x86_64-macos --prefix zig-out/x86_64

win:
	zig build -Doptimize=ReleaseSmall -Dtarget=x86_64-windows --prefix zig-out/windows

verify: all
	@echo "== arm64 =="
	@file zig-out/arm64/bin/*
	@echo "== x86_64 =="
	@file zig-out/x86_64/bin/*

clean:
	rm -rf zig-out .zig-cache