//
// We were able to get a printable string out of a many-item
// pointer by using a slice to assert a specific length.
// 我们能够通过使用切片来断言特定长度，从多项指针中获得可打印的字符串。
//
// But can we ever GO BACK to a sentinel-terminated pointer
// after we've "lost" the sentinel in a coercion?
// 但是在我们在强制转换中"丢失"哨兵后，我们能否回到哨兵终止指针？
//
// Yes, we can. Zig's @ptrCast() builtin can do this. Check out
// the signature:
// 是的，我们可以。Zig 的 @ptrCast() 内置函数可以做到这一点。查看签名：
//
//     @ptrCast(value: anytype) anytype
//
// See if you can use it to solve the same many-item pointer
// problem, but without needing a length!
// 看看您是否可以使用它来解决相同的多项指针问题，但不需要长度！
//
const print = @import("std").debug.print;

pub fn main() void {
    // Again, we've coerced the sentinel-terminated string to a
    // many-item pointer, which has no length or sentinel.
    // 再次，我们将哨兵终止的字符串强制转换为多项指针，它没有长度或哨兵。
    const data: [*]const u8 = "Weird Data!";

    // Please cast 'data' to 'printable':
    // 请将 'data' 转换为 'printable'：
    const printable: [*:0]const u8 = ???;

    print("{s}\n", .{printable});
}
