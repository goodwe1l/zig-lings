//
// You can assign some code to run _after_ a block of code exits by
// 你可以通过使用"defer"语句来指定一些代码在代码块退出后运行：
// deferring it with a "defer" statement:
// 通过"defer"语句延迟执行：
//
//     {
//         defer runLater();
//         runNow();
//     }
//
// In the example above, runLater() will run when the block ({...})
// 在上面的例子中，runLater()将在代码块({...})
// is finished. So the code above will run in the following order:
// 完成时运行。所以上面的代码将按以下顺序运行：
//
//     runNow();
//     runLater();
//
// This feature seems strange at first, but we'll see how it could be
// 这个特性起初看起来很奇怪，但我们会在下一个练习中看到它如何
// useful in the next exercise.
// 有用。
const std = @import("std");

pub fn main() void {
    // Without changing anything else, please add a 'defer' statement
    // 在不改变其他任何内容的情况下，请添加一个'defer'语句
    // to this code so that our program prints "One Two\n":
    // 到这段代码中，使我们的程序打印"One Two\n"：
    std.debug.print("Two\n", .{});
    std.debug.print("One ", .{});
}
