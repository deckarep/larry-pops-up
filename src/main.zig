const std = @import("std");
const ogPack = @import("original_packs.zig");
const rl = @import("raylib");

const SCREEN_WIDTH = 125;
const SCREEN_HEIGHT = 125;

const FPS = 30; // FPS, barely does anything, no need to tax user's system.
const framesToPass = FPS >> 1; // Seconds to wait based on fps, so the user has a chance to see the image before it goes away.

var pngTexture: rl.Texture = undefined;
var selectedWav: rl.Sound = undefined;
var soundIsDone = false;
var killApp = false;

pub fn main() !void {
    std.log.info("Larry Pops Up! by @deckarep - 2024\n", .{});
    rl.initWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Larry Pops Up!");
    rl.setWindowMaxSize(SCREEN_WIDTH, SCREEN_HEIGHT);
    //rl.toggleBorderlessWindowed(); // - doesn't seem to work on macos.
    rl.setWindowFocused();
    defer rl.closeWindow();
    rl.initAudioDevice();
    defer rl.closeAudioDevice();
    rl.setTargetFPS(FPS);

    rl.setWindowPosition(0, 0);

    const larryChosenResources = try choosePngAndWav();
    std.debug.print(
        "Larry Chosen Set: png: {d} wav: {d}\n",
        .{ larryChosenResources.pngIdx, larryChosenResources.wavIdx },
    );

    const selectedPng = ogPack.originalPngs[larryChosenResources.pngIdx];
    const img = rl.loadImageFromMemory(".png", selectedPng);
    pngTexture = rl.loadTextureFromImage(img);
    defer rl.unloadTexture(pngTexture);

    const selectedWavFile = ogPack.originalWavs[larryChosenResources.wavIdx];
    const memWav = rl.loadWaveFromMemory(".wav", selectedWavFile);
    selectedWav = rl.loadSoundFromWave(memWav);
    defer rl.unloadSound(selectedWav);

    while (!killApp and !rl.windowShouldClose()) {
        try update();
        try draw();
    }
}

const selectedIndices = struct {
    pngIdx: usize,
    wavIdx: usize,
};

fn choosePngAndWav() !selectedIndices {
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    const randPng = rand.intRangeAtMost(usize, 0, ogPack.originalPngs.len - 1);
    const randWav = rand.intRangeAtMost(usize, 0, ogPack.originalWavs.len - 1);

    return selectedIndices{ .pngIdx = randPng, .wavIdx = randWav };
}

pub fn center_window(width: u32, height: u32) void {
    const w = @as(c_int, @intCast(width));
    const h = @as(c_int, @intCast(height));
    const mon = rl.getCurrentMonitor();
    const mon_width = rl.getMonitorWidth(mon);
    const mon_height = rl.getMonitorHeight(mon);
    rl.setWindowPosition(@divTrunc(mon_width, 2) - @divTrunc(w, 2), @divTrunc(mon_height, 2) - @divTrunc(h, 2));
}

var hangTime: i32 = 0;
var soundPlayCount: i32 = 0;
fn update() !void {
    if (soundPlayCount == 0 and !rl.isSoundPlaying(selectedWav) and rl.isSoundReady(selectedWav)) {
        rl.playSound(selectedWav);
        soundPlayCount = 1;
    }

    if (!rl.isSoundPlaying(selectedWav)) {
        soundIsDone = true;
        hangTime += 1;
    }

    if (hangTime >= framesToPass) {
        killApp = true;
    }
}

fn draw() !void {
    rl.beginDrawing();
    defer rl.endDrawing();

    rl.clearBackground(rl.Color.pink);
    rl.drawTexture(pngTexture, 0, 0, rl.Color.white);
}
