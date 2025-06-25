//
// Oh no, this is supposed to print "Hello world!" but it needs
// your help.
// 哦不，这个程序应该打印 "Hello world!"，但它需要你的帮助。
//
// Zig functions are private by default but the main() function
// should be public.
// Zig 函数默认是私有的，但 main() 函数应该是公共的。
//
// A function is made public with the "pub" statement like so:
// 函数可以通过 "pub" 语句变为公共的，如下所示：
//
//     pub fn foo() void {
//         ...
//     }
//
// Perhaps knowing this will help solve the errors we're getting
// with this little program?
// 也许知道这一点能帮助解决我们在这个小程序中遇到的错误？
//
const std = @import("std");

fn main() void {
    std.debug.print("Hello world!\n", .{});
}
