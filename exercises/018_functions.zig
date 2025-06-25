//
// Functions! We've already created lots of functions called 'main()'. Now let's
// do something different:
// 函数！我们已经创建了很多名为 'main()' 的函数。现在让我们做一些不同的事情：
//
//     fn foo(n: u8) u8 {
//         return n + 1;
//     }
//
// The foo() function above takes a number 'n' and returns a number that is
// larger by one.
// 上面的 foo() 函数接受一个数字 'n' 并返回一个比它大 1 的数字。
//
// Note the input parameter 'n' and return types are both u8.
// 注意输入参数 'n' 和返回类型都是 u8。
//
const std = @import("std");

pub fn main() void {
    // The new function deepThought() should return the number 42. See below.
    // 新函数 deepThought() 应该返回数字 42。见下文。
    const answer: u8 = deepThought();

    std.debug.print("Answer to the Ultimate Question: {}\n", .{answer});
}

// Please define the deepThought() function below.
//
// We're just missing a couple things. One thing we're NOT missing is the
// keyword "pub", which is not needed here. Can you guess why?
//
// 请在下面定义 deepThought() 函数。
//
// 我们只是缺少几样东西。我们不缺少的一样东西是关键字 "pub"，
// 这里不需要它。你能猜出为什么吗？
//
??? deepThought() ??? {
    return 42; // Number courtesy Douglas Adams
    return 42; // 数字来源于道格拉斯·亚当斯
}
