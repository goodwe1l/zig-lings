//
// Behold the 'for' loop! For loops let you execute code for each
// element of an array:
// 看这个 'for' 循环！For 循环让你为数组的每个元素执行代码：
//
//     for (items) |item| {
//
//         // Do something with item
//         // 对 item 做一些操作
//
//     }
//
const std = @import("std");

pub fn main() void {
    const story = [_]u8{ 'h', 'h', 's', 'n', 'h' };

    std.debug.print("A Dramatic Story: ", .{});

    for (???) |???| {
        if (scene == 'h') std.debug.print(":-)  ", .{});
        if (scene == 's') std.debug.print(":-(  ", .{});
        if (scene == 'n') std.debug.print(":-|  ", .{});
    }

    std.debug.print("The End.\n", .{});
}
// Note that 'for' loops also work on things called "slices"
// which we'll see later.
//
// Also note that 'for' loops have recently become more flexible
// and powerful (two years after this exercise was written).
// More about that in a moment.
// 注意 'for' 循环也可以用于称为"切片"的东西，我们稍后会看到。
//
// 还要注意 'for' 循环最近变得更加灵活和强大
//（在编写此练习的两年后）。稍后会详细介绍。
