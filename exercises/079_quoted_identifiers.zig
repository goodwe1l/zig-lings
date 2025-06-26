//
// Sometimes you need to create an identifier that will not, for
// whatever reason, play by the naming rules:
// 有时您需要创建一个标识符，无论出于何种原因，它不会遵循命名规则：
//
//     const 55_cows: i32 = 55; // ILLEGAL: starts with a number
//     const 55_cows: i32 = 55; // 非法：以数字开头
//     const isn't true: bool = false; // ILLEGAL: what even?!
//     const isn't true: bool = false; // 非法：这什么鬼？！
//
// If you try to create either of these under normal
// circumstances, a special Program Identifier Syntax Security
// Team (PISST) will come to your house and take you away.
// 如果您在正常情况下尝试创建其中任何一个，程序标识符语法安全团队（PISST）
// 将来到您家并将您带走。
//
// Thankfully, Zig has a way to sneak these wacky identifiers
// past the authorities: the @"" identifier quoting syntax.
// 谢天谢地，Zig 有一种方法可以让这些古怪的标识符溜过当局：@"" 标识符引用语法。
//
//     @"foo"
//
// Please help us safely smuggle these fugitive identifiers into
// our program:
// 请帮助我们安全地将这些逃犯标识符走私到我们的程序中：
//
const print = @import("std").debug.print;

pub fn main() void {
    const 55_cows: i32 = 55;
    const isn't true: bool = false;

    print("Sweet freedom: {}, {}.\n", .{
        55_cows,
        isn't true,
    });
}
