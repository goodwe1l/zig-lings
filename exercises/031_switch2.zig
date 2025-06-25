//
// What's really nice is that you can use a switch statement as an
// 真正好的是你可以使用switch语句作为一个
// expression to return a value.
// 表达式来返回一个值。
//
//     const a = switch (x) {
//         1 => 9,
//         2 => 16,
//         3 => 7,
//         ...
//     }
//
const std = @import("std");

pub fn main() void {
    const lang_chars = [_]u8{ 26, 9, 7, 42 };

    for (lang_chars) |c| {
        const real_char: u8 = switch (c) {
            1 => 'A',
            2 => 'B',
            3 => 'C',
            4 => 'D',
            5 => 'E',
            6 => 'F',
            7 => 'G',
            8 => 'H',
            9 => 'I',
            10 => 'J',
            // ...
            25 => 'Y',
            26 => 'Z',
            // As in the last exercise, please add the 'else' clause
            // 和上一个练习一样，请添加'else'子句
            // and this time, have it return an exclamation mark '!'.
            // 这次让它返回感叹号'!'。
        };

        std.debug.print("{c}", .{real_char});
        // Note: "{c}" forces print() to display the value as a character.
        // 注意："{c}"强制print()将值显示为字符。
        // Can you guess what happens if you remove the "c"? Try it!
        // 你能猜出如果你移除"c"会发生什么吗？试试看！
    }

    std.debug.print("\n", .{});
}
