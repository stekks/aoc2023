const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day02.txt");

pub fn main() !void {
    var lines = splitAny(u8, data, "\n");

    var sum: usize = 0;
    var sumb: i32 = 0;
    while (lines.next()) |line| {
        var game = tokenizeAny(u8, line[5..], ":");
        var gameNr = try parseInt(usize, game.next().?, 10);
        var sets = tokenizeAny(u8, game.next().?, ";");

        var red: i32 = 12;
        var green: i32 = 13;
        var blue: i32 = 14;
        var possible: bool = true;
        var maxRed: i32 = 0;
        var maxGreen: i32 = 0;
        var maxBlue: i32 = 0;
        while (sets.next()) |set| {
            var cubes = splitAny(u8, set, ",");
            while (cubes.next()) |cube| {
                var values = tokenizeAny(u8, cube, " ");
                var points = try parseInt(i32, values.next().?, 10);
                var color = values.next().?;
                switch (color[0]) {
                    'r' => {
                        if (points > maxRed) {
                            maxRed = points;
                        }
                        if (red < points) {
                            possible = false;
                        }
                    },
                    'g' => {
                        if (points > maxGreen) {
                            maxGreen = points;
                        }
                        if (green < points) {
                            possible = false;
                        }
                    },
                    'b' => {
                        if (points > maxBlue) {
                            maxBlue = points;
                        }
                        if (blue < points) {
                            possible = false;
                        }
                    },
                    else => unreachable,
                }
            }
        }

        if (possible) {
            print("Possbile {d}\n", .{gameNr});
            sum += gameNr;
        }

        sumb += (maxBlue * maxGreen * maxRed);
    }
    print("part a {d}\n", .{sum});
    print("part b {d}\n", .{sumb});
}

// Useful stdlib functions
const tokenizeAny = std.mem.tokenizeAny;
const tokenizeSeq = std.mem.tokenizeSequence;
const tokenizeSca = std.mem.tokenizeScalar;
const splitAny = std.mem.splitAny;
const splitSeq = std.mem.splitSequence;
const splitSca = std.mem.splitScalar;
const indexOf = std.mem.indexOfScalar;
const indexOfAny = std.mem.indexOfAny;
const indexOfStr = std.mem.indexOfPosLinear;
const lastIndexOf = std.mem.lastIndexOfScalar;
const lastIndexOfAny = std.mem.lastIndexOfAny;
const lastIndexOfStr = std.mem.lastIndexOfLinear;
const trim = std.mem.trim;
const sliceMin = std.mem.min;
const sliceMax = std.mem.max;

const parseInt = std.fmt.parseInt;
const parseFloat = std.fmt.parseFloat;

const print = std.debug.print;
const assert = std.debug.assert;

const sort = std.sort.block;
const asc = std.sort.asc;
const desc = std.sort.desc;

// Generated from template/template.zig.
// Run `zig build generate` to update.
// Only unmodified days will be updated.
