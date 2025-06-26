//
// Remember how a function with 'suspend' is async and calling an
// async function without the 'async' keyword makes the CALLING
// function async?
// 还记得带有 'suspend' 的函数是异步的，并且在不使用 'async' 关键字的情况下
// 调用异步函数会使调用函数也变成异步的吗？
//
//     fn fooThatMightSuspend(maybe: bool) void {
//         if (maybe) suspend {}
//     }
//
//     fn bar() void {
//         fooThatMightSuspend(true); // Now bar() is async!
//     }
//
// But if you KNOW the function won't suspend, you can make a
// promise to the compiler with the 'nosuspend' keyword:
// 但如果您知道函数不会挂起，您可以使用 'nosuspend' 关键字向编译器做出承诺：
//
//     fn bar() void {
//         nosuspend fooThatMightSuspend(false);
//     }
//
// If the function does suspend and YOUR PROMISE TO THE COMPILER
// IS BROKEN, the program will panic at runtime, which is
// probably better than you deserve, you oathbreaker! >:-(
// 如果函数确实挂起并且您对编译器的承诺被打破，程序将在运行时崩溃，
// 这可能比您应得的更好，您这个背叛者！>:-(
//
const print = @import("std").debug.print;

pub fn main() void {

    // The main() function can not be async. But we know
    // getBeef() will not suspend with this particular
    // invocation. Please make this okay:
    // main() 函数不能是异步的。但我们知道 getBeef() 在这个特定的
    // 调用中不会挂起。请让这个可以正常工作：
    var my_beef = getBeef(0);

    print("beef? {X}!\n", .{my_beef});
}

fn getBeef(input: u32) u32 {
    if (input == 0xDEAD) {
        suspend {}
    }

    return 0xBEEF;
}
//
// Going Deeper Into...
// 深入了解...
//                     ...uNdeFiNEd beHAVi0r!
//                     ...未定义行为！
//
// We haven't discussed it yet, but runtime "safety" features
// require some extra instructions in your compiled program.
// Most of the time, you're going to want to keep these in.
// 我们还没有讨论过，但运行时"安全"功能需要在编译的程序中添加一些额外的指令。
// 大多数时候，您会希望保留这些功能。
//
// But in some programs, when data integrity is less important
// than raw speed (some games, for example), you can compile
// without these safety features.
// 但在某些程序中，当数据完整性不如原始速度重要时（例如某些游戏），
// 您可以在不使用这些安全功能的情况下编译。
//
// Instead of a safe panic when something goes wrong, your
// program will now exhibit Undefined Behavior (UB), which simply
// means that the Zig language does not (cannot) define what will
// happen. The best case is that it will crash, but in the worst
// case, it will continue to run with the wrong results and
// corrupt your data or expose you to security risks.
// 当出现问题时，您的程序不会安全地崩溃，而是会表现出未定义行为 (UB)，
// 这简单地意味着 Zig 语言不能（无法）定义将会发生什么。最好的情况是它会崩溃，
// 但在最坏的情况下，它会以错误的结果继续运行，并损坏您的数据或暴露安全风险。
//
// This program is a great way to explore UB. Once you get it
// working, try calling the getBeef() function with the value
// 0xDEAD so that it will invoke the 'suspend' keyword:
// 这个程序是探索 UB 的好方法。一旦您让它工作，尝试用值 0xDEAD
// 调用 getBeef() 函数，这样它就会调用 'suspend' 关键字：
//
//     getBeef(0xDEAD)
//
// Now when you run the program, it will panic and give you a
// nice stack trace to help debug the problem.
// 现在当您运行程序时，它会崩溃并给您一个漂亮的堆栈跟踪来帮助调试问题。
//
//     zig run exercises/090_async7.zig
//     thread 328 panic: async function called...
//     ...
//
// But see what happens when you turn off safety checks by using
// ReleaseFast mode:
// 但看看当您使用 ReleaseFast 模式关闭安全检查时会发生什么：
//
//     zig run -O ReleaseFast exercises/090_async7.zig
//     beef? 0!
//
// This is the wrong result. On your computer, you may get a
// different answer or it might crash! What exactly will happen
// is UNDEFINED. Your computer is now like a wild animal,
// reacting to bits and bytes of raw memory with the base
// instincts of the CPU. It is both terrifying and exhilarating.
// 这是错误的结果。在您的计算机上，您可能得到不同的答案或它可能崩溃！
// 具体会发生什么是未定义的。您的计算机现在就像一只野生动物，
// 用 CPU 的基本本能对原始内存的位和字节做出反应。这既令人恐惧又令人兴奋。
//
