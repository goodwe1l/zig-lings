//
// Now that you know how "defer" works, let's do something more
// 现在你知道"defer"是如何工作的了，让我们用它做一些更
// interesting with it.
// 有趣的事情。
//
const std = @import("std");

pub fn main() void {
    const animals = [_]u8{ 'g', 'c', 'd', 'd', 'g', 'z' };

    for (animals) |a| printAnimal(a);

    std.debug.print("done.\n", .{});
}

// This function is _supposed_ to print an animal name in parentheses
// 这个函数应该在括号中打印动物名称
// like "(Goat) ", but we somehow need to print the end parenthesis
// 比如"(Goat) "，但我们需要以某种方式打印结束括号
// even though this function can return in four different places!
// 即使这个函数可以在四个不同的地方返回！
fn printAnimal(animal: u8) void {
    std.debug.print("(", .{});

    std.debug.print(") ", .{}); // <---- how?!
    std.debug.print(") ", .{}); // <---- 怎么做？！

    if (animal == 'g') {
        std.debug.print("Goat", .{});
        return;
    }
    if (animal == 'c') {
        std.debug.print("Cat", .{});
        return;
    }
    if (animal == 'd') {
        std.debug.print("Dog", .{});
        return;
    }

    std.debug.print("Unknown", .{});
}
