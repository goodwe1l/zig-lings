//
// Remember using if/else statements as expressions like this?
// 还记得像这样使用if/else语句作为表达式吗？
//
//     var foo: u8 = if (true) 5 else 0;
//
// Zig also lets you use for and while loops as expressions.
// Zig也让你使用for和while循环作为表达式。
//
// Like 'return' for functions, you can return a value from a
// 就像函数的'return'一样，你可以从循环块中
// loop block with break:
// 用break返回一个值：
//
//     break true; // return boolean value from block
//     break true; // 从块中返回布尔值
//
// But what value is returned from a loop if a break statement is
// 但如果从未达到break语句，循环会返回什么值？
// never reached? We need a default expression. Thankfully, Zig
// 我们需要一个默认表达式。谢天谢地，Zig
// loops also have 'else' clauses! As you might have guessed, the
// 循环也有'else'子句！正如你可能猜到的，
// 'else' clause is evaluated when: 1) a 'while' condition becomes
// 'else'子句在以下情况下被评估：1）'while'条件变为
// false or 2) a 'for' loop runs out of items.
// false或2）'for'循环用完项目。
//
//     const two: u8 = while (true) break 2 else 0;         // 2
//     const two: u8 = while (true) break 2 else 0;         // 2
//     const three: u8 = for ([1]u8{1}) |f| break 3 else 0; // 3
//     const three: u8 = for ([1]u8{1}) |f| break 3 else 0; // 3
//
// If you do not provide an else clause, an empty one will be
// 如果你不提供else子句，将为你提供一个空的，
// provided for you, which will evaluate to the void type, which
// 它将评估为void类型，这
// is probably not what you want. So consider the else clause
// 可能不是你想要的。所以在使用循环作为表达式时
// essential when using loops as expressions.
// 将else子句视为必需的。
//
//     const four: u8 = while (true) {
//         break 4;
//     };               // <-- ERROR! Implicit 'else void' here!
//     };               // <-- 错误！这里有隐式的'else void'！
//
// With that in mind, see if you can fix the problem with this
// 考虑到这一点，看看你能否修复这个程序的问题。
// program.
//
const print = @import("std").debug.print;

pub fn main() void {
    const langs: [6][]const u8 = .{
        "Erlang",
        "Algol",
        "C",
        "OCaml",
        "Zig",
        "Prolog",
    };

    // Let's find the first language with a three-letter name and
    // 让我们找到第一个有三个字母名称的语言并
    // return it from the for loop.
    // 从for循环中返回它。
    const current_lang: ?[]const u8 = for (langs) |lang| {
        if (lang.len == 3) break lang;
    };

    if (current_lang) |cl| {
        print("Current language: {s}\n", .{cl});
    } else {
        print("Did not find a three-letter language name. :-(\n", .{});
    }
}
