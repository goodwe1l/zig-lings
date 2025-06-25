//
// Here's a fun one: Zig has multi-line strings!
// 这里有一个有趣的功能：Zig 有多行字符串！
//
// To make a multi-line string, put '\\' at the beginning of each
// line just like a code comment but with backslashes instead:
// 要创建多行字符串，在每行开头放置 '\\'，就像代码注释一样，
// 但使用反斜杠：
//
//     const two_lines =
//         \\Line One
//         \\Line Two
//     ;
//
// See if you can make this program print some song lyrics.
// 看看你能否让这个程序打印一些歌词。
//
const std = @import("std");

pub fn main() void {
    const lyrics =
        Ziggy played guitar
        Jamming good with Andrew Kelley
        And the Spiders from Mars
    ;

    std.debug.print("{s}\n", .{lyrics});
}
