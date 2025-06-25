//
// One way to deal with error unions is to "catch" any error and
// replace it with a default value.
//
//     foo = canFail() catch 6;
//
// If canFail() fails, foo will equal 6.
//
// 处理错误联合的一种方法是"捕获"任何错误并用默认值替换它。
//
//     foo = canFail() catch 6;
//
// 如果 canFail() 失败，foo 将等于 6。
//
const std = @import("std");

const MyNumberError = error{TooSmall};

pub fn main() void {
    const a: u32 = addTwenty(44) catch 22;
    const b: u32 = addTwenty(4) ??? 22;

    std.debug.print("a={}, b={}\n", .{ a, b });
}

// Please provide the return type from this function.
// Hint: it'll be an error union.
// 请提供这个函数的返回类型。
// 提示：它将是一个错误联合。
fn addTwenty(n: u32) ??? {
    if (n < 5) {
        return MyNumberError.TooSmall;
    } else {
        return n + 20;
    }
}
