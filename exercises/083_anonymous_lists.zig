//
// Anonymous struct literal syntax can also be used to compose an
// "anonymous list" with an array type destination:
// 匿名结构体字面量语法也可以用来与数组类型目标组成"匿名列表"：
//
//     const foo: [3]u32 = .{10, 20, 30};
//
// Otherwise it's a "tuple":
// 否则它就是一个"元组"：
//
//     const bar = .{10, 20, 30};
//
// The only difference is the destination type.
// 唯一的区别是目标类型。
//
const print = @import("std").debug.print;

pub fn main() void {
    // Please make 'hello' a string-like array of u8 WITHOUT
    // changing the value literal.
    // 请将 'hello' 设为类似字符串的 u8 数组，但不要改变值字面量。
    //
    // Don't change this part:
    // 不要改变这一部分：
    //
    //     = .{ 'h', 'e', 'l', 'l', 'o' };
    //
    const hello = .{ 'h', 'e', 'l', 'l', 'o' };
    print("I say {s}!\n", .{hello});
}
