//
// For loops also let you use the "index" of the iteration, a number
// that counts up with each iteration. To access the index of iteration,
// specify a second condition as well as a second capture value.
// For 循环还允许你使用迭代的"索引"，这是一个随着每次迭代递增的数字。
// 要访问迭代的索引，需要指定第二个条件以及第二个捕获值。
//
//     for (items, 0..) |item, index| {
//
//         // Do something with item and index
//         // 对 item 和 index 做一些操作
//
//     }
//
// You can name "item" and "index" anything you want. "i" is a popular
// shortening of "index". The item name is often the singular form of
// the items you're looping through.
// 你可以给 "item" 和 "index" 起任何你想要的名字。"i" 是 "index" 的常用缩写。
// item 名称通常是你要循环遍历的项目的单数形式。
//
const std = @import("std");

pub fn main() void {
    // Let's store the bits of binary number 1101 in
    // 'little-endian' order (least significant byte or bit first):
    // 让我们以'小端序'顺序存储二进制数 1101 的位
    //（最低有效字节或位在前）：
    const bits = [_]u8{ 1, 0, 1, 1 };
    var value: u32 = 0;

    // Now we'll convert the binary bits to a number value by adding
    // the value of the place as a power of two for each bit.
    //
    // See if you can figure out the missing pieces:
    // 现在我们将通过为每个位添加位置值作为 2 的幂来
    // 将二进制位转换为数值。
    //
    // 看看你能否找出缺失的部分：
    for (bits, ???) |bit, ???| {
        // Note that we convert the usize i to a u32 with
        // @intCast(), a builtin function just like @import().
        // We'll learn about these properly in a later exercise.
        // 注意我们使用 @intCast() 将 usize i 转换为 u32，
        // 这是一个像 @import() 一样的内置函数。
        // 我们将在稍后的练习中正确学习这些。
        const i_u32: u32 = @intCast(i);
        const place_value = std.math.pow(u32, 2, i_u32);
        value += place_value * bit;
    }

    std.debug.print("The value of bits '1101': {}.\n", .{value});
}
//
// As mentioned in the previous exercise, 'for' loops have gained
// additional flexibility since these early exercises were
// written. As we'll see in later exercises, the above syntax for
// capturing the index is part of a more general ability. Hang in
// there!
// 如前一个练习中提到的，自从这些早期练习编写以来，
// 'for' 循环已经获得了额外的灵活性。正如我们将在后续练习中看到的，
// 上述捕获索引的语法是一种更通用能力的一部分。坚持下去！
