//
// You can also make pointers to multiple items without using a slice.
// 你也可以在不使用切片的情况下创建指向多个项目的指针。
//
//     var foo: [4]u8 = [4]u8{ 1, 2, 3, 4 };
//     var foo_slice: []u8 = foo[0..];
//     var foo_ptr: [*]u8 = &foo;
//     var foo_slice_from_ptr: []u8 = foo_ptr[0..4];
//
// The difference between foo_slice and foo_ptr is that the slice has
// foo_slice和foo_ptr之间的区别是切片有
// a known length. The pointer doesn't. It is up to YOU to keep track
// 已知长度。指针没有。你需要自己跟踪
// of the number of u8s foo_ptr points to!
// foo_ptr指向的u8数量！
//
const std = @import("std");

pub fn main() void {
    // Take a good look at the array type to which we're coercing
    // 仔细看看我们将zen12字符串强制转换为的数组类型
    // the zen12 string (the REAL nature of strings will be
    // （字符串的真实本质将在我们学习一些
    // revealed when we've learned some additional features):
    // 额外特性后揭示）：
    const zen12: *const [21]u8 = "Memory is a resource.";
    //
    //   It would also have been valid to coerce to a slice:
    //   强制转换为切片也是有效的：
    //         const zen12: []const u8 = "...";
    //
    // Now let's turn this into a "many-item pointer":
    // 现在让我们将其转换为"多项指针"：
    const zen_manyptr: [*]const u8 = zen12;

    // It's okay to access zen_manyptr just like an array or slice as
    // 只要你自己跟踪长度，就可以像数组或切片一样
    // long as you keep track of the length yourself!
    // 访问zen_manyptr！
    //
    // A "string" in Zig is a pointer to an array of const u8 values
    // Zig中的"字符串"是指向const u8值数组的指针
    // (or a slice of const u8 values, as we saw above). So, we could
    // （或者如我们上面看到的const u8值的切片）。所以，我们可以
    // treat a "many-item pointer" of const u8 as a string as long as
    // 将const u8的"多项指针"视为字符串，只要
    // we can CONVERT IT TO A SLICE. (Hint: we do know the length!)
    // 我们可以将其转换为切片。（提示：我们确实知道长度！）
    //
    // Please fix this line so the print statement below can print it:
    // 请修复这一行，以便下面的print语句可以打印它：
    const zen12_string: []const u8 = zen_manyptr;

    // Here's the moment of truth!
    // 关键时刻到了！
    std.debug.print("{s}\n", .{zen12_string});
}
//
// Are all of these pointer types starting to get confusing?
// 所有这些指针类型开始让人困惑了吗？
//
//     FREE ZIG POINTER CHEATSHEET! (Using u8 as the example type.)
//     免费Zig指针备忘单！（使用u8作为示例类型。）
//   +---------------+----------------------------------------------+
//   |  u8           |  one u8                                      |
//   |  u8           |  一个u8                                      |
//   |  *u8          |  pointer to one u8                           |
//   |  *u8          |  指向一个u8的指针                             |
//   |  [2]u8        |  two u8s                                     |
//   |  [2]u8        |  两个u8                                      |
//   |  [*]u8        |  pointer to unknown number of u8s            |
//   |  [*]u8        |  指向未知数量u8的指针                         |
//   |  [*]const u8  |  pointer to unknown number of immutable u8s  |
//   |  [*]const u8  |  指向未知数量不可变u8的指针                   |
//   |  *[2]u8       |  pointer to an array of 2 u8s                |
//   |  *[2]u8       |  指向2个u8数组的指针                          |
//   |  *const [2]u8 |  pointer to an immutable array of 2 u8s      |
//   |  *const [2]u8 |  指向2个不可变u8数组的指针                    |
//   |  []u8         |  slice of u8s                                |
//   |  []u8         |  u8切片                                      |
//   |  []const u8   |  slice of immutable u8s                      |
//   |  []const u8   |  不可变u8切片                                |
//   +---------------+----------------------------------------------+
