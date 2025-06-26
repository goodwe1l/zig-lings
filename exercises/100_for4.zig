//
// We've seen that the 'for' loop can let us perform some action
// for every item in an array or slice.
// 我们已经看到 'for' 循环可以让我们对数组或切片中的每个项目执行某些操作。
//
// More recently, we discovered that it supports ranges to
// iterate over number sequences.
// 最近，我们发现它支持范围来迭代数字序列。
//
// This is part of a more general capability of the `for` loop:
// looping over one or more "objects" where an object is an
// array, slice, or range.
// 这是 `for` 循环更通用能力的一部分：循环一个或多个"对象"，
// 其中对象是数组、切片或范围。
//
// In fact, we *did* use multiple objects way back in Exercise
// 016 where we iterated over an array and also a numeric index.
// It didn't always work exactly this way, so the exercise had to
// be retroactively modified a little bit.
// 实际上，我们在练习 016 中确实使用了多个对象，在那里我们迭代了一个数组
// 和一个数字索引。它并不总是完全以这种方式工作，
// 所以练习必须被追溯修改一点点。
//
//     for (bits, 0..) |bit, i| { ... }
//
// The general form of a 'for' loop with two lists is:
// 带有两个列表的 'for' 循环的一般形式是：
//
//     for (list_a, list_b) |a, b| {
//         // Here we have the first item from list_a and list_b,
//         // then the second item from each, then the third and
//         // so forth...
//     }
//
// What's really beautiful about this is that we don't have to
// keep track of an index or advancing a memory pointer for
// *either* of these lists. That error-prone stuff is all taken
// care of for us by the compiler.
// 这种方式真正美妙的是，我们不必跟踪索引或为这些列表中的任何一个
// 推进内存指针。所有那些容易出错的东西都由编译器为我们处理。
//
// Below, we have a program that is supposed to compare two
// arrays. Please make it work!
// 下面，我们有一个应该比较两个数组的程序。请让它工作！
//
const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const hex_nums = [_]u8{ 0xb, 0x2a, 0x77 };
    const dec_nums = [_]u8{ 11, 42, 119 };

    for (hex_nums, ???) |hn, ???| {
        if (hn != dn) {
            print("Uh oh! Found a mismatch: {d} vs {d}\n", .{ hn, dn });
            return;
        }
    }

    print("Arrays match!\n", .{});
}
//
// You are perhaps wondering what happens if one of the two lists
// is longer than the other? Try it!
// 您可能想知道如果两个列表中的一个比另一个长会发生什么？试试看！
//
// By the way, congratulations for making it to Exercise 100!
// 顺便说一下，恭喜您完成了练习 100！
//
//    +-------------+
//    | Celebration |
//    | Area  * * * |
//    +-------------+
//
// Please keep your celebrating within the area provided.
// 请在提供的区域内庆祝。
