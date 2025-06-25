//
// Now that we've learned about arrays, we can talk about strings.
// 现在我们已经学习了数组，我们可以谈论字符串了。
//
// We've already seen Zig string literals: "Hello world.\n"
// 我们已经见过 Zig 字符串字面量："Hello world.\n"
//
// Zig stores strings as arrays of bytes.
// Zig 将字符串存储为字节数组。
//
//     const foo = "Hello";
//
// Is almost* the same as:
// 几乎*等同于：
//
//     const foo = [_]u8{ 'H', 'e', 'l', 'l', 'o' };
//
// (* We'll see what Zig strings REALLY are in Exercise 77.)
// (* 我们将在练习 77 中看到 Zig 字符串真正是什么。)
//
// Notice how individual characters use single quotes ('H') and
// strings use double quotes ("H"). These are not interchangeable!
// 注意单个字符使用单引号 ('H')，字符串使用双引号 ("H")。
// 这两者不能互换！
//
const std = @import("std");

pub fn main() void {
    const ziggy = "stardust";

    // (Problem 1)
    // Use array square bracket syntax to get the letter 'd' from
    // the string "stardust" above.
    // （问题 1）
    // 使用数组方括号语法从上面的字符串 "stardust" 中获取字母 'd'。
    const d: u8 = ziggy[???];

    // (Problem 2)
    // Use the array repeat '**' operator to make "ha ha ha ".
    // （问题 2）
    // 使用数组重复 '**' 操作符来创建 "ha ha ha "。
    const laugh = "ha " ???;

    // (Problem 3)
    // Use the array concatenation '++' operator to make "Major Tom".
    // (You'll need to add a space as well!)
    // （问题 3）
    // 使用数组连接 '++' 操作符来创建 "Major Tom"。
    // （你还需要添加一个空格！）
    const major = "Major";
    const tom = "Tom";
    const major_tom = major ??? tom;

    // That's all the problems. Let's see our results:
    // 这就是所有的问题。让我们看看结果：
    std.debug.print("d={u} {s}{s}\n", .{ d, laugh, major_tom });
    // Keen eyes will notice that we've put 'u' and 's' inside the '{}'
    // placeholders in the format string above. This tells the
    // print() function to format the values as a UTF-8 character and
    // UTF-8 strings respectively. If we didn't do this, we'd see '100',
    // which is the decimal number corresponding with the 'd' character
    // in UTF-8. (And an error in the case of the strings.)
    //
    // While we're on this subject, 'c' (ASCII encoded character)
    // would work in place for 'u' because the first 128 characters
    // of UTF-8 are the same as ASCII!
    //
    // 敏锐的眼睛会注意到我们在上面格式字符串的 '{}' 占位符中
    // 放入了 'u' 和 's'。这告诉 print() 函数分别将值格式化为
    // UTF-8 字符和 UTF-8 字符串。如果我们不这样做，我们会看到 '100'，
    // 这是 UTF-8 中对应 'd' 字符的十进制数。（在字符串的情况下会出错。）
    //
    // 既然我们在讨论这个主题，'c'（ASCII 编码字符）可以代替 'u' 使用，
    // 因为 UTF-8 的前 128 个字符与 ASCII 相同！
    //
}
