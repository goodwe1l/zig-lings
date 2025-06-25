//
// It'll only take us a moment to learn the Zig type coercion
// 学习Zig类型强制转换规则只需要一点时间，
// rules because they're quite logical.
// 因为它们非常合乎逻辑。
//
// 1. Types can always be made _more_ restrictive.
// 1. 类型总是可以变得_更_严格。
//
//    var foo: u8 = 5;
//    var p1: *u8 = &foo;
//    var p2: *const u8 = p1; // mutable to immutable
//    var p2: *const u8 = p1; // 可变到不可变
//
// 2. Numeric types can coerce to _larger_ types.
// 2. 数字类型可以强制转换为_更大_的类型。
//
//    var n1: u8 = 5;
//    var n2: u16 = n1; // integer "widening"
//    var n2: u16 = n1; // 整数"扩展"
//
//    var n3: f16 = 42.0;
//    var n4: f32 = n3; // float "widening"
//    var n4: f32 = n3; // 浮点"扩展"
//
// 3. Single-item pointers to arrays coerce to slices and
// 3. 数组的单项指针强制转换为切片和
//    many-item pointers.
//    多项指针。
//
//    const arr: [3]u8 = [3]u8{5, 6, 7};
//    const s: []const u8 = &arr;  // to slice
//    const s: []const u8 = &arr;  // 到切片
//    const p: [*]const u8 = &arr; // to many-item pointer
//    const p: [*]const u8 = &arr; // 到多项指针
//
// 4. Single-item mutable pointers can coerce to single-item
// 4. 单项可变指针可以强制转换为指向长度为1的数组的
//    pointers pointing to an array of length 1. (Interesting!)
//    单项指针。（有趣！）
//
//    var five: u8 = 5;
//    var a_five: *[1]u8 = &five;
//
// 5. Payload types and null coerce to optionals.
// 5. 有效载荷类型和null强制转换为可选类型。
//
//    var num: u8 = 5;
//    var maybe_num: ?u8 = num; // payload type
//    var maybe_num: ?u8 = num; // 有效载荷类型
//    maybe_num = null;         // null
//    maybe_num = null;         // null
//
// 6. Payload types and errors coerce to error unions.
// 6. 有效载荷类型和错误强制转换为错误联合。
//
//    const MyError = error{Argh};
//    var char: u8 = 'x';
//    var char_or_die: MyError!u8 = char; // payload type
//    var char_or_die: MyError!u8 = char; // 有效载荷类型
//    char_or_die = MyError.Argh;         // error
//    char_or_die = MyError.Argh;         // 错误
//
// 7. 'undefined' coerces to any type (or it wouldn't work!)
// 7. 'undefined'强制转换为任何类型（否则它就不起作用了！）
//
// 8. Compile-time numbers coerce to compatible types.
// 8. 编译时数字强制转换为兼容类型。
//
//    Just about every single exercise program has had an example
//    几乎每个练习程序都有这样的例子，
//    of this, but a full and proper explanation is coming your
//    但完整而恰当的解释很快就会在
//    way soon in the third-eye-opening subject of comptime.
//    令人大开眼界的comptime主题中到来。
//
// 9. Tagged unions coerce to the current tagged enum.
// 9. 标记联合强制转换为当前标记枚举。
//
// 10. Enums coerce to a tagged union when that tagged field is a
// 10. 当标记字段是只有一个值的零长度类型（如void）时，
//     zero-length type that has only one value (like void).
//     枚举强制转换为标记联合。
//
// 11. Zero-bit types (like void) can be coerced into single-item
// 11. 零位类型（如void）可以强制转换为单项
//     pointers.
//     指针。
//
// The last three are fairly esoteric, but you're more than
// 最后三个相当深奥，但我们非常欢迎你
// welcome to read more about them in the official Zig language
// 在官方Zig语言文档中阅读更多关于它们的内容
// documentation and write your own experiments.
// 并编写你自己的实验。

const print = @import("std").debug.print;

pub fn main() void {
    var letter: u8 = 'A';

    const my_letter:   ???   = &letter;
    //               ^^^^^^^
    //           Your type here.
    //           你的类型在这里。
    // Must coerce from &letter (which is a *u8).
    // 必须从&letter（即*u8）强制转换。
    // Hint: Use coercion Rules 4 and 5.
    // 提示：使用强制转换规则4和5。

    // When it's right, this will work:
    // 当它正确时，这将工作：
    print("Letter: {u}\n", .{my_letter.?.*[0]});
}
