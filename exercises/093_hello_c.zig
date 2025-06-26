//
// When Andrew Kelley announced the idea of a new programming language
// - namely Zig - in his blog on February 8, 2016, he also immediately
// stated his ambitious goal: to replace the C language!
// 当 Andrew Kelley 在 2016 年 2 月 8 日的博客中宣布新编程语言
// ——即 Zig——的想法时，他也立即陈述了他的雄心勃勃的目标：取代 C 语言！
//
// In order to be able to achieve this goal at all, Zig should be
// as compatible as possible with its "predecessor".
// Only if it is possible to exchange individual modules in existing
// C programs without having to use complicated wrappers,
// the undertaking has a chance of success.
// 为了能够实现这个目标，Zig 应该与其"前身"尽可能兼容。
// 只有在可能在现有 C 程序中交换单个模块而不必使用复杂的包装器的情况下，
// 这项事业才有成功的机会。
//
// So it is not surprising that calling C functions and vice versa
// is extremely "smooth".
// 因此，调用 C 函数以及反之亦然是极其"流畅的"，这并不令人惊讶。
//
// To call C functions in Zig, you only need to specify the library
// that contains said function. For this purpose there is a built-in
// function corresponding to the well-known @import():
// 要在 Zig 中调用 C 函数，您只需指定包含该函数的库。
// 为此，有一个对应于著名的 @import() 的内置函数：
//
//                           @cImport()
//
// All required libraries can now be included in the usual Zig notation:
// 现在可以用通常的 Zig 表示法包含所有必需的库：
//
//                    const c = @cImport({
//                        @cInclude("stdio.h");
//                        @cInclude("...");
//                    });
//
// Now a function can be called via the (in this example) constant 'c':
// 现在可以通过（在此示例中）常量 'c' 调用函数：
//
//                    c.puts("Hello world!");
//
// By the way, most C functions have return values in the form of an
// integer value. Errors can then be evaluated (return < 0) or other
// information can be obtained. For example, 'puts' returns the number
// of characters output.
// 顺便说一下，大多数 C 函数都有整数值形式的返回值。然后可以评估错误（return < 0）
// 或获取其他信息。例如，'puts' 返回输出的字符数。
//
// So that all this does not remain a dry theory now, let's just start
// and call a C function out of Zig.
// 为了让这一切不仅仅停留在枯燥的理论上，现在让我们开始从 Zig 中调用 C 函数。

// our well-known "import" for Zig
// 我们熟知的 Zig "import"
const std = @import("std");

// and here the new import for C
// 这里是新的 C 导入
const c = @cImport({
    @cInclude("unistd.h");
});

pub fn main() void {

    // In order to output text that can be evaluated by the
    // Zig Builder, we need to write it to the Error output.
    // In Zig, we do this with "std.debug.print" and in C we can
    // specify a file descriptor i.e. 2 for error console.
    // 为了输出可以被 Zig Builder 评估的文本，我们需要将其写入错误输出。
    // 在 Zig 中，我们用 "std.debug.print" 做到这一点，在 C 中我们可以
    // 指定文件描述符，即错误控制台的 2。
    //
    // In this exercise we use 'write' to output 17 chars,
    // but something is still missing...
    // 在这个练习中，我们使用 'write' 来输出 17 个字符，
    // 但还缺少什么...
    const c_res = write(2, "Hello C from Zig!", 17);

    // let's see what the result from C is:
    // 让我们看看 C 的结果是什么：
    std.debug.print(" - C result is {d} chars written.\n", .{c_res});
}
//
// Something must be considered when compiling with C functions.
// Namely that the Zig compiler knows that it should include
// corresponding libraries. For this purpose we call the compiler
// with the parameter "lc" for such a program,
// e.g. "zig run -lc hello_c.zig".
// 在使用 C 函数编译时必须考虑一些事情。
// 即 Zig 编译器知道它应该包含相应的库。
// 为此，我们使用参数 "lc" 调用编译器来编译这样的程序，
// 例如 "zig run -lc hello_c.zig"。
//
