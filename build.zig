const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    var threaded: std.Io.Threaded = .init(b.allocator, .{});
    defer threaded.deinit();
    const io = threaded.io();

    const raylib_dep = b.dependency("raylib_zig", .{
        .target = target,
        .optimize = optimize,
        .raudio = true, // necessary for audio in either desktop or wasm!
    });

    const raylib = raylib_dep.module("raylib");

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = false,
    });
    exe_mod.addImport("raylib", raylib);

    // NOTE: Added this nonsense to support cross compilation for both MacOS (Intel+ Apple Silicon)
    if (target.result.os.tag == .macos) {
        if (std.zig.system.darwin.getSdk(b.allocator, io, &target.result)) |sdk_path| {
            exe_mod.addSystemFrameworkPath(.{ .cwd_relative = b.fmt("{s}/System/Library/Frameworks", .{sdk_path}) });
            exe_mod.addSystemIncludePath(.{ .cwd_relative = b.fmt("{s}/usr/include", .{sdk_path}) });
            exe_mod.addLibraryPath(.{ .cwd_relative = b.fmt("{s}/usr/lib", .{sdk_path}) });
        }
    }

    const run_step = b.step("run", "Run the app");

    const exe = b.addExecutable(.{
        .name = "Larry Pops Up!",
        .root_module = exe_mod,
    });
    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    run_step.dependOn(&run_cmd.step);
}
