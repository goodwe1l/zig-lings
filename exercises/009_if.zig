//
// Now we get into the fun stuff, starting with the 'if' statement!
// 现在我们进入有趣的部分，从 'if' 语句开始！
//
//     if (true) {
//         ...
//     } else {
//         ...
//     }
//
// Zig has the "usual" comparison operators such as:
// Zig 有"常用的"比较操作符，如：
//
//     a == b   means "a equals b"
//     a == b   意思是"a 等于 b"
//     a < b    means "a is less than b"
//     a < b    意思是"a 小于 b"
//     a > b    means "a is greater than b"
//     a > b    意思是"a 大于 b"
//     a != b   means "a does not equal b"
//     a != b   意思是"a 不等于 b"
//
// The important thing about Zig's "if" is that it *only* accepts
// boolean values. It won't coerce numbers or other types of data
// to true and false.
// 关于 Zig 的 "if" 的重要一点是它*只*接受布尔值。
// 它不会将数字或其他类型的数据强制转换为 true 和 false。
//
const std = @import("std");

pub fn main() void {
    const foo = 1;

    // Please fix this condition:
    // 请修复这个条件：
    if (foo) {
        // We want our program to print this message!
        // 我们希望程序打印这条消息！
        std.debug.print("Foo is 1!\n", .{});
    } else {
        std.debug.print("Foo is not 1!\n", .{});
    }
}
