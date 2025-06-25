//
// Quiz time. See if you can make this program work!
// 测试时间。看看你能否让这个程序工作！
//
// Solve this any way you like, just be sure the output is:
// 用任何你喜欢的方式解决这个问题，只要确保输出是：
//
//     my_num=42
//
const std = @import("std");

const NumError = error{IllegalNumber};

pub fn main() void {
    const stdout = std.io.getStdOut().writer();

    const my_num: u32 = getNumber();

    try stdout.print("my_num={}\n", .{my_num});
}

// This function is obviously weird and non-functional. But you will not be changing it for this quiz.
// 这个函数显然很奇怪且无功能。但在这个测试中你不能修改它。
fn getNumber() NumError!u32 {
    if (false) return NumError.IllegalNumber;
    return 42;
}
