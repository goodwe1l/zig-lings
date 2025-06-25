//
// Great news! Now we know enough to understand a "real" Hello World
// 好消息！现在我们知道得足够多，可以理解一个"真正的"Hello World
// program in Zig - one that uses the system Standard Out resource...which
// 程序了——一个使用系统标准输出资源的程序...这个
// can fail!
// 可能会失败！
//
const std = @import("std");

// Take note that this main() definition now returns "!void" rather
// 注意这个main()定义现在返回"!void"而不是
// than just "void". Since there's no specific error type, this means
// 仅仅"void"。由于没有指定具体的错误类型，这意味着
// that Zig will infer the error type. This is appropriate in the case
// Zig将推断错误类型。这在main()函数的情况下是合适的，
// of main(), but can make a function harder (function pointers) or
// 但在某些情况下可能会使函数更难处理（函数指针）或
// even impossible to work with (recursion) in some situations.
// 甚至无法工作（递归）。
//
// You can find more information at:
// 你可以在以下链接找到更多信息：
// https://ziglang.org/documentation/master/#Inferred-Error-Sets
//
pub fn main() !void {
    // We get a Writer for Standard Out so we can print() to it.
    // 我们获取一个标准输出的Writer，这样我们就可以使用print()输出到它。
    const stdout = std.io.getStdOut().writer();

    // Unlike std.debug.print(), the Standard Out writer can fail
    // 不像std.debug.print()，标准输出writer可能会失败
    // with an error. We don't care _what_ the error is, we want
    // 并产生一个错误。我们不关心错误是什么，我们想要
    // to be able to pass it up as a return value of main().
    // 能够将它作为main()的返回值向上传递。
    //
    // We just learned of a single statement which can accomplish this.
    // 我们刚刚学习了一个可以完成这个任务的单一语句。
    stdout.print("Hello world!\n", .{});
}
