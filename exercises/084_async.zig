//
// Six Facts:
// 六个事实：
//
// 1. The memory space allocated to your program for the
// invocation of a function and all of its data is called a
// "stack frame".
// 1. 为您的程序分配的用于函数调用及其所有数据的内存空间称为"栈帧"。
//
// 2. The 'return' keyword "pops" the current function
// invocation's frame off of the stack (it is no longer needed)
// and returns control to the place where the function was
// called.
// 2. 'return' 关键字将当前函数调用的帧从栈中"弹出"（不再需要）
// 并将控制权返回到调用函数的地方。
//
//     fn foo() void {
//         return; // Pop the frame and return control
//     }
//
// 3. Like 'return', the 'suspend' keyword returns control to the
// place where the function was called BUT the function
// invocation's frame remains so that it can regain control again
// at a later time. Functions which do this are "async"
// functions.
// 3. 与 'return' 类似，'suspend' 关键字将控制权返回到调用函数的地方，
// 但函数调用的帧仍然保留，以便稍后可以重新获得控制权。
// 执行此操作的函数是"async"函数。
//
//     fn fooThatSuspends() void {
//         suspend {} // return control, but leave the frame alone
//     }
//
// 4. To call any function in async context and get a reference
// to its frame for later use, use the 'async' keyword:
// 4. 要在异步上下文中调用任何函数并获取其帧的引用以供稍后使用，
// 请使用 'async' 关键字：
//
//     var foo_frame = async fooThatSuspends();
//
// 5. If you call an async function without the 'async' keyword,
// the function FROM WHICH you called the async function itself
// becomes async! In this example, the bar() function is now
// async because it calls fooThatSuspends(), which is async.
// 5. 如果您在不使用 'async' 关键字的情况下调用异步函数，
// 调用异步函数的函数本身也会变成异步函数！在此示例中，
// bar() 函数现在是异步的，因为它调用了异步的 fooThatSuspends()。
//
//     fn bar() void {
//         fooThatSuspends();
//     }
//
// 6. The main() function cannot be async!
// 6. main() 函数不能是异步的！
//
// Given facts 3 and 4, how do we fix this program (broken by facts
// 5 and 6)?
// 鉴于事实 3 和 4，我们如何修复这个程序（被事实 5 和 6 破坏了）？
//
const print = @import("std").debug.print;

pub fn main() void {
    // Additional Hint: you can assign things to '_' when you
    // don't intend to do anything with them.
    // 额外提示：当你不打算对某些东西做任何操作时，可以将它们赋值给 '_'。
    foo();
}

fn foo() void {
    print("foo() A\n", .{});
    suspend {}
    print("foo() B\n", .{});
}
