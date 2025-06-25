//
// Now let's use pointers to do something we haven't been
// 现在让我们使用指针来做一些我们之前
// able to do before: pass a value by reference to a function.
// 无法做到的事情：通过引用将值传递给函数。
//
// Why would we wish to pass a pointer to an integer variable
// 为什么我们希望传递一个指向整数变量的指针
// rather than the integer value itself? Because then we are
// 而不是整数值本身？因为这样我们就被
// allowed to *change* the value of the variable!
// 允许*改变*变量的值！
//
//     +-----------------------------------------------+
//     | Pass by reference when you want to change the |
//     | 当你想要改变指向的值时，使用引用传递。        |
//     | pointed-to value. Otherwise, pass the value.  |
//     | 否则，传递值。                                |
//     +-----------------------------------------------+
//
const std = @import("std");

pub fn main() void {
    var num: u8 = 1;
    var more_nums = [_]u8{ 1, 1, 1, 1 };

    // Let's pass the num reference to our function and print it:
    // 让我们将num引用传递给我们的函数并打印它：
    makeFive(&num);
    std.debug.print("num: {}, ", .{num});

    // Now something interesting. Let's pass a reference to a
    // 现在是有趣的事。让我们传递一个对
    // specific array value:
    // 特定数组值的引用：
    makeFive(&more_nums[2]);

    // And print the array:
    // 并打印数组：
    std.debug.print("more_nums: ", .{});
    for (more_nums) |n| {
        std.debug.print("{} ", .{n});
    }

    std.debug.print("\n", .{});
}

// This function should take a reference to a u8 value and set it
// 这个函数应该接受一个u8值的引用并将其设置
// to 5.
// 为5。
fn makeFive(x: *u8) void {
    ??? = 5; // fix me!
             // 修复我！
}
