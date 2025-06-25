//
// Sometimes you know that a variable might hold a value or
// 有时你知道一个变量可能持有一个值或者
// it might not. Zig has a neat way of expressing this idea
// 可能不持有。Zig有一种巧妙的方式来表达这个想法，
// called Optionals. An optional type just has a '?' like this:
// 叫做可选类型。一个可选类型只需要一个'?'，像这样：
//
//     var foo: ?u32 = 10;
//
// Now foo can store a u32 integer OR null (a value storing
// 现在foo可以存储一个u32整数或null（一个存储
// the cosmic horror of a value NOT EXISTING!)
// 值不存在这种宇宙恐怖的值！）
//
//     foo = null;
//
//     if (foo == null) beginScreaming();
//
// Before we can use the optional value as the non-null type
// 在我们可以将可选值用作非null类型
// (a u32 integer in this case), we need to guarantee that it
// （在这种情况下是u32整数）之前，我们需要保证它
// isn't null. One way to do this is to THREATEN IT with the
// 不是null。一种方法是用"orelse"语句来威胁它。
// "orelse" statement.
// "orelse"语句来威胁它。
//
//     var bar = foo orelse 2;
//
// Here, bar will either equal the u32 integer value stored in
// 这里，bar要么等于存储在foo中的u32整数值，
// foo, or it will equal 2 if foo was null.
// 要么如果foo是null则等于2。
//
const std = @import("std");

pub fn main() void {
    const result = deepThought();

    // Please threaten the result so that answer is either the
    // 请威胁这个结果，使答案要么是
    // integer value from deepThought() OR the number 42:
    // 来自deepThought()的整数值，要么是数字42：
    const answer: u8 = result;

    std.debug.print("The Ultimate Answer: {}.\n", .{answer});
}

fn deepThought() ?u8 {
    // It seems Deep Thought's output has declined in quality.
    // 看起来深度思考的输出质量有所下降。
    // But we'll leave this as-is. Sorry Deep Thought.
    // 但我们将保持原样。抱歉，深度思考。
    return null;
}
// Blast from the past:
// 来自过去的回响：
//
// Optionals are a lot like error union types which can either
// 可选类型很像错误联合类型，它们要么
// hold a value or an error. Likewise, the orelse statement is
// 持有一个值要么持有一个错误。同样，orelse语句
// like the catch statement used to "unwrap" a value or supply
// 就像用于"解包"值或提供默认值的catch语句：
// a default value:
// 就像用于"解包"值或提供默认值的catch语句：
//
//    var maybe_bad: Error!u32 = Error.Evil;
//    var number: u32 = maybe_bad catch 0;
//
