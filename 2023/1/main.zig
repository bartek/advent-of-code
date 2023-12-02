const std = @import("std");
const io = std.io;

fn part1(input: []const u8) u32 {
    var lines_iter = std.mem.tokenizeScalar(u8, input, '\n');
    var sum: u32 = 0;
    while (lines_iter.next()) |line| {
        if (line.len == 0) continue;
        var first: ?u8 = null;
        var second: ?u8 = null;

        for (line) |c| {
            switch (c) {
                '0'...'9' => {
                    if (first == null) first = c - '0';
                    second = c - '0';
                },
                else => {},
            }
        }
        if (first == null or second == null) continue;
        sum += 10 * first.? + second.?;
    }
    return sum;
}

fn part2(input: []const u8) u32 {
    const numbers = [_][]const u8{ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine" };

    var lines_iter = std.mem.tokenizeScalar(u8, input, '\n');
    var sum: u32 = 0;
    while (lines_iter.next()) |line| {
        if (line.len == 0) continue;
        var first: ?u32 = null;
        var second: ?u32 = null;

        var i: usize = 0;
        while (i < line.len) : (i += 1) {
            const digit: ?u32 = blk: for (numbers, 1..) |word, number| {
                if (line[i] == number + '0') {
                    break :blk @intCast(number);
                } else if (std.mem.eql(u8, line[i..@min(line.len, i + word.len)], word)) {
                    break :blk @intCast(number);
                }
            } else break :blk null;
            if (digit == null) continue;
            if (first == null) first = digit;
            second = digit;
        }
        if (first == null or second == null) continue;
        sum += 10 * first.? + second.?;
    }
    return sum;
}

test "part 1 sample" {
    const input =
        \\1abc2
        \\pqr3stu8vwx
        \\a1b2c3d4e5f
        \\treb7uchet
    ;

    // Expect must be comptime-known; match
    try std.testing.expectEqual(@as(u32, 142), part1(input));
}

test "part 1 puzzle" {
    const input = @embedFile("input.txt");
    try std.testing.expectEqual(@as(u32, 54338), part1(input));
}

test "part 2 sample" {
    const input =
        \\two1nine
        \\eightwothree
        \\abcone2threexyz
        \\xtwone3four
        \\4nineeightseven2
        \\zoneight234
        \\7pqrstsixteen
    ;
    try std.testing.expectEqual(@as(u32, 281), part2(input));
}

test "part 2 puzzle" {
    const input = @embedFile("input.txt");
    try std.testing.expectEqual(@as(u32, 53389), part2(input));
}
