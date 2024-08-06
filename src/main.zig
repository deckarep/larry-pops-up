const std = @import("std");
const rl = @import("raylib");

const SCREEN_WIDTH = 125;
const SCREEN_HEIGHT = 125;
const resourceFolders = &.{ "LpopsUp1", "LpopsUp2", "LpopsUp3", "LpopsUp4", "LpopsUp5" };

pub fn main() !void {
    std.debug.print("Hello World!\n", .{});
    rl.initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Larry Pops Up!");
    //rl.setWindowFocused();
    defer rl.closeWindow();
    rl.initAudioDevice();
    defer rl.closeAudioDevice();
    //rl.hideCursor();
    rl.setTargetFPS(30);

    while (!rl.windowShouldClose()) {
        // defer {
        //     _ = arena.reset(.retain_capacity);
        // }

        try update();
        try draw();
    }
}

fn update() !void {}

fn draw() !void {
    rl.beginDrawing();
    defer rl.endDrawing();

    rl.clearBackground(rl.Color.pink);
}
