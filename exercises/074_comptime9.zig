//
// In addition to knowing when to use the 'comptime' keyword,
// it's also good to know when you DON'T need it.
// 除了知道何时使用 'comptime' 关键字外，知道何时不需要它也很重要。
//
// The following contexts are already IMPLICITLY evaluated at
// compile time, and adding the 'comptime' keyword would be
// superfluous, redundant, and smelly:
// 以下上下文已经在编译时隐式计算，添加 'comptime' 关键字将是多余的、冗余的和难闻的：
//
//    * The container-level scope (outside of any function in a source file)
//    * 容器级作用域（源文件中任何函数之外）
//    * Type declarations of:
//    * 类型声明：
//        * Variables
//        * 变量
//        * Functions (types of parameters and return values)
//        * 函数（参数和返回值的类型）
//        * Structs
//        * 结构体
//        * Unions
//        * 联合体
//        * Enums
//        * 枚举
//    * The test expressions in inline for and while loops
//    * inline for 和 while 循环中的测试表达式
//    * An expression passed to the @cImport() builtin
//    * 传递给 @cImport() 内置函数的表达式
//
// Work with Zig for a while, and you'll start to develop an
// intuition for these contexts. Let's work on that now.
// 使用 Zig 一段时间后，您将开始对这些上下文产生直觉。让我们现在开始练习。
//
// You have been given just one 'comptime' statement to use in
// the program below. Here it is:
// 您在下面的程序中只被给了一个 'comptime' 语句可以使用。它是：
//
//     comptime
//
// Just one is all it takes. Use it wisely!
// 只需要一个。明智地使用它！
//
const print = @import("std").debug.print;

// Being in the container-level scope, everything about this value is
// implicitly required to be known compile time.
// 处于容器级作用域中，关于这个值的一切都隐式要求在编译时已知。
const llama_count = 5;

// Again, this value's type and size must be known at compile
// time, but we're letting the compiler infer both from the
// return type of a function.
// 同样，这个值的类型和大小必须在编译时已知，但我们让编译器从函数的返回类型推断两者。
const llamas = makeLlamas(llama_count);

// And here's the function. Note that the return value type
// depends on one of the input arguments!
// 这就是函数。注意返回值类型依赖于其中一个输入参数！
fn makeLlamas(count: usize) [count]u8 {
    var temp: [count]u8 = undefined;
    var i = 0;

    // Note that this does NOT need to be an inline 'while'.
    // 注意这不需要是内联的 'while'。
    while (i < count) : (i += 1) {
        temp[i] = i;
    }

    return temp;
}

pub fn main() void {
    print("My llama value is {}.\n", .{llamas[2]});
}
//
// The lesson here is to not pepper your program with 'comptime'
// keywords unless you need them. Between the implicit compile
// time contexts and Zig's aggressive evaluation of any
// expression it can figure out at compile time, it's sometimes
// surprising how few places actually need the keyword.
//
// 这里的教训是不要在程序中乱用 'comptime' 关键字，除非您需要它们。
// 在隐式编译时上下文和 Zig 对任何可以在编译时计算的表达式的积极求值之间，
// 有时令人惊讶的是实际需要该关键字的地方很少。
