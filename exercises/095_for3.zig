//
// The Zig language is in rapid development and continuously
// improves the language constructs. Ziglings evolves with it.
// Zig 语言正在快速发展并不断改进语言构造。Ziglings 与之一起发展。
//
// Until version 0.11, Zig's 'for' loops did not directly
// replicate the functionality of the C-style: "for(a;b;c)"
// which are so well suited for iterating over a numeric
// sequence.
// 直到 0.11 版本，Zig 的 'for' 循环并没有直接复制 C 风格的功能："for(a;b;c)"，
// 这种形式非常适合迭代数字序列。
//
// Instead, 'while' loops with counters clumsily stood in their
// place:
// 相反，带计数器的 'while' 循环笨拙地代替了它们：
//
//     var i: usize = 0;
//     while (i < 10) : (i += 1) {
//         // Here variable 'i' will have each value 0 to 9.
//     }
//
// But here we are in the glorious future and Zig's 'for' loops
// can now take this form:
// 但我们现在处于光荣的未来，Zig 的 'for' 循环现在可以采用这种形式：
//
//     for (0..10) |i| {
//         // Here variable 'i' will have each value 0 to 9.
//     }
//
// The key to understanding this example is to know that '0..9'
// uses the new range syntax:
// 理解这个示例的关键是要知道 '0..9' 使用了新的范围语法：
//
//     0..10 is a range from 0 to 9
//     0..10 是从 0 到 9 的范围
//     1..4  is a range from 1 to 3
//     1..4  是从 1 到 3 的范围
//
// At the moment, ranges in loops are only supported in 'for' loops.
// 目前，循环中的范围只在 'for' 循环中支持。
//
// Perhaps you recall Exercise 13? We were printing a numeric
// sequence like so:
// 也许您还记得练习 13？我们那时打印数字序列是这样的：
//
//     var n: u32 = 1;
//
//     // I want to print every number between 1 and 20 that is NOT
//     // divisible by 3 or 5.
//     while (n <= 20) : (n += 1) {
//         // The '%' symbol is the "modulo" operator and it
//         // returns the remainder after division.
//         if (n % 3 == 0) continue;
//         if (n % 5 == 0) continue;
//         std.debug.print("{} ", .{n});
//     }
//
//  Let's try out the new form of 'for' to re-implement that
//  exercise:
//  让我们尝试使用新的 'for' 形式来重新实现那个练习：
//
const std = @import("std");

pub fn main() void {

    // I want to print every number between 1 and 20 that is NOT
    // divisible by 3 or 5.
    // 我想打印 1 到 20 之间不能被 3 或 5 整除的每个数字。
    for (???) |n| {

        // The '%' symbol is the "modulo" operator and it
        // returns the remainder after division.
        // '%' 符号是"模运算"操作符，它返回除法后的余数。
        if (n % 3 == 0) continue;
        if (n % 5 == 0) continue;
        std.debug.print("{} ", .{n});
    }

    std.debug.print("\n", .{});
}
//
// That's a bit nicer, right?
// 这样更好一些，对吧？
//
// Of course, both 'while' and 'for' have different advantages.
// Exercises 11, 12, and 14 would NOT be simplified by switching
// a 'while' for a 'for'.
// 当然，'while' 和 'for' 都有不同的优势。
// 将练习 11、12 和 14 中的 'while' 换成 'for' 并不会简化它们。
