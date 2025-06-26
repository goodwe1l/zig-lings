//
// ------------------------------------------------------------
//  TOP SECRET  TOP SECRET  TOP SECRET  TOP SECRET  TOP SECRET
//  绝密        绝密        绝密        绝密        绝密
// ------------------------------------------------------------
//
// Are you ready for the THE TRUTH about Zig string literals?
// 您准备好了解关于 Zig 字符串字面量的真相了吗？
//
// Here it is:
// 就是这样：
//
//     @TypeOf("foo") == *const [3:0]u8
//
// Which means a string literal is a "constant pointer to a
// zero-terminated (null-terminated) fixed-size array of u8".
// 这意味着字符串字面量是"指向零终止（空终止）固定大小 u8 数组的常量指针"。
//
// Now you know. You've earned it. Welcome to the secret club!
// 现在您知道了。您赢得了它。欢迎加入秘密俱乐部！
//
// ------------------------------------------------------------
//
// Why do we bother using a zero/null sentinel to terminate
// strings in Zig when we already have a known length?
// 当我们已经有已知长度时，为什么我们要费心在 Zig 中使用零/空哨兵来终止字符串？
//
// Versatility! Zig strings are compatible with C strings (which
// are null-terminated) AND can be coerced to a variety of other
// Zig types:
// 多功能性！Zig 字符串与 C 字符串（空终止）兼容，并且可以强制转换为各种其他 Zig 类型：
//
//     const a: [5]u8 = "array".*;
//     const b: *const [16]u8 = "pointer to array";
//     const c: []const u8 = "slice";
//     const d: [:0]const u8 = "slice with sentinel";
//     const e: [*:0]const u8 = "many-item pointer with sentinel";
//     const f: [*]const u8 = "many-item pointer";
//
// All but 'f' may be printed. (A many-item pointer without a
// sentinel is not safe to print because we don't know where it
// ends!)
// 除了 'f' 之外，所有的都可以打印。（没有哨兵的多项指针不安全打印，因为我们不知道它在哪里结束！）
//
const print = @import("std").debug.print;

const WeirdContainer = struct {
    data: [*]const u8,
    length: usize,
};

pub fn main() void {
    // WeirdContainer is an awkward way to house a string.
    // WeirdContainer 是一种存放字符串的笨拙方式。
    //
    // Being a many-item pointer (with no sentinel termination),
    // the 'data' field "loses" the length information AND the
    // sentinel termination of the string literal "Weird Data!".
    // 作为多项指针（没有哨兵终止），'data' 字段"丢失"了长度信息和
    // 字符串字面量 "Weird Data!" 的哨兵终止。
    //
    // Luckily, the 'length' field makes it possible to still
    // work with this value.
    // 幸运的是，'length' 字段使我们仍然可以使用这个值。
    const foo = WeirdContainer{
        .data = "Weird Data!",
        .length = 11,
    };

    // How do we get a printable value from 'foo'? One way is to
    // turn it into something with a known length. We do have a
    // length... You've actually solved this problem before!
    // 我们如何从 'foo' 获得可打印的值？一种方法是将其转换为具有已知长度的东西。
    // 我们确实有长度...您实际上以前解决过这个问题！
    //
    // Here's a big hint: do you remember how to take a slice?
    // 这是一个大提示：您还记得如何取切片吗？
    const printable = ???;

    print("{s}\n", .{printable});
}
