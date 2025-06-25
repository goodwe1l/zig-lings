//
// The "switch" statement lets you match the possible values of an
// "switch"语句允许你匹配表达式的可能值
// expression and perform a different action for each.
// 并为每个值执行不同的操作。
//
// This switch:
// 这个switch：
//
//     switch (players) {
//         1 => startOnePlayerGame(),
//         2 => startTwoPlayerGame(),
//         else => {
//             alert();
//             return GameError.TooManyPlayers;
//         }
//     }
//
// Is equivalent to this if/else:
// 等价于这个if/else：
//
//     if (players == 1) startOnePlayerGame();
//     else if (players == 2) startTwoPlayerGame();
//     else {
//         alert();
//         return GameError.TooManyPlayers;
//     }
//
const std = @import("std");

pub fn main() void {
    const lang_chars = [_]u8{ 26, 9, 7, 42 };

    for (lang_chars) |c| {
        switch (c) {
            1 => std.debug.print("A", .{}),
            2 => std.debug.print("B", .{}),
            3 => std.debug.print("C", .{}),
            4 => std.debug.print("D", .{}),
            5 => std.debug.print("E", .{}),
            6 => std.debug.print("F", .{}),
            7 => std.debug.print("G", .{}),
            8 => std.debug.print("H", .{}),
            9 => std.debug.print("I", .{}),
            10 => std.debug.print("J", .{}),
            // ... we don't need everything in between ...
            // ... 我们不需要中间的所有内容 ...
            25 => std.debug.print("Y", .{}),
            26 => std.debug.print("Z", .{}),
            // Switch statements must be "exhaustive" (there must be a
            // Switch语句必须是"详尽的"（必须有一个
            // match for every possible value).  Please add an "else"
            // 匹配每个可能的值）。请添加一个"else"
            // to this switch to print a question mark "?" when c is
            // 到这个switch中，当c不是
            // not one of the existing matches.
            // 现有匹配项之一时打印问号"?"。
        }
    }

    std.debug.print("\n", .{});
}
