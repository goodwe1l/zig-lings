//
// Let's learn some array basics. Arrays are declared with:
// 让我们学习一些数组基础知识。数组的声明方式是：
//
//   var foo: [3]u32 = [3]u32{ 42, 108, 5423 };
//
// When Zig can infer the size of the array, you can use '_' for the
// size. You can also let Zig infer the type of the value so the
// declaration is much less verbose.
// 当 Zig 可以推断数组的大小时，你可以使用 '_' 来表示大小。
// 你也可以让 Zig 推断值的类型，这样声明会更简洁。
//
//   var foo = [_]u32{ 42, 108, 5423 };
//
// Get values of an array using array[index] notation:
// 使用 array[index] 表示法获取数组的值：
//
//     const bar = foo[2]; // 5423
//
// Set values of an array using array[index] notation:
// 使用 array[index] 表示法设置数组的值：
//
//     foo[2] = 16;
//
// Get the length of an array using the len property:
// 使用 len 属性获取数组的长度：
//
//     const length = foo.len;
//
const std = @import("std");

pub fn main() void {
    // (Problem 1)
    // This "const" is going to cause a problem later - can you see what it is?
    // How do we fix it?
    // （问题 1）
    // 这个 "const" 稍后会导致问题 - 你能看出是什么问题吗？
    // 我们如何修复它？
    var some_primes = [_]u8{ 1, 3, 5, 7, 11, 13, 17, 19 };

    // Individual values can be set with '[]' notation.
    // Example: This line changes the first prime to 2 (which is correct):
    // 可以使用 '[]' 表示法设置单个值。
    // 示例：这行代码将第一个质数改为 2（这是正确的）：
    some_primes[0] = 2;

    // Individual values can also be accessed with '[]' notation.
    // Example: This line stores the first prime in "first":
    // 也可以使用 '[]' 表示法访问单个值。
    // 示例：这行代码将第一个质数存储在 "first" 中：
    const first = some_primes[0];

    // (Problem 2)
    // Looks like we need to complete this expression. Use the example
    // above to set "fourth" to the fourth element of the some_primes array:
    // （问题 2）
    // 看起来我们需要完成这个表达式。使用上面的示例将 "fourth"
    // 设置为 some_primes 数组的第四个元素：
    const fourth = some_primes[3];

    // (Problem 3)
    // Use the len property to get the length of the array:
    // （问题 3）
    // 使用 len 属性获取数组的长度：
    const length = some_primes.len;

    std.debug.print("First: {}, Fourth: {}, Length: {}\n", .{
        first, fourth, length,
    });
}
