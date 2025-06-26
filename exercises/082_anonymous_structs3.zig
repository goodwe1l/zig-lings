//
// You can even create anonymous struct literals without field
// names:
// 您甚至可以创建没有字段名称的匿名结构体字面量：
//
//     .{
//         false,
//         @as(u32, 15),
//         @as(f64, 67.12)
//     }
//
// We call these "tuples", which is a term used by many
// programming languages for a data type with fields referenced
// by index order rather than name. To make this possible, the Zig
// compiler automatically assigns numeric field names 0, 1, 2,
// etc. to the struct.
// 我们称这些为"元组"，这是许多编程语言用来表示通过索引顺序而不是名称引用字段的
// 数据类型的术语。为了实现这一点，Zig 编译器自动为结构体分配数字字段名 0、1、2 等。
//
// Since bare numbers are not legal identifiers (foo.0 is a
// syntax error), we have to quote them with the @"" syntax.
// Example:
// 由于裸数字不是合法标识符（foo.0 是语法错误），我们必须用 @"" 语法引用它们。例子：
//
//     const foo = .{ true, false };
//
//     print("{} {}\n", .{foo.@"0", foo.@"1"});
//
// The example above prints "true false".
// 上面的例子打印 "true false"。
//
// Hey, WAIT A SECOND...
// 嘿，等一下...
//
// If a .{} thing is what the print function wants, do we need to
// break our "tuple" apart and put it in another one? No! It's
// redundant! This will print the same thing:
// 如果 .{} 是 print 函数想要的，我们需要将我们的"元组"拆开并放入另一个吗？
// 不！这是多余的！这将打印相同的内容：
//
//     print("{} {}\n", foo);
//
// Aha! So now we know that print() takes a "tuple". Things are
// really starting to come together now.
// 啊哈！所以现在我们知道 print() 接受一个"元组"。现在事情真的开始汇聚了。
//
const print = @import("std").debug.print;

pub fn main() void {
    // A "tuple":
    // 一个"元组"：
    const foo = .{
        true,
        false,
        @as(i32, 42),
        @as(f32, 3.141592),
    };

    // We'll be implementing this:
    // 我们将实现这个：
    printTuple(foo);

    // This is just for fun, because we can:
    // 这只是为了好玩，因为我们可以：
    const nothing = .{};
    print("\n", nothing);
}

// Let's make our own generic "tuple" printer. This should take a
// "tuple" and print out each field in the following format:
// 让我们制作自己的通用"元组"打印器。这应该接受一个"元组"并按以下格式打印每个字段：
//
//     "name"(type):value
//
// Example:
// 例子：
//
//     "0"(bool):true
//
// You'll be putting this together. But don't worry, everything
// you need is documented in the comments.
// 您将把这些放在一起。但不要担心，您需要的一切都在注释中记录了。
fn printTuple(tuple: anytype) void {
    // 1. Get a list of fields in the input 'tuple'
    // parameter. You'll need:
    // 1. 获取输入 'tuple' 参数中的字段列表。您需要：
    //
    //     @TypeOf() - takes a value, returns its type.
    //     @TypeOf() - 接受一个值，返回其类型。
    //
    //     @typeInfo() - takes a type, returns a TypeInfo union
    //                   with fields specific to that type.
    //     @typeInfo() - 接受一个类型，返回一个 TypeInfo 联合体，
    //                   包含特定于该类型的字段。
    //
    //     The list of a struct type's fields can be found in
    //     TypeInfo's @"struct".fields.
    //     结构体类型的字段列表可以在 TypeInfo 的 @"struct".fields 中找到。
    //
    //     Example:
    //     例子：
    //
    //         @typeInfo(Circle).@"struct".fields
    //
    // This will be an array of StructFields.
    // 这将是一个 StructFields 数组。
    const fields = ???;

    // 2. Loop through each field. This must be done at compile
    // time.
    // 2. 循环遍历每个字段。这必须在编译时完成。
    //
    //     Hint: remember 'inline' loops?
    //     提示：还记得 'inline' 循环吗？
    //
    for (fields) |field| {
        // 3. Print the field's name, type, and value.
        //
        //     Each 'field' in this loop is one of these:
        //
        //         pub const StructField = struct {
        //             name: [:0]const u8,
        //             type: type,
        //             default_value_ptr: ?*const anyopaque,
        //             is_comptime: bool,
        //             alignment: comptime_int,
        //         };
        //
        //     Note we will learn about 'anyopaque' type later
        //
        //     You'll need this builtin:
        //
        //         @field(lhs: anytype, comptime field_name: []const u8)
        //
        //     The first parameter is the value to be accessed,
        //     the second parameter is a string with the name of
        //     the field you wish to access. The value of the
        //     field is returned.
        //
        //     Example:
        //
        //         @field(foo, "x"); // returns the value at foo.x
        //
        // The first field should print as: "0"(bool):true
        print("\"{s}\"({any}):{any} ", .{
            field.???,
            field.???,
            ???,
        });
    }
}
