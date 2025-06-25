//
// "Compile time" is a program's environment while it is being
// compiled. In contrast, "run time" is the environment while the
// compiled program is executing (traditionally as machine code
// on a hardware CPU).
// "编译时" 是程序被编译时的环境。相比之下，"运行时" 是编译后的程序
// 执行时的环境（传统上是在硬件CPU上运行的机器代码）。
//
// Errors make an easy example:
// 错误提供了一个简单的例子：
//
// 1. Compile-time error: caught by the compiler, usually
//    resulting in a message to the programmer.
// 1. 编译时错误：被编译器捕获，通常会向程序员显示错误消息。
//
// 2. Runtime error: either caught by the running program itself
//    or by the host hardware or operating system. Could be
//    gracefully caught and handled or could cause the computer
//    to crash (or halt and catch fire)!
// 2. 运行时错误：要么被运行中的程序本身捕获，要么被主机硬件或操作系统捕获。
//    可以被优雅地捕获和处理，也可能导致计算机崩溃（或停机着火）！
//
// All compiled languages must perform a certain amount of logic
// at compile time in order to analyze the code, maintain a table
// of symbols (such as variable and function names), etc.
// 所有编译型语言都必须在编译时执行一定量的逻辑，以分析代码、
// 维护符号表（如变量名和函数名）等。
//
// Optimizing compilers can also figure out how much of a program
// can be pre-computed or "inlined" at compile time to make the
// resulting program more efficient. Smart compilers can even
// "unroll" loops, turning their logic into a fast linear
// sequence of statements (at the usually very slight expense of
// the increased size of the repeated code).
// 优化编译器还可以确定程序的多少部分可以在编译时预计算或"内联"，
// 以使生成的程序更高效。智能编译器甚至可以"展开"循环，将其逻辑转换为
// 快速的线性语句序列（通常以略微增加重复代码大小为代价）。
//
// Zig takes these concepts further by making these optimizations
// an integral part of the language itself!
// Zig 通过将这些优化作为语言本身的组成部分，进一步发展了这些概念！
//
const print = @import("std").debug.print;

pub fn main() void {
    // ALL numeric literals in Zig are of type comptime_int or
    // comptime_float. They are of arbitrary size (as big or
    // little as you need).
    // Zig 中所有的数字字面量都是 comptime_int 或 comptime_float 类型。
    // 它们是任意大小的（根据需要可以很大或很小）。
    //
    // Notice how we don't have to specify a size like "u8",
    // "i32", or "f64" when we assign identifiers immutably with
    // "const".
    // 注意当我们使用 "const" 不可变地分配标识符时，不需要指定像 "u8"、
    // "i32" 或 "f64" 这样的大小。
    //
    // When we use these identifiers in our program, the VALUES
    // are inserted at compile time into the executable code. The
    // IDENTIFIERS "const_int" and "const_float" don't exist in
    // our compiled application!
    // 当我们在程序中使用这些标识符时，其值在编译时被插入到可执行代码中。
    // 标识符 "const_int" 和 "const_float" 在编译后的应用程序中并不存在！
    const const_int = 12345;
    const const_float = 987.654;

    print("Immutable: {}, {d:.3}; ", .{ const_int, const_float });

    // But something changes when we assign the exact same values
    // to identifiers mutably with "var".
    // 但是当我们使用 "var" 可变地将相同的值分配给标识符时，情况就不同了。
    //
    // The literals are STILL comptime_int and comptime_float,
    // but we wish to assign them to identifiers which are
    // mutable at runtime.
    // 字面量仍然是 comptime_int 和 comptime_float，但我们希望将它们分配给
    // 在运行时可变的标识符。
    //
    // To be mutable at runtime, these identifiers must refer to
    // areas of memory. In order to refer to areas of memory, Zig
    // must know exactly how much memory to reserve for these
    // values. Therefore, it follows that we just specify numeric
    // types with specific sizes. The comptime numbers will be
    // coerced (if they'll fit!) into your chosen runtime types.
    // For this it is necessary to specify a size, e.g. 32 bit.
    // 要在运行时可变，这些标识符必须引用内存区域。为了引用内存区域，
    // Zig 必须准确知道为这些值保留多少内存。因此，我们需要指定具有特定大小的
    // 数字类型。编译时数字将被强制转换（如果能容纳的话！）为您选择的运行时类型。
    // 为此，需要指定一个大小，例如 32 位。
    var var_int = 12345;
    var var_float = 987.654;

    // We can change what is stored at the areas set aside for
    // "var_int" and "var_float" in the running compiled program.
    // 我们可以在运行的编译程序中更改为 "var_int" 和 "var_float" 预留的区域中存储的内容。
    var_int = 54321;
    var_float = 456.789;

    print("Mutable: {}, {d:.3}; ", .{ var_int, var_float });

    // Bonus: Now that we're familiar with Zig's builtins, we can
    // also inspect the types to see what they are, no guessing
    // needed!
    // 奖励：现在我们熟悉了 Zig 的内置函数，我们还可以检查类型来查看它们是什么，
    // 无需猜测！
    print("Types: {}, {}, {}, {}\n", .{
        @TypeOf(const_int),
        @TypeOf(const_float),
        @TypeOf(var_int),
        @TypeOf(var_float),
    });
}
