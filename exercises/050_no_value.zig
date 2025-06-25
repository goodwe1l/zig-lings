//
//    "We live on a placid island of ignorance in the midst
//     "我们生活在无知的宁静岛屿上，置身于
//     of black seas of infinity, and it was not meant that
//     无限黑海的包围中，我们本不应该
//     we should voyage far."
//     远航。"
//
//     from The Call of Cthulhu
//     来自《克苏鲁的呼唤》
//       by H. P. Lovecraft
//       作者：H. P. Lovecraft
//
// Zig has at least four ways of expressing "no value":
// Zig至少有四种表达"无值"的方式：
//
// * undefined
// * undefined（未定义）
//
//       var foo: u8 = undefined;
//
//       "undefined" should not be thought of as a value, but as a way
//       "undefined"不应该被认为是一个值，而是一种
//       of telling the compiler that you are not assigning a value
//       告诉编译器你暂时还没有赋值的方式。
//       _yet_. Any type may be set to undefined, but attempting
//       任何类型都可以设置为undefined，但试图
//       to read or use that value is _always_ a mistake.
//       读取或使用该值总是错误的。
//
// * null
// * null（空值）
//
//       var foo: ?u8 = null;
//
//       The "null" primitive value _is_ a value that means "no value".
//       "null"原始值是一个意味着"无值"的值。
//       This is typically used with optional types as with the ?u8
//       这通常与可选类型一起使用，如上面显示的?u8。
//       shown above. When foo equals null, that's not a value of type
//       当foo等于null时，那不是u8类型的值。
//       u8. It means there is _no value_ of type u8 in foo at all!
//       它意味着foo中根本没有u8类型的值！
//
// * error
// * error（错误）
//
//       var foo: MyError!u8 = BadError;
//
//       Errors are _very_ similar to nulls. They _are_ a value, but
//       错误与null非常相似。它们是一个值，但
//       they usually indicate that the "real value" you were looking
//       它们通常表示你要寻找的"真实值"
//       for does not exist. Instead, you have an error. The example
//       不存在。相反，你有一个错误。例子中的
//       error union type of MyError!u8 means that foo either holds
//       错误联合类型MyError!u8意味着foo要么持有
//       a u8 value OR an error. There is _no value_ of type u8 in foo
//       一个u8值，要么是一个错误。当设置为错误时，
//       when it's set to an error!
//       foo中没有u8类型的值！
//
// * void
// * void（空类型）
//
//       var foo: void = {};
//
//       "void" is a _type_, not a value. It is the most popular of the
//       "void"是一个类型，不是一个值。它是零位类型
//       Zero Bit Types (those types which take up absolutely no space
//       （那些绝对不占用空间且只有语义值的类型）
//       and have only a semantic value). When compiled to executable
//       中最受欢迎的。当编译为可执行代码时，
//       code, zero bit types generate no code at all. The above example
//       零位类型根本不生成代码。上面的例子
//       shows a variable foo of type void which is assigned the value
//       显示了一个void类型的变量foo，它被赋予
//       of an empty expression. It's much more common to see void as
//       空表达式的值。更常见的是将void作为
//       the return type of a function that returns nothing.
//       不返回任何内容的函数的返回类型。
//
// Zig has all of these ways of expressing different types of "no value"
// Zig有所有这些表达不同类型"无值"的方式
// because they each serve a purpose. Briefly:
// 因为它们各自都有目的。简而言之：
//
//   * undefined - there is no value YET, this cannot be read YET
//   * undefined - 还没有值，这还不能读取
//   * null      - there is an explicit value of "no value"
//   * null      - 有一个明确的"无值"值
//   * errors    - there is no value because something went wrong
//   * errors    - 因为出了问题所以没有值
//   * void      - there will NEVER be a value stored here
//   * void      - 这里永远不会存储值
//
// Please use the correct "no value" for each ??? to make this program
// 请为每个???使用正确的"无值"来使这个程序
// print out a cursed quote from the Necronomicon. ...If you dare.
//
const std = @import("std");

const Err = error{Cthulhu};

pub fn main() void {
    var first_line1: *const [16]u8 = ???;
    first_line1 = "That is not dead";

    var first_line2: Err!*const [21]u8 = ???;
    first_line2 = "which can eternal lie";

    // Note we need the "{!s}" format for the error union string.
    // 注意我们需要"{!s}"格式来处理错误联合字符串。
    std.debug.print("{s} {!s} / ", .{ first_line1, first_line2 });

    printSecondLine();
}

fn printSecondLine() ??? {
    var second_line2: ?*const [18]u8 = ???;
    second_line2 = "even death may die";

    std.debug.print("And with strange aeons {s}.\n", .{second_line2.?});
}
