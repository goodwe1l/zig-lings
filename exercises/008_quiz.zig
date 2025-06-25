//
// Quiz time! Let's see if you can fix this whole program.
// 测验时间！让我们看看你能否修复整个程序。
//
// You'll have to think about this one a bit.
// 你需要仔细思考这个问题。
//
// Let the compiler tell you what's wrong.
// 让编译器告诉你哪里出了问题。
//
// Start at the top.
// 从顶部开始。
//
const std = @import("std");

pub fn main() void {
    // What is this nonsense? :-)
    // 这是什么胡言乱语？ :-)
    const letters = "YZhifg";

    // Note: usize is an unsigned integer type used for...sizes.
    // The exact size of usize depends on the target CPU
    // architecture. We could have used a u8 here, but usize is
    // the idiomatic type to use for array indexing.
    //
    // There IS a problem on this line, but 'usize' isn't it.
    // 注意：usize 是一个用于...大小的无符号整数类型。
    // usize 的确切大小取决于目标 CPU 架构。我们本可以在这里使用 u8，
    // 但 usize 是用于数组索引的惯用类型。
    //
    // 这行确实有问题，但 'usize' 不是问题所在。
    const x: usize = 1;

    // Note: When you want to declare memory (an array in this
    // case) without putting anything in it, you can set it to
    // 'undefined'. There is no problem on this line.
    // 注意：当你想要声明内存（在这种情况下是数组）而不在其中放入任何内容时，
    // 你可以将其设置为 'undefined'。这行没有问题。
    var lang: [3]u8 = undefined;

    // The following lines attempt to put 'Z', 'i', and 'g' into the
    // 'lang' array we just created by indexing the array
    // 'letters' with the variable 'x'. As you can see above, x=1
    // to begin with.
    // 以下几行试图通过使用变量 'x' 索引数组 'letters' 来将 'Z', 'i', 和 'g' 
    // 放入我们刚创建的 'lang' 数组中。如上所示，x 开始时等于 1。
    lang[0] = letters[x];

    x = 3;
    lang[???] = letters[x];

    x = ???;
    lang[2] = letters[???];

    // We want to "Program in Zig!" of course:
    // 当然，我们想要"Program in Zig!"：
    std.debug.print("Program in {s}!\n", .{lang});
}
