//
// One of the more common uses of 'comptime' function parameters is
// passing a type to a function:
// 'comptime' 函数参数的一个更常见用途是将类型传递给函数：
//
//     fn foo(comptime MyType: type) void { ... }
//
// In fact, types are ONLY available at compile time, so the
// 'comptime' keyword is required here.
// 实际上，类型只在编译时可用，所以这里需要 'comptime' 关键字。
//
// Please take a moment to put on the wizard hat which has been
// provided for you. We're about to use this ability to implement
// a generic function.
// 请花一点时间戴上为您提供的巫师帽。我们即将使用这种能力来实现一个通用函数。
//
const print = @import("std").debug.print;

pub fn main() void {
    // Here we declare arrays of three different types and sizes
    // at compile time from a function call. Neat!
    // 这里我们在编译时从函数调用中声明三种不同类型和大小的数组。很棒！
    const s1 = makeSequence(u8, 3); // creates a [3]u8
    const s2 = makeSequence(u32, 5); // creates a [5]u32
    const s3 = makeSequence(i64, 7); // creates a [7]i64

    print("s1={any}, s2={any}, s3={any}\n", .{ s1, s2, s3 });
}

// This function is pretty wild because it executes at runtime
// and is part of the final compiled program. The function is
// compiled with unchanging data sizes and types.
// 这个函数相当奇妙，因为它在运行时执行，并且是最终编译程序的一部分。
// 该函数使用不变的数据大小和类型进行编译。
//
// And yet it ALSO allows for different sizes and types. This
// seems paradoxical. How could both things be true?
// 然而它也允许不同的大小和类型。这似乎矛盾。怎么可能两件事都是真的？
//
// To accomplish this, the Zig compiler actually generates a
// separate copy of the function for every size/type combination!
// So in this case, three different functions will be generated
// for you, each with machine code that handles that specific
// data size and type.
// 为了实现这一点，Zig 编译器实际上为每个大小/类型组合生成函数的单独副本！
// 所以在这种情况下，将为您生成三个不同的函数，每个函数都有处理特定数据大小和类型的机器代码。
//
// Please fix this function so that the 'size' parameter:
// 请修复这个函数，使 'size' 参数：
//
//     1) Is guaranteed to be known at compile time.
//     1) 保证在编译时已知。
//     2) Sets the size of the array of type T (which is the
//        sequence we're creating and returning).
//     2) 设置类型为 T 的数组大小（这是我们正在创建和返回的序列）。
//
fn makeSequence(comptime T: type, ??? size: usize) [???]T {
    var sequence: [???]T = undefined;
    var i: usize = 0;

    while (i < size) : (i += 1) {
        sequence[i] = @as(T, @intCast(i)) + 1;
    }

    return sequence;
}
