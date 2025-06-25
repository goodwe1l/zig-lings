//
// Zig has support for IEEE-754 floating-point numbers in these
// Zig支持IEEE-754浮点数，有这些特定大小：
// specific sizes: f16, f32, f64, f80, and f128. Floating point
// f16、f32、f64、f80和f128。浮点
// literals may be written in the same ways as integers but also
// 字面量可以与整数相同的方式书写，但也可以
// in scientific notation:
// 用科学记数法：
//
//     const a1: f32 = 1200;       //    1,200
//     const a1: f32 = 1200;       //    1,200
//     const a2: f32 = 1.2e+3;     //    1,200
//     const a2: f32 = 1.2e+3;     //    1,200
//     const b1: f32 = -500_000.0; // -500,000
//     const b1: f32 = -500_000.0; // -500,000
//     const b2: f32 = -5.0e+5;    // -500,000
//     const b2: f32 = -5.0e+5;    // -500,000
//
// Hex floats can't use the letter 'e' because that's a hex
// 十六进制浮点数不能使用字母'e'，因为那是一个十六进制
// digit, so we use a 'p' instead:
// 数字，所以我们用'p'代替：
//
//     const hex: f16 = 0x2A.F7p+3; // Wow, that's arcane!
//     const hex: f16 = 0x2A.F7p+3; // 哇，那很神秘！
//
// Be sure to use a float type that is large enough to store your
// 确保使用足够大的浮点类型来存储你的
// value (both in terms of significant digits and scale).
// 值（在有效数字和尺度方面）。
// Rounding may or may not be okay, but numbers which are too
// 舍入可能没问题也可能有问题，但太大或太小的
// large or too small become inf or -inf (positive or negative
// 数字会变成inf或-inf（正无穷或负无穷）！
// infinity)!
//
//     const pi: f16 = 3.1415926535;   // rounds to 3.140625
//     const pi: f16 = 3.1415926535;   // 舍入为3.140625
//     const av: f16 = 6.02214076e+23; // Avogadro's inf(inity)!
//     const av: f16 = 6.02214076e+23; // 阿伏伽德罗常数的inf(无穷)！
//
// When performing math operations with numeric literals, ensure
// 在对数字字面量执行数学运算时，确保
// the types match. Zig does not perform unsafe type coercions
// 类型匹配。Zig不会在你背后执行不安全的类型强制转换：
// behind your back:
//
//    var foo: f16 = 5; // NO ERROR
//    var foo: f16 = 5; // 没有错误
//
//    var foo: u16 = 5; // A literal of a different type
//    var foo: u16 = 5; // 不同类型的字面量
//    var bar: f16 = foo; // ERROR
//    var bar: f16 = foo; // 错误
//
// Please fix the two float problems with this program and
// 请修复此程序中的两个浮点问题并
// display the result as a whole number.
// 将结果显示为整数。

const print = @import("std").debug.print;

pub fn main() void {
    // The approximate weight of the Space Shuttle upon liftoff
    // 航天飞机发射时的大约重量
    // (including boosters and fuel tank) was 4,480,000 lb.
    // （包括助推器和燃料箱）为4,480,000磅。
    //
    // We'll convert this weight from pounds to metric units at a
    // 我们将以每磅0.453592公斤的转换率
    // conversion of 0.453592 kg to the pound.
    // 将这个重量从磅转换为公制单位。
    const shuttle_weight: f16 = 0.453592 * 4480e3;

    // By default, float values are formatted in scientific
    // 默认情况下，浮点值以科学记数法格式化。
    // notation. Try experimenting with '{d}' and '{d:.3}' to see
    // 尝试用'{d}'和'{d:.3}'实验，看看
    // how decimal formatting works.
    // 十进制格式化是如何工作的。
    print("Shuttle liftoff weight: {d:.0} metric tons\n", .{shuttle_weight});
}

// Floating further:
// 深入浮点：
//
// As an example, Zig's f16 is a IEEE 754 "half-precision" binary
// 作为例子，Zig的f16是IEEE 754"半精度"二进制
// floating-point format ("binary16"), which is stored in memory
// 浮点格式（"binary16"），在内存中的存储方式
// like so:
// 是这样的：
//
//         0 1 0 0 0 0 1 0 0 1 0 0 1 0 0 0
//         | |-------| |-----------------|
//         |  exponent     significand
//         |
//          sign
//
// This example is the decimal number 3.140625, which happens to
// be the closest representation of Pi we can make with an f16
// due to the way IEEE-754 floating points store digits:
//
//   * Sign bit 0 makes the number positive.
//   * Exponent bits 10000 are a scale of 16.
//   * Significand bits 1001001000 are the decimal value 584.
//
// IEEE-754 saves space by modifying these values: the value
// 01111 is always subtracted from the exponent bits (in our
// case, 10000 - 01111 = 1, so our exponent is 2^1) and our
// significand digits become the decimal value _after_ an
// implicit 1 (so 1.1001001000 or 1.5703125 in decimal)! This
// gives us:
//
//     2^1 * 1.5703125 = 3.140625
//
// Feel free to forget these implementation details immediately.
// The important thing to know is that floating point numbers are
// great at storing big and small values (f64 lets you work with
// numbers on the scale of the number of atoms in the universe),
// but digits may be rounded, leading to results which are less
// precise than integers.
//
// Fun fact: sometimes you'll see the significand labeled as a
// "mantissa" but Donald E. Knuth says not to do that.
//
// C compatibility fact: There is also a Zig floating point type
// specifically for working with C ABIs called c_longdouble.
