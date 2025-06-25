//
// Let's revisit the very first error exercise. This time, we're going to
// 让我们重新审视第一个错误练习。这次，我们将
// look at an error-handling variation of the "if" statement.
// 查看"if"语句的错误处理变体。
//
//     if (foo) |value| {
//
//         // foo was NOT an error; value is the non-error value of foo
//         // foo不是错误；value是foo的非错误值
//
//     } else |err| {
//
//         // foo WAS an error; err is the error value of foo
//         // foo是错误；err是foo的错误值
//
//     }
//
// We'll take it even further and use a switch statement to handle
// 我们将更进一步，使用switch语句来处理
// the error types.
// 错误类型。
//
//     if (foo) |value| {
//         ...
//     } else |err| switch (err) {
//         ...
//     }
//
const MyNumberError = error{
    TooBig,
    TooSmall,
};

const std = @import("std");

pub fn main() void {
    const nums = [_]u8{ 2, 3, 4, 5, 6 };

    for (nums) |num| {
        std.debug.print("{}", .{num});

        const n = numberMaybeFail(num);
        if (n) |value| {
            std.debug.print("={}. ", .{value});
        } else |err| switch (err) {
            MyNumberError.TooBig => std.debug.print(">4. ", .{}),
            // Please add a match for TooSmall here and have it print: "<4. "
            // 请在这里为TooSmall添加匹配，并让它打印："<4. "
        }
    }

    std.debug.print("\n", .{});
}

// This time we'll have numberMaybeFail() return an error union rather
// 这次我们让numberMaybeFail()返回一个错误联合而不是
// than a straight error.
// 直接的错误。
fn numberMaybeFail(n: u8) MyNumberError!u8 {
    if (n > 4) return MyNumberError.TooBig;
    if (n < 4) return MyNumberError.TooSmall;
    return n;
}
