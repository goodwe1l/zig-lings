//
// Remember that little mathematical virtual machine we made using the
// 还记得我们用"unreachable"语句制作的小数学虚拟机吗？
// "unreachable" statement?  Well, there were two problems with the
// 好吧，我们使用操作码的方式有两个问题：
// way we were using op codes:
// 我们使用操作码的方式：
//
//   1. Having to remember op codes by number is no good.
//   1. 必须记住操作码的数字是不好的。
//   2. We had to use "unreachable" because Zig had no way of knowing
//   2. 我们必须使用"unreachable"因为Zig无法知道
//      how many valid op codes there were.
//      有多少个有效的操作码。
//
// An "enum" is a Zig construct that lets you give names to numeric
// "enum"是一个Zig结构，它让你给数值命名
// values and store them in a set. They look a lot like error sets:
// 并将它们存储在一个集合中。它们看起来很像错误集合：
//
//     const Fruit = enum{ apple, pear, orange };
//
//     const my_fruit = Fruit.apple;
//
// Let's use an enum in place of the numbers we were using in the
// 让我们用enum来替换我们在之前版本中使用的数字！
// previous version!
// 之前版本中使用的数字！
//
const std = @import("std");

// Please complete the enum!
// 请完成这个enum！
const Ops = enum { ??? };

pub fn main() void {
    const operations = [_]Ops{
        Ops.inc,
        Ops.inc,
        Ops.inc,
        Ops.pow,
        Ops.dec,
        Ops.dec,
    };

    var current_value: u32 = 0;

    for (operations) |op| {
        switch (op) {
            Ops.inc => {
                current_value += 1;
            },
            Ops.dec => {
                current_value -= 1;
            },
            Ops.pow => {
                current_value *= current_value;
            },
            // No "else" needed! Why is that?
            // 不需要"else"！这是为什么？
        }

        std.debug.print("{} ", .{current_value});
    }

    std.debug.print("\n", .{});
}
