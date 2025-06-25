//
// Zig has an "unreachable" statement. Use it when you want to tell the
// Zig有一个"unreachable"语句。当你想告诉
// compiler that a branch of code should never be executed and that the
// 编译器某个代码分支永远不应该被执行，并且
// mere act of reaching it is an error.
// 仅仅到达它就是一个错误时使用它。
//
//     if (true) {
//         ...
//     } else {
//         unreachable;
//     }
//
// Here we've made a little virtual machine that performs mathematical
// 这里我们制作了一个小的虚拟机，它对单个数值执行数学
// operations on a single numeric value. It looks great but there's one
// 运算。它看起来很棒，但有一个
// little problem: the switch statement doesn't cover every possible
// 小问题：switch语句没有覆盖u8数字的
// value of a u8 number!
// 每个可能的值！
//
// WE know there are only three operations but Zig doesn't. Use the
// 我们知道只有三个操作，但Zig不知道。使用
// unreachable statement to make the switch complete. Or ELSE. :-)
// unreachable语句来使switch完整。或者ELSE。:-)
//
const std = @import("std");

pub fn main() void {
    const operations = [_]u8{ 1, 1, 1, 3, 2, 2 };

    var current_value: u32 = 0;

    for (operations) |op| {
        switch (op) {
            1 => {
                current_value += 1;
            },
            2 => {
                current_value -= 1;
            },
            3 => {
                current_value *= current_value;
            },
        }

        std.debug.print("{} ", .{current_value});
    }

    std.debug.print("\n", .{});
}
