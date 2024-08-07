const std = @import("std");
const rl = @import("raylib");

const SCREEN_WIDTH = 125;
const SCREEN_HEIGHT = 125;

const FPS = 30; // FPS, barely does anything, no need to tax user's system.
const framesToPass = FPS >> 1; // Seconds to wait based on fps, so the user has a chance to see the image before it goes away.

// pngs is a hardcoded, static table of all possible Larry images to show.
// perhaps more will be added...why the hell not?
const pngs = [_][]const u8{
    "LpopsUp1/POP1.png",
    "LpopsUp2/POP2.png",
    "LpopsUp3/POP3.png",
    "LpopsUp4/POP4.png",
    "LpopsUp5/POP5.png",
};

// wavs is a hardcoded, static table of all possible sound bites to play.
// Yes, a big fucken static list, get over it...this is a desktop toy.
const wavs = [_][]const u8{
    "LpopsUp1/L001.WAV",
    "LpopsUp1/L005.WAV",
    "LpopsUp1/L007.WAV",
    "LpopsUp1/L010.WAV",
    "LpopsUp1/L015.WAV",
    "LpopsUp1/L020.WAV",
    "LpopsUp1/L021.WAV",
    "LpopsUp1/L024.WAV",
    "LpopsUp1/L036.WAV",
    "LpopsUp1/L037.WAV",
    "LpopsUp1/L044.WAV",
    "LpopsUp1/L049.WAV",
    "LpopsUp1/L051.WAV",
    "LpopsUp1/L057.WAV",
    "LpopsUp1/L070.WAV",
    "LpopsUp1/L082.WAV",
    "LpopsUp1/L086.WAV",
    "LpopsUp1/L098.WAV",
    "LpopsUp1/L099.WAV",
    "LpopsUp1/L130.WAV",
    "LpopsUp1/L137.WAV",
    "LpopsUp2/L002.WAV",
    "LpopsUp2/L006.WAV",
    "LpopsUp2/L014.WAV",
    "LpopsUp2/L018.WAV",
    "LpopsUp2/L025.WAV",
    "LpopsUp2/L040.WAV",
    "LpopsUp2/L048.WAV",
    "LpopsUp2/L056.WAV",
    "LpopsUp2/L060.WAV",
    "LpopsUp2/L062.WAV",
    "LpopsUp2/L063.WAV",
    "LpopsUp2/L077.WAV",
    "LpopsUp2/L080.WAV",
    "LpopsUp2/L084.WAV",
    "LpopsUp2/L089.WAV",
    "LpopsUp2/L095.WAV",
    "LpopsUp2/L103.WAV",
    "LpopsUp2/L109.WAV",
    "LpopsUp2/L110.WAV",
    "LpopsUp2/L111.WAV",
    "LpopsUp2/L115.WAV",
    "LpopsUp2/L131.WAV",
    "LpopsUp3/L003.WAV",
    "LpopsUp3/L009.WAV",
    "LpopsUp3/L026.WAV",
    "LpopsUp3/L033.WAV",
    "LpopsUp3/L034.WAV",
    "LpopsUp3/L035.WAV",
    "LpopsUp3/L038.WAV",
    "LpopsUp3/L041.WAV",
    "LpopsUp3/L045.WAV",
    "LpopsUp3/L050.WAV",
    "LpopsUp3/L064.WAV",
    "LpopsUp3/L065.WAV",
    "LpopsUp3/L073.WAV",
    "LpopsUp3/L079.WAV",
    "LpopsUp3/L083.WAV",
    "LpopsUp3/L091.WAV",
    "LpopsUp3/L101.WAV",
    "LpopsUp3/L106.WAV",
    "LpopsUp3/L107.WAV",
    "LpopsUp3/L112.WAV",
    "LpopsUp3/L132.WAV",
    "LpopsUp4/ANSWER.WAV",
    "LpopsUp4/L004.WAV",
    "LpopsUp4/L008.WAV",
    "LpopsUp4/L028.WAV",
    "LpopsUp4/L030.WAV",
    "LpopsUp4/L039.WAV",
    "LpopsUp4/L043.WAV",
    "LpopsUp4/L053.WAV",
    "LpopsUp4/L055.WAV",
    "LpopsUp4/L066.WAV",
    "LpopsUp4/L071.WAV",
    "LpopsUp4/L081.WAV",
    "LpopsUp4/L087.WAV",
    "LpopsUp4/L090.WAV",
    "LpopsUp4/L094.WAV",
    "LpopsUp4/L105.WAV",
    "LpopsUp4/L108.WAV",
    "LpopsUp4/L119.WAV",
    "LpopsUp4/L120.WAV",
    "LpopsUp4/L122.WAV",
    "LpopsUp4/L126.WAV",
    "LpopsUp4/L133.WAV",
    "LpopsUp4/L138.WAV",
    "LpopsUp5/L012.WAV",
    "LpopsUp5/L016.WAV",
    "LpopsUp5/L023.WAV",
    "LpopsUp5/L027.WAV",
    "LpopsUp5/L032.WAV",
    "LpopsUp5/L042.WAV",
    "LpopsUp5/L058.WAV",
    "LpopsUp5/L059.WAV",
    "LpopsUp5/L068.WAV",
    "LpopsUp5/L069.WAV",
    "LpopsUp5/L072.WAV",
    "LpopsUp5/L075.WAV",
    "LpopsUp5/L085.WAV",
    "LpopsUp5/L092.WAV",
    "LpopsUp5/L096.WAV",
    "LpopsUp5/L097.WAV",
    "LpopsUp5/L104.WAV",
    "LpopsUp5/L113.WAV",
    "LpopsUp5/L116.WAV",
    "LpopsUp5/L117.WAV",
    "LpopsUp5/L134.WAV",
};

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
        "Larry Chosen Set: png:{d} wav:{d}\n",
        .{ larryChosenResources.pngIdx, larryChosenResources.wavIdx },
    );

    var buf: [100]u8 = undefined;
    const selectedPng = try std.fmt.bufPrintZ(buf[0..], "{s}", .{pngs[larryChosenResources.pngIdx]});
    std.debug.print("selectedPng: {s}\n", .{selectedPng});
    pngTexture = rl.loadTexture(selectedPng);
    defer rl.unloadTexture(pngTexture);

    const selectedWavFile = try std.fmt.bufPrintZ(buf[0..], "{s}", .{wavs[larryChosenResources.wavIdx]});
    std.debug.print("selectedWavFile: {s}\n", .{selectedWavFile});
    selectedWav = rl.loadSound(selectedWavFile);
    defer rl.unloadSound(selectedWav);

    while (!killApp and !rl.windowShouldClose()) {
        try update();
        try draw();
    }
}

const tuple = struct {
    pngIdx: usize,
    wavIdx: usize,
};

fn choosePngAndWav() !tuple {
    var prng = std.rand.DefaultPrng.init(blk: {
        var seed: u64 = undefined;
        try std.posix.getrandom(std.mem.asBytes(&seed));
        break :blk seed;
    });
    const rand = prng.random();

    const randPng = rand.intRangeAtMost(usize, 0, pngs.len - 1);
    const randWav = rand.intRangeAtMost(usize, 0, wavs.len - 1);

    return tuple{ .pngIdx = randPng, .wavIdx = randWav };
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
