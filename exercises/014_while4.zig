//
// You can force a loop to exit immediately with a "break" statement:
// 你可以使用 "break" 语句强制循环立即退出：
//
//     while (condition) : (continue expression) {
//
//         if (other condition) break;
//
//     }
//
// Continue expressions do NOT execute when a while loop stops
// because of a break!
// 当 while 循环因为 break 而停止时，Continue 表达式不会执行！
//
const std = @import("std");

pub fn main() void {
    var n: u32 = 1;

    // Oh dear! This while loop will go forever?!
    // Please fix this so the print statement below gives the desired output.
    // 天哪！这个 while 循环会永远运行下去吗？！
    // 请修复这个问题，使下面的打印语句给出所需的输出。
    while (true) : (n += 1) {
        if (???) ???;
    }

    // Result: we want n=4
    // 结果：我们希望 n=4
    std.debug.print("n={}\n", .{n});
}
