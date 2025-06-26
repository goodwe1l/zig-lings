//
// It has probably not escaped your attention that we are no
// longer capturing a return value from foo() because the 'async'
// keyword returns the frame instead.
// 您可能已经注意到，我们不再捕获 foo() 的返回值，因为 'async'
// 关键字返回的是帧。
//
// One way to solve this is to use a global variable.
// 解决这个问题的一种方法是使用全局变量。
//
// See if you can make this program print "1 2 3 4 5".
// 看看您能否让这个程序打印出 "1 2 3 4 5"。
//
const print = @import("std").debug.print;

var global_counter: i32 = 0;

pub fn main() void {
    var foo_frame = async foo();

    while (global_counter <= 5) {
        print("{} ", .{global_counter});
        ???
    }

    print("\n", .{});
}

fn foo() void {
    while (true) {
        ???
        ???
    }
}
