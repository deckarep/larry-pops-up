// Open Source Initiative OSI - The MIT License (MIT):Licensing

// The MIT License (MIT)
// Copyright (c) 2024 - 2026 Ralph Caraveo (deckarep@gmail.com)

// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
// of the Software, and to permit persons to whom the Software is furnished to do
// so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

const std = @import("std");
const ogPack = @import("original_packs.zig");
const lsl6Pack = @import("lsl6_packs.zig");
const rl = @import("raylib");

const SCREEN_WIDTH = 125;
const SCREEN_HEIGHT = 125;

const ALT_SCREEN_WIDTH = 71 * 2;
const ALT_SCREEN_HEIGHT = 96 * 2;

const FPS = 30; // FPS, barely does anything, no need to tax user's system.
const framesToPass = FPS >> 1; // Seconds to wait based on fps, so the user has a chance to see the image before it goes away.

const selectedIndices = struct {
    pngIdx: usize,
    wavIdx: usize,
};

var soundIsDone = false;
var killApp = false;
var scaleFactor: f32 = 1;

pub fn main(init: std.process.Init) !void {
    const io = init.io;
    std.log.info("Larry Pops Up! - (@deckarep - 2026)\n", .{});

    const larryChosenResources = try choosePngAndWav(io);
    std.debug.print(
        "Larry Chosen Set: png: {d} wav: {d}\n",
        .{ larryChosenResources.pngIdx, larryChosenResources.wavIdx },
    );

    const allPngs = ogPack.originalPngs ++ lsl6Pack.lsl6Pngs;

    const selectedPng = allPngs[larryChosenResources.pngIdx];

    var sw: i32 = SCREEN_WIDTH;
    var sh: i32 = SCREEN_HEIGHT;
    if (larryChosenResources.pngIdx > 4) {
        // hack to set window for newer Larry portraits (beyond the original implementation)
        sw = ALT_SCREEN_WIDTH;
        sh = ALT_SCREEN_HEIGHT;
    }

    rl.setConfigFlags(.{
        .borderless_windowed_mode = true,
        .window_undecorated = true,
        .window_topmost = true,
        .window_resizable = false,
    });
    rl.initWindow(sw, sh, "Larry Pops Up!");
    rl.setWindowMaxSize(sw, sh);
    rl.setWindowFocused();
    defer rl.closeWindow();
    rl.initAudioDevice();
    defer rl.closeAudioDevice();
    rl.setTargetFPS(FPS);
    rl.setWindowPosition(0, 0);

    const img = try rl.loadImageFromMemory(".PNG", selectedPng);
    defer rl.unloadImage(img);
    if (larryChosenResources.pngIdx > 4) {
        // Hack: the lsl6 portraits are scaled up by 2.
        scaleFactor = 2.0;
    }

    const pngTexture = try rl.loadTextureFromImage(img);
    defer rl.unloadTexture(pngTexture);

    const selectedWavFile = ogPack.originalWavs[larryChosenResources.wavIdx];
    const memWav = try rl.loadWaveFromMemory(".wav", selectedWavFile);
    defer rl.unloadWave(memWav);
    const selectedWav = rl.loadSoundFromWave(memWav);
    defer rl.unloadSound(selectedWav);

    try play(&selectedWav, &pngTexture);
}

fn play(sound: *const rl.Sound, texture: *const rl.Texture) !void {
    while (!killApp and !rl.windowShouldClose()) {
        try update(sound);
        try draw(texture);
    }
}

fn choosePngAndWav(io: std.Io) !selectedIndices {
    var prng = std.Random.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        io.random(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    const allPngCounts = ogPack.originalPngs.len + lsl6Pack.lsl6Pngs.len;
    const randPng = rand.intRangeAtMost(usize, 0, allPngCounts - 1);
    const randWav = rand.intRangeAtMost(usize, 0, ogPack.originalWavs.len - 1);

    return selectedIndices{ .pngIdx = randPng, .wavIdx = randWav };
}

// pub fn center_window(width: u32, height: u32) void {
//     const w = @as(c_int, @intCast(width));
//     const h = @as(c_int, @intCast(height));
//     const mon = rl.getCurrentMonitor();
//     const mon_width = rl.getMonitorWidth(mon);
//     const mon_height = rl.getMonitorHeight(mon);
//     rl.setWindowPosition(@divTrunc(mon_width, 2) - @divTrunc(w, 2), @divTrunc(mon_height, 2) - @divTrunc(h, 2));
// }

var hangTime: i32 = 0;
var soundPlayCount: i32 = 0;
fn update(snd: *const rl.Sound) !void {
    if (soundPlayCount == 0 and !rl.isSoundPlaying(snd.*) and rl.isSoundValid(snd.*)) {
        rl.playSound(snd.*);
        soundPlayCount = 1;
    }

    if (!rl.isSoundPlaying(snd.*)) {
        soundIsDone = true;
        hangTime += 1;
    }

    if (hangTime >= framesToPass) {
        killApp = true;
    }
}

fn draw(txtr: *const rl.Texture) !void {
    rl.beginDrawing();
    defer rl.endDrawing();

    rl.clearBackground(rl.Color.pink);

    // Some assets might be scaled, so we use the more complicated from for teture drawing.
    const tw: f32 = @floatFromInt(txtr.width);
    const th: f32 = @floatFromInt(txtr.height);
    const sf: f32 = scaleFactor;
    const src = rl.Rectangle.init(0, 0, tw, th);
    const dst = rl.Rectangle.init(0, 0, tw * sf, th * sf);
    const org = rl.Vector2.init(0, 0);

    rl.drawTexturePro(txtr.*, src, dst, org, 0, rl.Color.white);
}
