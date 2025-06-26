//
// Struct types are always "anonymous" until we give them a name:
// 结构体类型在我们给它们命名之前总是"匿名的"：
//
//     struct {};
//
// So far, we've been giving struct types a name like so:
// 到目前为止，我们一直像这样给结构体类型命名：
//
//     const Foo = struct {};
//
// * The value of @typeName(Foo) is "<filename>.Foo".
// * @typeName(Foo) 的值是 "<filename>.Foo"。
//
// A struct is also given a name when you return it from a
// function:
// 当您从函数返回结构体时，它也会被给予一个名称：
//
//     fn Bar() type {
//         return struct {};
//     }
//
//     const MyBar = Bar();  // store the struct type
//     const MyBar = Bar();  // 存储结构体类型
//     const bar = Bar() {}; // create instance of the struct
//     const bar = Bar() {}; // 创建结构体的实例
//
// * The value of @typeName(Bar()) is "Bar()".
// * @typeName(Bar()) 的值是 "Bar()"。
// * The value of @typeName(MyBar) is "Bar()".
// * @typeName(MyBar) 的值是 "Bar()"。
// * The value of @typeName(@TypeOf(bar)) is "Bar()".
// * @typeName(@TypeOf(bar)) 的值是 "Bar()"。
//
// You can also have completely anonymous structs. The value
// of @typeName(struct {}) is "struct:<position in source>".
// 您也可以有完全匿名的结构体。@typeName(struct {}) 的值是 "struct:<position in source>"。
//
const print = @import("std").debug.print;

// This function creates a generic data structure by returning an
// anonymous struct type (which will no longer be anonymous AFTER
// it's returned from the function).
// 这个函数通过返回一个匿名结构体类型来创建一个通用数据结构（在从函数返回后将不再是匿名的）。
fn Circle(comptime T: type) type {
    return struct {
        center_x: T,
        center_y: T,
        radius: T,
    };
}

pub fn main() void {
    //
    // See if you can complete these two variable initialization
    // expressions to create instances of circle struct types
    // which can hold these values:
    // 看看您是否可以完成这两个变量初始化表达式，以创建可以保存这些值的圆形结构体类型的实例：
    //
    // * circle1 should hold i32 integers
    // * circle1 应该保存 i32 整数
    // * circle2 should hold f32 floats
    // * circle2 应该保存 f32 浮点数
    //
    const circle1 = ??? {
        .center_x = 25,
        .center_y = 70,
        .radius = 15,
    };

    const circle2 = ??? {
        .center_x = 25.234,
        .center_y = 70.999,
        .radius = 15.714,
    };

    print("[{s}: {},{},{}] ", .{
        stripFname(@typeName(@TypeOf(circle1))),
        circle1.center_x,
        circle1.center_y,
        circle1.radius,
    });

    print("[{s}: {d:.1},{d:.1},{d:.1}]\n", .{
        stripFname(@typeName(@TypeOf(circle2))),
        circle2.center_x,
        circle2.center_y,
        circle2.radius,
    });
}

// Perhaps you remember the "narcissistic fix" for the type name
// in Ex. 065? We're going to do the same thing here: use a hard-
// coded slice to return the type name. That's just so our output
// looks prettier. Indulge your vanity. Programmers are beautiful.
// 也许您记得练习 065 中类型名称的"自恋修复"？我们将在这里做同样的事情：
// 使用硬编码切片返回类型名称。这只是为了让我们的输出看起来更漂亮。
// 放纵您的虚荣心。程序员是美丽的。
fn stripFname(mytype: []const u8) []const u8 {
    return mytype[22..];
}
// The above would be an instant red flag in a "real" program.
// 在"真实"程序中，上述内容将是一个即时的红旗。
