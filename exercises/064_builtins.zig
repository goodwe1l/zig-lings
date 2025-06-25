//
// The Zig compiler provides "builtin" functions. You've already
// Zig编译器提供"内置"函数。你已经
// gotten used to seeing an @import() at the top of every
// 习惯了在每个Ziglings练习的顶部看到@import()。
// Ziglings exercise.
//
// We've also seen @intCast() in "016_for2.zig", "058_quiz7.zig";
// 我们也在"016_for2.zig"、"058_quiz7.zig"中看到了@intCast()；
// and @intFromEnum() in "036_enums2.zig".
// 在"036_enums2.zig"中看到了@intFromEnum()。
//
// Builtins are special because they are intrinsic to the Zig
// 内置函数很特殊，因为它们是Zig语言本身固有的
// language itself (as opposed to being provided in the standard
// （而不是在标准库中提供）。它们也很特殊，
// library). They are also special because they can provide
// 因为它们可以提供只有在编译器帮助下才能实现的
// functionality that is only possible with help from the
// 功能，比如类型内省（在程序中检查类型属性的能力）。
// compiler, such as type introspection (the ability to examine
// type properties from within a program).
//
// Zig contains over 100 builtin functions. We're certainly
// Zig包含100多个内置函数。我们当然
// not going to cover them all, but we can look at some
// 不会涵盖所有这些，但我们可以看一些
// interesting ones.
// 有趣的。
//
// Before we begin, know that many builtin functions have
// 在我们开始之前，要知道许多内置函数有
// parameters marked as "comptime". It's probably fairly clear
// 标记为"comptime"的参数。当我们说这些参数需要
// what we mean when we say that these parameters need to be
// "在编译时已知"时，意思可能相当清楚。
// "known at compile time." But rest assured we'll be doing the
// 但请放心，我们很快就会真正公正地对待
// "comptime" subject real justice soon.
// "comptime"这个主题。
//
const print = @import("std").debug.print;

pub fn main() void {
    // The second builtin, alphabetically, is:
    // 按字母顺序排列的第二个内置函数是：
    //   @addWithOverflow(a: anytype, b: anytype) struct { @TypeOf(a, b), u1 }
    //     * 'a' and 'b' are numbers of anytype.
    //     * 'a'和'b'是anytype的数字。
    //     * The return value is a tuple with the result and a possible overflow bit.
    //     * 返回值是一个包含结果和可能的溢出位的元组。
    //
    // Let's try it with a tiny 4-bit integer size to make it clear:
    // 让我们用一个小的4位整数大小来试试，以使其清楚：
    const a: u4 = 0b1101;
    const b: u4 = 0b0101;
    const my_result = @addWithOverflow(a, b);

    // Check out our fancy formatting! b:0>4 means, "print
    // 看看我们花哨的格式化！b:0>4意思是，"打印为
    // as a binary number, zero-pad right-aligned four digits."
    // 二进制数，零填充右对齐四位数。"
    // The print() below will produce: "1101 + 0101 = 0010 (true)".
    // 下面的print()将产生："1101 + 0101 = 0010 (true)"。
    print("{b:0>4} + {b:0>4} = {b:0>4} ({s})", .{ a, b, my_result[0], if (my_result[1] == 1) "true" else "false" });

    // Let's make sense of this answer. The value of 'b' in decimal is 5.
    // 让我们理解这个答案。'b'的十进制值是5。
    // Let's add 5 to 'a' but go one by one and see where it overflows:
    // 让我们将5加到'a'上，但一步一步地看它在哪里溢出：
    //
    //   a  |  b   | result | overflowed?
    //   a  |  b   | result | overflowed?
    // ----------------------------------
    // 1101 + 0001 =  1110  | false
    // 1110 + 0001 =  1111  | false
    // 1111 + 0001 =  0000  | true  (the real answer is 10000)
    // 1111 + 0001 =  0000  | true  (真正的答案是10000)
    // 0000 + 0001 =  0001  | false
    // 0001 + 0001 =  0010  | false
    //
    // In the last two lines the value of 'a' is corrupted because there was
    // 在最后两行中，'a'的值被破坏了，因为第3行有
    // an overflow in line 3, but the operations of lines 4 and 5 themselves
    // 溢出，但第4行和第5行的操作本身
    // do not overflow.
    // 并没有溢出。
    // There is a difference between
    // 有一个区别：
    //  - a value, that overflowed at some point and is now corrupted
    //  - 一个在某个时刻溢出现在已损坏的值
    //  - a single operation that overflows and maybe causes subsequent errors
    //  - 一个溢出并可能导致后续错误的单个操作
    // In practice we usually notice the overflowed value first and have to work
    // 在实践中，我们通常首先注意到溢出的值，然后必须
    // our way backwards to the operation that caused the overflow.
    // 逆向工作到导致溢出的操作。
    //
    // If there was no overflow at all while adding 5 to a, what value would
    // 如果在将5加到a时完全没有溢出，
    // 'my_result' hold? Write the answer in into 'expected_result'.
    // 'my_result'会保存什么值？将答案写入'expected_result'。
    const expected_result: u8 = ???;
    print(". Without overflow: {b:0>8}. ", .{expected_result});

    print("Furthermore, ", .{});

    // Here's a fun one:
    //
    //   @bitReverse(integer: anytype) T
    //     * 'integer' is the value to reverse.
    //     * The return value will be the same type with the
    //       value's bits reversed!
    //
    // Now it's your turn. See if you can fix this attempt to use
    // this builtin to reverse the bits of a u8 integer.
    const input: u8 = 0b11110000;
    const tupni: u8 = @bitReverse(input, tupni);
    print("{b:0>8} backwards is {b:0>8}.\n", .{ input, tupni });
}
