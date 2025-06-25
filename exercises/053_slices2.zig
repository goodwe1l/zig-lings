//
// You are perhaps tempted to try slices on strings? They're arrays of
// 你也许想在字符串上尝试切片？它们毕竟是
// u8 characters after all, right? Slices on strings work great.
// u8字符的数组，对吧？字符串切片工作得很好。
// There's just one catch: don't forget that Zig string literals are
// 只有一个问题：不要忘记Zig字符串字面量是
// immutable (const) values. So we need to change the type of slice
// 不可变(const)值。所以我们需要将切片类型从：
// from:
// 不可变(const)值。所以我们需要将切片类型从：
//
//     var foo: []u8 = "foobar"[0..3];
//
// to:
// 改为：
//
//     var foo: []const u8 = "foobar"[0..3];
//
// See if you can fix this Zero Wing-inspired phrase descrambler:
// 看看你能否修复这个受《Zero Wing》启发的短语解码器：
const std = @import("std");

pub fn main() void {
    const scrambled = "great base for all your justice are belong to us";

    const base1: []u8 = scrambled[15..23];
    const base2: []u8 = scrambled[6..10];
    const base3: []u8 = scrambled[32..];
    printPhrase(base1, base2, base3);

    const justice1: []u8 = scrambled[11..14];
    const justice2: []u8 = scrambled[0..5];
    const justice3: []u8 = scrambled[24..31];
    printPhrase(justice1, justice2, justice3);

    std.debug.print("\n", .{});
}

fn printPhrase(part1: []u8, part2: []u8, part3: []u8) void {
    std.debug.print("'{s} {s} {s}.' ", .{ part1, part2, part3 });
}
