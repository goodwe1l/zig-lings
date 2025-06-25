//
// Zig 'while' statements create a loop that runs while the
// condition is true. This runs once (at most):
// Zig 的 'while' 语句创建一个在条件为真时运行的循环。
// 这个循环最多运行一次：
//
//     while (condition) {
//         condition = false;
//     }
//
// Remember that the condition must be a boolean value and
// that we can get a boolean value from conditional operators
// such as:
// 记住条件必须是布尔值，我们可以从条件操作符中获得布尔值，
// 比如：
//
//     a == b   means "a equals b"
//     a == b   意思是"a 等于 b"
//     a < b    means "a is less than b"
//     a < b    意思是"a 小于 b"
//     a > b    means "a is greater than b"
//     a > b    意思是"a 大于 b"
//     a != b   means "a does not equal b"
//     a != b   意思是"a 不等于 b"
//
const std = @import("std");

pub fn main() void {
    var n: u32 = 2;

    // Please use a condition that is true UNTIL "n" reaches 1024:
    // 请使用一个条件，该条件为真直到 "n" 达到 1024：
    while (???) {
        // Print the current number
        // 打印当前数字
        std.debug.print("{} ", .{n});

        // Set n to n multiplied by 2
        // 将 n 设置为 n 乘以 2
        n *= 2;
    }

    // Once the above is correct, this will print "n=1024"
    // 一旦上面的代码正确，这将打印 "n=1024"
    std.debug.print("n={}\n", .{n});
}
