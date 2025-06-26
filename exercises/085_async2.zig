//
// So, 'suspend' returns control to the place from which it was
// called (the "call site"). How do we give control back to the
// suspended function?
// 因此，'suspend' 将控制权返回到调用它的地方（"调用位置"）。
// 我们如何将控制权返回给被挂起的函数？
//
// For that, we have a new keyword called 'resume' which takes an
// async function invocation's frame and returns control to it.
// 为此，我们有一个叫做 'resume' 的新关键字，它接受一个异步函数
// 调用的帧并将控制权返回给它。
//
//     fn fooThatSuspends() void {
//         suspend {}
//     }
//
//     var foo_frame = async fooThatSuspends();
//     resume foo_frame;
//
// See if you can make this program print "Hello async!".
// 看看您能否让这个程序打印出 "Hello async!"。
//
const print = @import("std").debug.print;

pub fn main() void {
    var foo_frame = async foo();
}

fn foo() void {
    print("Hello ", .{});
    suspend {}
    print("async!\n", .{});
}
