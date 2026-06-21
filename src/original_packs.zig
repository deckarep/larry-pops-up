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

// These are the original Larry Pops Up! sound bites. They will be embedded in the binary.
// In the future, the end-user may provide .png or .wav files in a dedicated folder of their choosing
// for their own fun.

// originalPngs is a hardcoded, static table of all possible Larry images to show.
// perhaps more will be added...why the hell not?
pub const originalPngs = [_][]const u8{
    @embedFile("embeded/LpopsUp1/POP1.png"),
    @embedFile("embeded/LpopsUp2/POP2.png"),
    @embedFile("embeded/LpopsUp3/POP3.png"),
    @embedFile("embeded/LpopsUp4/POP4.png"),
    @embedFile("embeded/LpopsUp5/POP5.png"),
};

// originalWavs is a hardcoded, static table of all possible sound bites to play.
// Yes, a big fucken static list, get over it...this is a desktop toy.
pub const originalWavs = [_][]const u8{
    //@embedFile("embeded/LpopsUp1/L001.var.ogg"),
    @embedFile("embeded/LpopsUp1/L001.ogg"),
    @embedFile("embeded/LpopsUp1/L005.ogg"),
    @embedFile("embeded/LpopsUp1/L007.ogg"),
    @embedFile("embeded/LpopsUp1/L010.ogg"),
    @embedFile("embeded/LpopsUp1/L015.ogg"),
    @embedFile("embeded/LpopsUp1/L020.ogg"),
    @embedFile("embeded/LpopsUp1/L021.ogg"),
    @embedFile("embeded/LpopsUp1/L024.ogg"),
    @embedFile("embeded/LpopsUp1/L036.ogg"),
    @embedFile("embeded/LpopsUp1/L037.ogg"),
    @embedFile("embeded/LpopsUp1/L044.ogg"),
    @embedFile("embeded/LpopsUp1/L049.ogg"),
    @embedFile("embeded/LpopsUp1/L051.ogg"),
    @embedFile("embeded/LpopsUp1/L057.ogg"),
    @embedFile("embeded/LpopsUp1/L070.ogg"),
    @embedFile("embeded/LpopsUp1/L082.ogg"),
    @embedFile("embeded/LpopsUp1/L086.ogg"),
    @embedFile("embeded/LpopsUp1/L098.ogg"),
    @embedFile("embeded/LpopsUp1/L099.ogg"),
    @embedFile("embeded/LpopsUp1/L130.ogg"),
    @embedFile("embeded/LpopsUp1/L137.ogg"),
    @embedFile("embeded/LpopsUp2/L002.ogg"),
    @embedFile("embeded/LpopsUp2/L006.ogg"),
    @embedFile("embeded/LpopsUp2/L014.ogg"),
    @embedFile("embeded/LpopsUp2/L018.ogg"),
    @embedFile("embeded/LpopsUp2/L025.ogg"),
    @embedFile("embeded/LpopsUp2/L040.ogg"),
    @embedFile("embeded/LpopsUp2/L048.ogg"),
    @embedFile("embeded/LpopsUp2/L056.ogg"),
    @embedFile("embeded/LpopsUp2/L060.ogg"),
    @embedFile("embeded/LpopsUp2/L062.ogg"),
    @embedFile("embeded/LpopsUp2/L063.ogg"),
    @embedFile("embeded/LpopsUp2/L077.ogg"),
    @embedFile("embeded/LpopsUp2/L080.ogg"),
    @embedFile("embeded/LpopsUp2/L084.ogg"),
    @embedFile("embeded/LpopsUp2/L089.ogg"),
    @embedFile("embeded/LpopsUp2/L095.ogg"),
    @embedFile("embeded/LpopsUp2/L103.ogg"),
    @embedFile("embeded/LpopsUp2/L109.ogg"),
    @embedFile("embeded/LpopsUp2/L110.ogg"),
    @embedFile("embeded/LpopsUp2/L111.ogg"),
    @embedFile("embeded/LpopsUp2/L115.ogg"),
    @embedFile("embeded/LpopsUp2/L131.ogg"),
    @embedFile("embeded/LpopsUp3/L003.ogg"),
    @embedFile("embeded/LpopsUp3/L009.ogg"),
    @embedFile("embeded/LpopsUp3/L026.ogg"),
    @embedFile("embeded/LpopsUp3/L033.ogg"),
    @embedFile("embeded/LpopsUp3/L034.ogg"),
    @embedFile("embeded/LpopsUp3/L035.ogg"),
    @embedFile("embeded/LpopsUp3/L038.ogg"),
    @embedFile("embeded/LpopsUp3/L041.ogg"),
    @embedFile("embeded/LpopsUp3/L045.ogg"),
    @embedFile("embeded/LpopsUp3/L050.ogg"),
    @embedFile("embeded/LpopsUp3/L064.ogg"),
    @embedFile("embeded/LpopsUp3/L065.ogg"),
    @embedFile("embeded/LpopsUp3/L073.ogg"),
    @embedFile("embeded/LpopsUp3/L079.ogg"),
    @embedFile("embeded/LpopsUp3/L083.ogg"),
    @embedFile("embeded/LpopsUp3/L091.ogg"),
    @embedFile("embeded/LpopsUp3/L101.ogg"),
    @embedFile("embeded/LpopsUp3/L106.ogg"),
    @embedFile("embeded/LpopsUp3/L107.ogg"),
    @embedFile("embeded/LpopsUp3/L112.ogg"),
    @embedFile("embeded/LpopsUp3/L132.ogg"),
    @embedFile("embeded/LpopsUp4/ANSWER.ogg"),
    @embedFile("embeded/LpopsUp4/L004.ogg"),
    @embedFile("embeded/LpopsUp4/L008.ogg"),
    @embedFile("embeded/LpopsUp4/L028.ogg"),
    @embedFile("embeded/LpopsUp4/L030.ogg"),
    @embedFile("embeded/LpopsUp4/L039.ogg"),
    @embedFile("embeded/LpopsUp4/L043.ogg"),
    @embedFile("embeded/LpopsUp4/L053.ogg"),
    @embedFile("embeded/LpopsUp4/L055.ogg"),
    @embedFile("embeded/LpopsUp4/L066.ogg"),
    @embedFile("embeded/LpopsUp4/L071.ogg"),
    @embedFile("embeded/LpopsUp4/L081.ogg"),
    @embedFile("embeded/LpopsUp4/L087.ogg"),
    @embedFile("embeded/LpopsUp4/L090.ogg"),
    @embedFile("embeded/LpopsUp4/L094.ogg"),
    @embedFile("embeded/LpopsUp4/L105.ogg"),
    @embedFile("embeded/LpopsUp4/L108.ogg"),
    @embedFile("embeded/LpopsUp4/L119.ogg"),
    @embedFile("embeded/LpopsUp4/L120.ogg"),
    @embedFile("embeded/LpopsUp4/L122.ogg"),
    @embedFile("embeded/LpopsUp4/L126.ogg"),
    @embedFile("embeded/LpopsUp4/L133.ogg"),
    @embedFile("embeded/LpopsUp4/L138.ogg"),
    @embedFile("embeded/LpopsUp5/L012.ogg"),
    @embedFile("embeded/LpopsUp5/L016.ogg"),
    @embedFile("embeded/LpopsUp5/L023.ogg"),
    @embedFile("embeded/LpopsUp5/L027.ogg"),
    @embedFile("embeded/LpopsUp5/L032.ogg"),
    @embedFile("embeded/LpopsUp5/L042.ogg"),
    @embedFile("embeded/LpopsUp5/L058.ogg"),
    @embedFile("embeded/LpopsUp5/L059.ogg"),
    @embedFile("embeded/LpopsUp5/L068.ogg"),
    @embedFile("embeded/LpopsUp5/L069.ogg"),
    @embedFile("embeded/LpopsUp5/L072.ogg"),
    @embedFile("embeded/LpopsUp5/L075.ogg"),
    @embedFile("embeded/LpopsUp5/L085.ogg"),
    @embedFile("embeded/LpopsUp5/L092.ogg"),
    @embedFile("embeded/LpopsUp5/L096.ogg"),
    @embedFile("embeded/LpopsUp5/L097.ogg"),
    @embedFile("embeded/LpopsUp5/L104.ogg"),
    @embedFile("embeded/LpopsUp5/L113.ogg"),
    @embedFile("embeded/LpopsUp5/L116.ogg"),
    @embedFile("embeded/LpopsUp5/L117.ogg"),
    @embedFile("embeded/LpopsUp5/L134.ogg"),
};
