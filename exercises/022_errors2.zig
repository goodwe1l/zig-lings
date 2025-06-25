//
// A common case for errors is a situation where we're expecting to
// have a value OR something has gone wrong. Take this example:
//
//     var text: Text = getText("foo.txt");
//
// What happens if getText() can't find "foo.txt"?  How do we express
// this in Zig?
//
// Zig lets us make what's called an "error union" which is a value
// which could either be a regular value OR an error from a set:
//
//     var text: MyErrorSet!Text = getText("foo.txt");
//
// For now, let's just see if we can try making an error union!
//
// 错误的一个常见情况是我们期望有一个值或者出了什么问题。
// 看这个例子：
//
//     var text: Text = getText("foo.txt");
//
// 如果 getText() 找不到 "foo.txt" 会怎样？我们如何在 Zig 中表达这一点？
//
// Zig 允许我们创建所谓的"错误联合"，这是一个值，
// 它可以是常规值或来自集合的错误：
//
//     var text: MyErrorSet!Text = getText("foo.txt");
//
// 现在，让我们看看能否尝试创建一个错误联合！
//
const std = @import("std");

const MyNumberError = error{TooSmall};

pub fn main() void {
    var my_number: ??? = 5;

    // Looks like my_number will need to either store a number OR
    // an error. Can you set the type correctly above?
    // 看起来 my_number 需要存储一个数字或一个错误。
    // 你能在上面正确设置类型吗？
    my_number = MyNumberError.TooSmall;

    std.debug.print("I compiled!\n", .{});
}
