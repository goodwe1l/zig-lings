//
// Now let's create a function that takes a parameter. Here's an
// example that takes two parameters. As you can see, parameters
// are declared just like any other types ("name": "type"):
// 现在让我们创建一个接受参数的函数。这是一个接受两个参数的示例。
// 如你所见，参数的声明就像任何其他类型一样（"name": "type"）：
//
//     fn myFunction(number: u8, is_lucky: bool) {
//         ...
//     }
//
const std = @import("std");

pub fn main() void {
    std.debug.print("Powers of two: {} {} {} {}\n", .{
        twoToThe(1),
        twoToThe(2),
        twoToThe(3),
        twoToThe(4),
    });
}

// Please give this function the correct input parameter(s).
// You'll need to figure out the parameter name and type that we're
// expecting. The output type has already been specified for you.
//
// 请为这个函数提供正确的输入参数。
// 你需要找出我们期望的参数名称和类型。
// 输出类型已经为你指定了。
//
fn twoToThe(???) u32 {
    return std.math.pow(u32, 2, my_number);
    // std.math.pow(type, a, b) takes a numeric type and two
    // numbers of that type (or that can coerce to that type) and
    // returns "a to the power of b" as that same numeric type.
    // std.math.pow(type, a, b) 接受一个数值类型和该类型的两个数字
    //（或可以强制转换为该类型的数字），并返回"a 的 b 次幂"作为
    // 相同的数值类型。
}
