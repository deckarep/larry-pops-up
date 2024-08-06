const std = @import("std");
const rl = @import("raylib");

const SCREEN_WIDTH = 125;
const SCREEN_HEIGHT = 125;
const resourceFolders = &.{ "LpopsUp1", "LpopsUp2", "LpopsUp3", "LpopsUp4", "LpopsUp5" };
const audio1 = "LpopsUp1/L001.WAV";
var currentSound: rl.Sound = undefined;
var soundIsDone = false;

const png1 = "LpopsUp1/POP1.png";
var png1Texture: rl.Texture = undefined;

pub fn main() !void {
    std.debug.print("Hello World!\n", .{});
    rl.initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Larry Pops Up!");
    //rl.setWindowFocused();
    defer rl.closeWindow();
    rl.initAudioDevice();
    defer rl.closeAudioDevice();
    rl.setTargetFPS(30);

    png1Texture = rl.loadTexture(png1);
    defer rl.unloadTexture(png1Texture);

    currentSound = rl.loadSound(audio1);
    defer rl.unloadSound(currentSound);

    rl.playSound(currentSound);

    while (!soundIsDone and !rl.windowShouldClose()) {
        // defer {
        //     _ = arena.reset(.retain_capacity);
        // }

        try update();
        try draw();
    }
}

fn update() !void {
    if (!rl.isSoundPlaying(currentSound)){
        soundIsDone = true;
    }
}

fn draw() !void {
    rl.beginDrawing();
    defer rl.endDrawing();

    rl.clearBackground(rl.Color.pink);

    rl.drawTexture(png1Texture, 0, 0, rl.Color.white);
}
