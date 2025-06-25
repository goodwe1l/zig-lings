//
// We've seen that Zig implicitly performs some evaluations at
// compile time. But sometimes you'll want to explicitly request
// compile time evaluation. For that, we have a new keyword:
// 我们已经看到 Zig 隐式地在编译时执行一些计算。但有时您会希望
// 显式地请求编译时计算。为此，我们有一个新关键字：
//
//  .     .   .      o       .          .       *  . .     .
//    .  *  |     .    .            .   .     .   .     * .    .
//        --o--            comptime        *    |      ..    .
//     *    |       *  .        .    .   .    --*--  .     *  .
//  .     .    .    .   . . .      .        .   |   .    .  .
//
// When placed before a variable declaration, 'comptime'
// guarantees that every usage of that variable will be performed
// at compile time.
// 当放置在变量声明之前时，'comptime' 保证该变量的每次使用都将在编译时执行。
//
// As a simple example, compare these two statements:
// 作为一个简单的例子，比较这两个语句：
//
//    var bar1 = 5;            // ERROR!
//    comptime var bar2 = 5;   // OKAY!
//
// The first one gives us an error because Zig assumes mutable
// identifiers (declared with 'var') will be used at runtime and
// we have not assigned a runtime type (like u8 or f32). Trying
// to use a comptime_int of undetermined size at runtime is
// a MEMORY CRIME and you are UNDER ARREST.
// 第一个会报错，因为 Zig 假设可变标识符（用 'var' 声明）将在运行时使用，
// 而我们没有分配运行时类型（如 u8 或 f32）。试图在运行时使用未确定大小的
// comptime_int 是内存犯罪，您被逮捕了。
//
// The second one is okay because we've told Zig that 'bar2' is
// a compile time variable. Zig will help us ensure this is true
// and let us know if we make a mistake.
// 第二个是可以的，因为我们告诉 Zig 'bar2' 是一个编译时变量。
// Zig 将帮助我们确保这是正确的，如果我们犯错，它将让我们知道。
//
const print = @import("std").debug.print;

pub fn main() void {
    //
    // In this contrived example, we've decided to allocate some
    // arrays using a variable count! But something's missing...
    // 在这个人为设计的例子中，我们决定使用一个变量计数来分配一些数组！
    // 但缺少了什么...
    //
    var count = 0;

    count += 1;
    const a1: [count]u8 = .{'A'} ** count;

    count += 1;
    const a2: [count]u8 = .{'B'} ** count;

    count += 1;
    const a3: [count]u8 = .{'C'} ** count;

    count += 1;
    const a4: [count]u8 = .{'D'} ** count;

    print("{s} {s} {s} {s}\n", .{ a1, a2, a3, a4 });

    // Builtin BONUS!
    // 内置函数奖励！
    //
    // The @compileLog() builtin is like a print statement that
    // ONLY operates at compile time. The Zig compiler treats
    // @compileLog() calls as errors, so you'll want to use them
    // temporarily to debug compile time logic.
    // @compileLog() 内置函数就像一个仅在编译时操作的 print 语句。
    // Zig 编译器将 @compileLog() 调用视为错误，所以您会想要临时使用它们来调试编译时逻辑。
    //
    // Try uncommenting this line and playing around with it
    // (copy it, move it) to see what it does:
    // 尝试取消注释这一行并使用它（复制它，移动它）来看看它做什么：
    //@compileLog("Count at compile time: ", count);
}
