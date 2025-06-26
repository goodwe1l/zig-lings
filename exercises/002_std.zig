//
// Oops! This program is supposed to print a line like our Hello World
// example. But we forgot how to import the Zig Standard Library.
// 糟糕！这个程序应该像我们的 Hello World 示例一样打印一行。
// 但我们忘记了如何导入 Zig 标准库。
//
// The @import() function is built into Zig. It returns a value which
// represents the imported code. It's a good idea to store the import as
// a constant value with the same name as the import:
// @import() 函数是 Zig 内置的。它返回一个表示导入代码的值。
// 最好将导入存储为与导入同名的常量值：
//
//     const foo = @import("foo");
//
// Please complete the import below:
// 请完成下面的导入：
//

const std = @import("std");

pub fn main() void {
    std.debug.print("Standard Library.\n", .{});
}

// For the curious: Imports must be declared as constants because they
// can only be used at compile time rather than run time. Zig evaluates
// constant values at compile time. Don't worry, we'll cover imports
// in detail later.
// Also see this answer: https://stackoverflow.com/a/62567550/695615
// 给好奇的读者：导入必须声明为常量，因为它们只能在编译时使用，
// 而不是运行时。Zig 在编译时计算常量值。别担心，我们稍后会详细
// 介绍导入。
// 另见此答案：https://stackoverflow.com/a/62567550/695615
