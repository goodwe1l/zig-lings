//
// Zig 'while' statements can have an optional 'continue expression'
// which runs every time the while loop continues (either at the
// end of the loop or when an explicit 'continue' is invoked - we'll
// try those out next):
// Zig 的 'while' 语句可以有一个可选的 'continue 表达式'，
// 它在 while 循环每次继续时运行（无论是在循环结束时
// 还是调用显式 'continue' 时 - 我们接下来会尝试）：
//
//     while (condition) : (continue expression) {
//         ...
//     }
//
// Example:
// 示例：
//
//     var foo = 2;
//     while (foo < 10) : (foo += 2) {
//         // Do something with even numbers less than 10...
//         // 对小于 10 的偶数做一些操作...
//     }
//
// See if you can re-write the last exercise using a continue
// expression:
// 看看你能否使用 continue 表达式重写上一个练习：
//
const std = @import("std");

pub fn main() void {
    var n: u32 = 2;

    // Please set the continue expression so that we get the desired
    // results in the print statement below.
    // 请设置 continue 表达式，以便我们在下面的打印语句中获得所需的结果。
    while (n < 1000) : ??? {
        // Print the current number
        // 打印当前数字
        std.debug.print("{} ", .{n});
    }

    // As in the last exercise, we want this to result in "n=1024"
    // 与上一个练习一样，我们希望结果是 "n=1024"
    std.debug.print("n={}\n", .{n});
}
