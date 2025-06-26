//
// Sure, we can solve our async value problem with a global
// variable. But this hardly seems like an ideal solution.
// 当然，我们可以用全局变量来解决异步值问题。但这似乎不是理想的解决方案。
//
// So how do we REALLY get return values from async functions?
// 那么我们如何真正从异步函数中获取返回值呢？
//
// The 'await' keyword waits for an async function to complete
// and then captures its return value.
// 'await' 关键字等待异步函数完成，然后捕获其返回值。
//
//     fn foo() u32 {
//         return 5;
//     }
//
//    var foo_frame = async foo(); // invoke and get frame
//    var value = await foo_frame; // await result using frame
//
// The above example is just a silly way to call foo() and get 5
// back. But if foo() did something more interesting such as wait
// for a network response to get that 5, our code would pause
// until the value was ready.
// 上面的示例只是调用 foo() 并获取 5 的愚蠢方式。但如果 foo()
// 做了更有趣的事情，比如等待网络响应来获取那个 5，我们的代码将暂停，
// 直到值准备就绪。
//
// As you can see, async/await basically splits a function call
// into two parts:
// 如您所见，async/await 基本上将函数调用分为两部分：
//
//    1. Invoke the function ('async')
//    1. 调用函数 ('async')
//    2. Getting the return value ('await')
//    2. 获取返回值 ('await')
//
// Also notice that a 'suspend' keyword does NOT need to exist in
// a function to be called in an async context.
// 还要注意，在异步上下文中调用的函数中不需要存在 'suspend' 关键字。
//
// Please use 'await' to get the string returned by
// getPageTitle().
// 请使用 'await' 获取 getPageTitle() 返回的字符串。
//
const print = @import("std").debug.print;

pub fn main() void {
    var myframe = async getPageTitle("http://example.com");

    var value = ???print("{s}\n", .{value});
}

fn getPageTitle(url: []const u8) []const u8 {
    // Please PRETEND this is actually making a network request.
    // 请假设这实际上正在发出网络请求。
    _ = url;
    return "Example Title.";
}
