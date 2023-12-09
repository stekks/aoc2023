const std = @import("std");
const Allocator = std.mem.Allocator;
const List = std.ArrayList;
const Map = std.AutoHashMap;
const StrMap = std.StringHashMap;
const BitSet = std.DynamicBitSet;

const util = @import("util.zig");
const gpa = util.gpa;

const data = @embedFile("data/day01.txt");

const digits = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

pub fn main() !void {
    var lines = splitAny(u8, data, "\n");

    var sum: usize = 0;
    var sumb: usize = 0;
    while (lines.next()) |line| {
        var first: usize = 0;
        var firstb: usize = 0;
        var last: usize = 0;
        var lastb: usize = 0;

        for (line, 0..) |c, i| {
            if (std.ascii.isDigit(c)) {
                first = c - '0';
                firstb = first;
                break;
            }

            for (digits, 1..) |digit, pos| {
                if (std.mem.startsWith(u8, line[i..], digit)) {
                    firstb = @as(usize, pos);
                    break;
                }
            }
            if (firstb > 0) break;
        }

        // no reversed for loop?
        var l = line.len;
        while (l >= 0) : (l -= 1) {
            if (std.ascii.isDigit(line[l - 1])) {
                last = line[l - 1] - '0';
                lastb = last;
                break;
            }

            for (digits, 1..) |digit, pos| {
                if (std.mem.startsWith(u8, line[l - 1 ..], digit)) {
                    lastb = @as(usize, pos);
                    break;
                }
            }
            if (lastb > 0) break;
        }

        if (firstb == 0) firstb = first;
        if (lastb == 0) lastb = last;

        sum += first * 10 + last;
        sumb += firstb * 10 + lastb;
    }

    print("sum: {}\n", .{sum});
    print("sumb: {}\n", .{sumb});
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
