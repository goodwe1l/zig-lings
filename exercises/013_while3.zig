//
// The last two exercises were functionally identical. Continue
// expressions really show their utility when used with 'continue'
// statements!
// 上两个练习在功能上是相同的。Continue 表达式在与 'continue' 
// 语句一起使用时真正显示了它们的实用性！
//
// Example:
// 示例：
//
//     while (condition) : (continue expression) {
//
//         if (other condition) continue;
//
//     }
//
// The "continue expression" executes every time the loop restarts
// whether the "continue" statement happens or not.
// "continue 表达式"在每次循环重新开始时执行，
// 无论是否发生 "continue" 语句。
//
const std = @import("std");

pub fn main() void {
    var n: u32 = 1;

    // I want to print every number between 1 and 20 that is NOT
    // divisible by 3 or 5.
    // 我想打印 1 到 20 之间不能被 3 或 5 整除的每个数字。
    while (n <= 20) : (n += 1) {
        // The '%' symbol is the "modulo" operator and it
        // returns the remainder after division.
        // '%' 符号是"取模"操作符，它返回除法后的余数。
        if (n % 3 == 0) ???;
        if (n % 5 == 0) ???;
        std.debug.print("{} ", .{n});
    }

    std.debug.print("\n", .{});
}
