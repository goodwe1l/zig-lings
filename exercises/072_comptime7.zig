//
// There is also an 'inline while'. Just like 'inline for', it
// loops at compile time, allowing you to do all sorts of
// interesting things not possible at runtime. See if you can
// figure out what this rather bonkers example prints:
// 还有一个 'inline while'。就像 'inline for' 一样，它在编译时循环，
// 允许您做各种在运行时不可能的有趣事情。看看您能否弄清楚这个相当疯狂的例子打印什么：
//
//     const foo = [3]*const [5]u8{ "~{s}~", "<{s}>", "d{s}b" };
//     comptime var i = 0;
//
//     inline while ( i < foo.len ) : (i += 1) {
//         print(foo[i] ++ "\n", .{foo[i]});
//     }
//
// You haven't taken off that wizard hat yet, have you?
// 您还没有摘下那顶巫师帽，是吗？
//
const print = @import("std").debug.print;

pub fn main() void {
    // Here is a string containing a series of arithmetic
    // operations and single-digit decimal values. Let's call
    // each operation and digit pair an "instruction".
    // 这是一个包含一系列算术运算和单数字十进制值的字符串。
    // 让我们将每个操作和数字对称为"指令"。
    const instructions = "+3 *5 -2 *2";

    // Here is a u32 variable that will keep track of our current
    // value in the program at runtime. It starts at 0, and we
    // will get the final value by performing the sequence of
    // instructions above.
    // 这是一个 u32 变量，它将跟踪我们程序运行时的当前值。
    // 它从 0 开始，我们将通过执行上面的指令序列来获得最终值。
    var value: u32 = 0;

    // This "index" variable will only be used at compile time in
    // our loop.
    // 这个"索引"变量仅在我们的循环中的编译时使用。
    comptime var i = 0;

    // Here we wish to loop over each "instruction" in the string
    // at compile time.
    // 这里我们希望在编译时循环遍历字符串中的每个"指令"。
    //
    // Please fix this to loop once per "instruction":
    // 请修复这个，使其每个"指令"循环一次：
    ??? (i < instructions.len) : (???) {

        // This gets the digit from the "instruction". Can you
        // figure out why we subtract '0' from it?
        // 这从"指令"中获取数字。您能弄清楚为什么我们从中减去 '0' 吗？
        const digit = instructions[i + 1] - '0';

        // This 'switch' statement contains the actual work done
        // at runtime. At first, this doesn't seem exciting...
        // 这个 'switch' 语句包含在运行时完成的实际工作。
        // 乍一看，这似乎并不令人兴奋...
        switch (instructions[i]) {
            '+' => value += digit,
            '-' => value -= digit,
            '*' => value *= digit,
            else => unreachable,
        }
        // ...But it's quite a bit more exciting than it first appears.
        // The 'inline while' no longer exists at runtime and neither
        // does anything else not touched directly by runtime
        // code. The 'instructions' string, for example, does not
        // appear anywhere in the compiled program because it's
        // not used by it!
        // ...但它比最初看起来的要令人兴奋得多。'inline while' 在运行时不再存在，
        // 任何其他不被运行时代码直接触及的东西也不存在。例如，'instructions' 字符串
        // 不会出现在编译程序的任何地方，因为它没有被使用！
        //
        // So in a very real sense, this loop actually converts
        // the instructions contained in a string into runtime
        // code at compile time. Guess we're compiler writers
        // now. See? The wizard hat was justified after all.
        // 所以在真正意义上，这个循环实际上在编译时将字符串中包含的指令转换为运行时代码。
        // 我猜我们现在是编译器编写者了。看？巫师帽毕竟是合理的。
    }

    print("{}\n", .{value});
}
