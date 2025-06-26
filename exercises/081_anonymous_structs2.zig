//
// An anonymous struct value LITERAL (not to be confused with a
// struct TYPE) uses '.{}' syntax:
// 匿名结构体值字面量（不要与结构体类型混淆）使用 '.{}' 语法：
//
//     .{
//          .center_x = 15,
//          .center_y = 12,
//          .radius = 6,
//     }
//
// These literals are always evaluated entirely at compile-time.
// The example above could be coerced into the i32 variant of the
// "circle struct" from the last exercise.
// 这些字面量总是在编译时完全求值。上面的例子可以强制转换为上一练习中
// "圆形结构体"的 i32 变体。
//
// Or you can let them remain entirely anonymous as in this
// example:
// 或者您可以让它们保持完全匿名，如下例所示：
//
//     fn bar(foo: anytype) void {
//         print("a:{} b:{}\n", .{foo.a, foo.b});
//     }
//
//     bar(.{
//         .a = true,
//         .b = false,
//     });
//
// The example above prints "a:true b:false".
// 上面的例子打印 "a:true b:false"。
//
const print = @import("std").debug.print;

pub fn main() void {
    printCircle(.{
        .center_x = @as(u32, 205),
        .center_y = @as(u32, 187),
        .radius = @as(u32, 12),
    });
}

// Please complete this function which prints an anonymous struct
// representing a circle.
// 请完成这个打印表示圆形的匿名结构体的函数。
fn printCircle(???) void {
    print("x:{} y:{} radius:{}\n", .{
        circle.center_x,
        circle.center_y,
        circle.radius,
    });
}
