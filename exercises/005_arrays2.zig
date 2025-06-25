//
// Zig has some fun array operators.
// Zig 有一些有趣的数组操作符。
//
// You can use '++' to concatenate two arrays:
// 你可以使用 '++' 来连接两个数组：
//
//   const a = [_]u8{ 1,2 };
//   const b = [_]u8{ 3,4 };
//   const c = a ++ b ++ [_]u8{ 5 }; // equals 1 2 3 4 5
//
// You can use '**' to repeat an array:
// 你可以使用 '**' 来重复一个数组：
//
//   const d = [_]u8{ 1,2,3 } ** 2; // equals 1 2 3 1 2 3
//
// Note that both '++' and '**' only operate on arrays while your
// program is _being compiled_. This special time is known in Zig
// parlance as "comptime" and we'll learn plenty more about that
// later.
// 注意 '++' 和 '**' 都只在程序_编译期间_对数组进行操作。
// 这个特殊时期在 Zig 术语中被称为 "comptime"，我们稍后会学到更多。
//
const std = @import("std");

pub fn main() void {
    const le = [_]u8{ 1, 3 };
    const et = [_]u8{ 3, 7 };

    // (Problem 1)
    // Please set this array concatenating the two arrays above.
    // It should result in: 1 3 3 7
    // （问题 1）
    // 请设置这个数组，连接上面的两个数组。
    // 结果应该是：1 3 3 7
    const leet = ???;

    // (Problem 2)
    // Please set this array using repetition.
    // It should result in: 1 0 0 1 1 0 0 1 1 0 0 1
    // （问题 2）
    // 请使用重复来设置这个数组。
    // 结果应该是：1 0 0 1 1 0 0 1 1 0 0 1
    const bit_pattern = [_]u8{ ??? } ** 3;

    // Okay, that's all of the problems. Let's see the results.
    //
    // We could print these arrays with leet[0], leet[1],...but let's
    // have a little preview of Zig 'for' loops instead:
    //
    //    for (<item array>) |item| { <do something with item> }
    //
    // Don't worry, we'll cover looping properly in upcoming
    // lessons.
    //
    // 好的，这就是所有的问题。让我们看看结果。
    //
    // 我们可以用 leet[0], leet[1],... 来打印这些数组，但让我们
    // 先预览一下 Zig 的 'for' 循环：
    //
    //    for (<item array>) |item| { <do something with item> }
    //
    // 别担心，我们会在接下来的课程中正确地学习循环。
    //
    std.debug.print("LEET: ", .{});

    for (leet) |n| {
        std.debug.print("{}", .{n});
    }

    std.debug.print(", Bits: ", .{});

    for (bit_pattern) |n| {
        std.debug.print("{}", .{n});
    }

    std.debug.print("\n", .{});
}
