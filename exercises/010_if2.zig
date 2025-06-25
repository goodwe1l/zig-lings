//
// If statements are also valid expressions:
// If 语句也是有效的表达式：
//
//     const foo: u8 = if (a) 2 else 3;
//
const std = @import("std");

pub fn main() void {
    const discount = true;

    // Please use an if...else expression to set "price".
    // If discount is true, the price should be $17, otherwise $20:
    // 请使用 if...else 表达式来设置 "price"。
    // 如果 discount 为 true，价格应该是 $17，否则 $20：
    const price: u8 = if ???;

    std.debug.print("With the discount, the price is ${}.\n", .{price});
}
