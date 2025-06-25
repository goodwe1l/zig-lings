//
// Believe it or not, sometimes things go wrong in programs.
//
// In Zig, an error is a value. Errors are named so we can identify
// things that can go wrong. Errors are created in "error sets", which
// are just a collection of named errors.
//
// We have the start of an error set, but we're missing the condition
// "TooSmall". Please add it where needed!
// 信不信由你，有时程序会出错。
//
// 在 Zig 中，错误是一个值。错误被命名，这样我们就可以识别
// 可能出错的事情。错误在"错误集"中创建，
// 这只是一个命名错误的集合。
//
// 我们有一个错误集的开始，但我们缺少条件 "TooSmall"。
// 请在需要的地方添加它！
const MyNumberError = error{
    TooBig,
    ???,
    TooFour,
};

const std = @import("std");

pub fn main() void {
    const nums = [_]u8{ 2, 3, 4, 5, 6 };

    for (nums) |n| {
        std.debug.print("{}", .{n});

        const number_error = numberFail(n);

        if (number_error == MyNumberError.TooBig) {
            std.debug.print(">4. ", .{});
        }
        if (???) {
            std.debug.print("<4. ", .{});
        }
        if (number_error == MyNumberError.TooFour) {
            std.debug.print("=4. ", .{});
        }
    }

    std.debug.print("\n", .{});
}

// Notice how this function can return any member of the MyNumberError
// error set.
// 注意这个函数如何返回 MyNumberError 错误集的任何成员。
fn numberFail(n: u8) MyNumberError {
    if (n > 4) return MyNumberError.TooBig;
    if (n < 4) return MyNumberError.TooSmall; // <---- this one is free!
    if (n < 4) return MyNumberError.TooSmall; // <---- 这个是免费的！
    return MyNumberError.TooFour;
}
