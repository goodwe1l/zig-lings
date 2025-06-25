//
// It seems we got a little carried away making everything "const u8"!
// 看起来我们有点过火了，把所有东西都设成了 "const u8"！
//
//     "const" values cannot change.
//     "const" 值不能改变。
//     "u"     types are "unsigned" and cannot store negative values.
//     "u"     类型是"无符号"的，不能存储负值。
//     "8"     means the type is 8 bits in size.
//     "8"     表示类型的大小是8位。
//
// Example: foo cannot change (it is CONSTant)
//          bar can change (it is VARiable):
// 示例：foo 不能改变（它是常量 CONSTant）
//       bar 可以改变（它是变量 VARiable）：
//
//     const foo: u8 = 20;
//     var bar: u8 = 20;
//
// Example: foo cannot be negative and can hold 0 to 255
//          bar CAN be negative and can hold -128 to 127
// 示例：foo 不能为负数，可以存储 0 到 255
//       bar 可以为负数，可以存储 -128 到 127
//
//     const foo: u8 = 20;
//     const bar: i8 = -20;
//
// Example: foo can hold 8 bits (0 to 255)
//          bar can hold 16 bits (0 to 65,535)
// 示例：foo 可以存储 8 位（0 到 255）
//       bar 可以存储 16 位（0 到 65,535）
//
//     const foo: u8 = 20;
//     const bar: u16 = 2000;
//
// You can do just about any combination of these that you can think of:
// 你可以使用几乎任何你能想到的这些类型的组合：
//
//     u32 can hold 0 to 4,294,967,295
//     u32 可以存储 0 到 4,294,967,295
//     i64 can hold -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
//     i64 可以存储 -9,223,372,036,854,775,808 到 9,223,372,036,854,775,807
//
// Please fix this program so that the types can hold the desired values
// and the errors go away!
// 请修复这个程序，使类型能够存储所需的值，让错误消失！
//
const std = @import("std");

pub fn main() void {
    const n: u8 = 50;
    n = n + 5;

    const pi: u8 = 314159;

    const negative_eleven: u8 = -11;

    // There are no errors in the next line, just explanation:
    // Perhaps you noticed before that the print function takes two
    // parameters. Now it will make more sense: the first parameter
    // is a string. The string may contain placeholders '{}', and the
    // second parameter is an "anonymous list literal" (don't worry
    // about this for now!) with the values to be printed.
    // 下一行没有错误，只是解释：
    // 也许你之前注意到 print 函数接受两个参数。现在这更有意义了：
    // 第一个参数是一个字符串。字符串可能包含占位符'{}'，
    // 第二个参数是一个"匿名列表字面量"（现在不用担心这个！）
    // 包含要打印的值。
    std.debug.print("{} {} {}\n", .{ n, pi, negative_eleven });
}
