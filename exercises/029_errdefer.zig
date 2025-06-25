//
// Another common problem is a block of code that could exit in multiple
// 另一个常见问题是一个代码块可能在多个地方退出
// places due to an error - but that needs to do something before it
// 由于错误——但需要在退出前做一些事情
// exits (typically to clean up after itself).
// （通常是清理工作）。
//
// An "errdefer" is a defer that only runs if the block exits with an error:
// "errdefer"是一个只有在代码块因错误退出时才运行的defer：
//
//     {
//         errdefer cleanup();
//         try canFail();
//     }
//
// The cleanup() function is called ONLY if the "try" statement returns an
// cleanup()函数只有在"try"语句返回一个
// error produced by canFail().
// 由canFail()产生的错误时才会被调用。
//
const std = @import("std");

var counter: u32 = 0;

const MyErr = error{ GetFail, IncFail };

pub fn main() void {
    // We simply quit the entire program if we fail to get a number:
    // 如果我们无法获取数字，我们就直接退出整个程序：
    const a: u32 = makeNumber() catch return;
    const b: u32 = makeNumber() catch return;

    std.debug.print("Numbers: {}, {}\n", .{ a, b });
}

fn makeNumber() MyErr!u32 {
    std.debug.print("Getting number...", .{});

    // Please make the "failed" message print ONLY if the makeNumber()
    // 请让"failed"消息只有在makeNumber()
    // function exits with an error:
    // 函数因错误退出时才打印：
    std.debug.print("failed!\n", .{});

    var num = try getNumber(); // <-- This could fail!
    // <-- 这可能会失败！

    num = try increaseNumber(num); // <-- This could ALSO fail!
    // <-- 这也可能失败！

    std.debug.print("got {}. ", .{num});

    return num;
}

fn getNumber() MyErr!u32 {
    // I _could_ fail...but I don't!
    // 我可能会失败...但我不会！
    return 4;
}

fn increaseNumber(n: u32) MyErr!u32 {
    // I fail after the first time you run me!
    // 我在第一次运行后就会失败！
    if (counter > 0) return MyErr.IncFail;

    // Sneaky, weird global stuff.
    // 狡猾的、奇怪的全局变量操作。
    counter += 1;

    return n + 1;
}
