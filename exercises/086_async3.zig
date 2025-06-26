//
// Because they can suspend and resume, async Zig functions are
// an example of a more general programming concept called
// "coroutines". One of the neat things about Zig async functions
// is that they retain their state as they are suspended and
// resumed.
// 因为它们可以挂起和恢复，异步 Zig 函数是一个更通用的编程概念
// "协程"的例子。Zig 异步函数的巧妙之处之一是它们在挂起和
// 恢复时保持其状态。
//
// See if you can make this program print "5 4 3 2 1".
// 看看您能否让这个程序打印出 "5 4 3 2 1"。
//
const print = @import("std").debug.print;

pub fn main() void {
    const n = 5;
    var foo_frame = async foo(n);

    ???print("\n", .{});
}

fn foo(countdown: u32) void {
    var current = countdown;

    while (current > 0) {
        print("{} ", .{current});
        current -= 1;
        suspend {}
    }
}
