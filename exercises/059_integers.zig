//
// Zig lets you express integer literals in several convenient
// Zig让你以几种方便的格式表达整数字面量。
// formats. These are all the same value:
// 这些都是相同的值：
//
//     const a1: u8 = 65;          // decimal
//     const a1: u8 = 65;          // 十进制
//     const a2: u8 = 0x41;        // hexadecimal
//     const a2: u8 = 0x41;        // 十六进制
//     const a3: u8 = 0o101;       // octal
//     const a3: u8 = 0o101;       // 八进制
//     const a4: u8 = 0b1000001;   // binary
//     const a4: u8 = 0b1000001;   // 二进制
//     const a5: u8 = 'A';         // ASCII code point literal
//     const a5: u8 = 'A';         // ASCII码点字面量
//     const a6: u16 = '\u{0041}'; // Unicode code points can take up to 21 bits
//     const a6: u16 = '\u{0041}'; // Unicode码点最多可以占用21位
//
// You can also place underscores in numbers to aid readability:
// 你也可以在数字中放置下划线来帮助可读性：
//
//     const t1: u32 = 14_689_520 // Ford Model T sales 1909-1927
//     const t1: u32 = 14_689_520 // 福特T型车销量1909-1927
//     const t2: u32 = 0xE0_24_F0 // same, in hex pairs
//     const t2: u32 = 0xE0_24_F0 // 相同，十六进制对
//
// Please fix the message:
// 请修复消息：

const print = @import("std").debug.print;

pub fn main() void {
    const zig = [_]u8{
        0o131, // octal
        0o131, // 八进制
        0b1101000, // binary
        0b1101000, // 二进制
        0x66, // hex
        0x66, // 十六进制
    };

    print("{s} is cool.\n", .{zig});
}
