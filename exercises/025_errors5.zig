//
// Zig has a handy "try" shortcut for this common error handling pattern:
// Zig为这种常见的错误处理模式提供了一个方便的"try"快捷方式：
//
//     canFail() catch |err| return err;
//
// which can be more compactly written as:
// 可以更简洁地写成：
//
//     try canFail();
//
const std = @import("std");

const MyNumberError = error{
    TooSmall,
    TooBig,
};

pub fn main() void {
    const a: u32 = addFive(44) catch 0;
    const b: u32 = addFive(14) catch 0;
    const c: u32 = addFive(4) catch 0;

    std.debug.print("a={}, b={}, c={}\n", .{ a, b, c });
}

fn addFive(n: u32) MyNumberError!u32 {
    // This function needs to return any error which might come back from detect().
    // 这个函数需要返回任何可能从detect()函数返回的错误。
    // Please use a "try" statement rather than a "catch".
    // 请使用"try"语句而不是"catch"。
    //
    const x = detect(n);

    return x + 5;
}

fn detect(n: u32) MyNumberError!u32 {
    if (n < 10) return MyNumberError.TooSmall;
    if (n > 20) return MyNumberError.TooBig;
    return n;
}
