//
// Enums are really just a set of numbers. You can leave the
// 枚举实际上只是一组数字。你可以让编译器来
// numbering up to the compiler, or you can assign them
// 处理编号，或者你可以显式地分配它们。
// explicitly. You can even specify the numeric type used.
// 你甚至可以指定使用的数值类型。
//
//     const Stuff = enum(u8){ foo = 16 };
//
// You can get the integer out with a builtin function,
// 你可以用内置函数@intFromEnum()来获取整数。
// @intFromEnum(). We'll learn about builtins properly in a later
// 我们将在后面的练习中正确学习内置函数。
// exercise.
// 练习中正确学习内置函数。
//
//     const my_stuff: u8 = @intFromEnum(Stuff.foo);
//
// Note how that built-in function starts with "@" just like the
// 注意内置函数以"@"开头，就像我们一直在使用的
// @import() function we've been using.
// @import()函数一样。
//
const std = @import("std");

// Zig lets us write integers in hexadecimal format:
// Zig允许我们用十六进制格式写整数：
//
//     0xf (is the value 15 in hex)
//     0xf (是十六进制中的值15)
//
// Web browsers let us specify colors using a hexadecimal
// Web浏览器让我们使用十六进制数字来指定颜色，
// number where each byte represents the brightness of the
// 其中每个字节表示红、绿或蓝分量(RGB)的亮度，
// Red, Green, or Blue component (RGB) where two hex digits
// 两个十六进制数字是一个字节，值范围为0-255：
// are one byte with a value range of 0-255:
// 两个十六进制数字是一个字节，值范围为0-255：
//
//     #RRGGBB
//
// Please define and use a pure blue value Color:
// 请定义并使用纯蓝色值Color：
const Color = enum(u32) {
    red = 0xff0000,
    green = 0x00ff00,
    blue = ???,
};

pub fn main() void {
    // Remember Zig's multi-line strings? Here they are again.
    // 还记得Zig的多行字符串吗？它们又出现了。
    // Also, check out this cool format string:
    // 另外，看看这个很酷的格式字符串：
    //
    //     {x:0>6}
    //      ^
    //      x       type ('x' is lower-case hexadecimal)
    //      x       类型('x'是小写十六进制)
    //       :      separator (needed for format syntax)
    //       :      分隔符(格式语法需要)
    //        0     padding character (default is ' ')
    //        0     填充字符(默认是' ')
    //         >    alignment ('>' aligns right)
    //         >    对齐方式('>'右对齐)
    //          6   width (use padding to force width)
    //          6   宽度(使用填充强制宽度)
    //
    // Please add this formatting to the blue value.
    // 请将此格式添加到蓝色值。
    // (Even better, experiment without it, or try parts of it
    // (更好的是，不使用它来实验，或尝试其中的部分
    // to see what prints!)
    // 来看看打印什么！)
    std.debug.print(
        \\<p>
        \\  <span style="color: #{x:0>6}">Red</span>
        \\  <span style="color: #{x:0>6}">Green</span>
        \\  <span style="color: #{}">Blue</span>
        \\</p>
        \\
    , .{
        @intFromEnum(Color.red),
        @intFromEnum(Color.green),
        @intFromEnum(???), // Oops! We're missing something!
                           // 糟糕！我们遗漏了什么！
    });
}
