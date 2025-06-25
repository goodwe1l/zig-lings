//
// Zig has builtins for mathematical operations such as...
// Zig 具有用于数学运算的内置函数，例如...
//
//      @sqrt        @sin           @cos
//      @exp         @log           @floor
//
// ...and lots of type casting operations such as...
// ...以及许多类型转换操作，例如...
//
//      @as          @errorFromInt  @floatFromInt
//      @ptrFromInt  @intFromPtr    @intFromEnum
//
// Spending part of a rainy day skimming through the complete
// list of builtins in the official Zig documentation wouldn't be
// a bad use of your time. There are some seriously cool features
// in there. Check out @call, @compileLog, @embedFile, and @src!
// 在雨天花一部分时间浏览官方 Zig 文档中的完整内置函数列表
// 不会浪费你的时间。那里有一些非常酷的功能。
// 查看 @call、@compileLog、@embedFile 和 @src！
//
//                            ...
//
// For now, we're going to complete our examination of builtins
// by exploring just THREE of Zig's MANY introspection abilities:
// 现在，我们将通过探索 Zig 的众多内省能力中的三个来完成对内置函数的研究：
//
// 1. @This() type
//
// Returns the innermost struct, enum, or union that a function
// call is inside.
// 返回函数调用所在的最内层的结构体、枚举或联合。
//
// 2. @typeInfo(comptime T: type) @import("std").builtin.Type
//
// Returns information about any type in a data structure which
// will contain different information depending on which type
// you're examining.
// 返回有关任何类型的信息，在数据结构中包含的信息会根据你正在检查的类型而不同。
//
// 3. @TypeOf(...) type
//
// Returns the type common to all input parameters (each of which
// may be any expression). The type is resolved using the same
// "peer type resolution" process the compiler itself uses when
// inferring types.
// 返回所有输入参数的公共类型（每个参数可以是任何表达式）。
// 类型使用编译器在推断类型时使用的相同"对等类型解析"过程来解析。
//
// (Notice how the two functions which return types start with
// uppercase letters? This is a standard naming practice in Zig.)
// （注意返回类型的两个函数如何以大写字母开头？这是 Zig 中的标准命名惯例。）
//
const print = @import("std").debug.print;

const Narcissus = struct {
    me: *Narcissus = undefined,
    myself: *Narcissus = undefined,
    echo: void = undefined, // Alas, poor Echo!

    fn fetchTheMostBeautifulType() type {
        return @This();
    }
};

pub fn main() void {
    var narcissus: Narcissus = Narcissus{};

    // Oops! We cannot leave the 'me' and 'myself' fields
    // undefined. Please set them here:
    // 哎呀！我们不能让 'me' 和 'myself' 字段保持未定义。请在这里设置它们：
    narcissus.me = &narcissus;
    narcissus.??? = ???;

    // This determines a "peer type" from three separate
    // references (they just happen to all be the same object).
    // 这从三个单独的引用中确定一个"对等类型"（它们恰好都是同一个对象）。
    const Type1 = @TypeOf(narcissus, narcissus.me.*, narcissus.myself.*);

    // Oh dear, we seem to have done something wrong when calling
    // this function. We called it as a method, which would work
    // if it had a self parameter. But it doesn't. (See above.)
    //
    // The fix for this is very subtle, but it makes a big
    // difference!
    // 哦，天哪，我们在调用这个函数时似乎做错了什么。我们将它称为方法，
    // 如果它有一个 self 参数，这会起作用。但它没有。（见上文。）
    //
    // 这个修复非常微妙，但它产生了很大的不同！
    const Type2 = narcissus.fetchTheMostBeautifulType();

    // Now we print a pithy statement about Narcissus.
    // 现在我们打印一个关于纳西索斯的精辟陈述。
    print("A {s} loves all {s}es. ", .{
        maximumNarcissism(Type1),
        maximumNarcissism(Type2),
    });

    //   His final words as he was looking in
    //   those waters he habitually watched
    //   were these:
    //       "Alas, my beloved boy, in vain!"
    //   The place gave every word back in reply.
    //   He cried:
    //            "Farewell."
    //   And Echo called:
    //                   "Farewell!"
    //
    //     --Ovid, The Metamorphoses
    //       translated by Ian Johnston

    print("He has room in his heart for:", .{});

    // A StructFields array
    // 一个 StructFields 数组
    const fields = @typeInfo(Narcissus).@"struct".fields;

    // 'fields' is a slice of StructFields. Here's the declaration:
    // 'fields' 是 StructFields 的切片。这是声明：
    //
    //     pub const StructField = struct {
    //         name: []const u8,
    //         type: type,
    //         default_value: anytype,
    //         is_comptime: bool,
    //         alignment: comptime_int,
    //     };
    //
    // Please complete these 'if' statements so that the field
    // name will not be printed if the field is of type 'void'
    // (which is a zero-bit type that takes up no space at all!):
    // 请完成这些 'if' 语句，以便如果字段是 'void' 类型
    // （这是一个不占用任何空间的零位类型！），则不会打印字段名称：
    if (fields[0].??? != void) {
        print(" {s}", .{fields[0].name});
    }

    if (fields[1].??? != void) {
        print(" {s}", .{fields[1].name});
    }

    if (fields[2].??? != void) {
        print(" {s}", .{fields[2].name});
    }

    // Yuck, look at all that repeated code above! I don't know
    // about you, but it makes me itchy.
    //
    // Alas, we can't use a regular 'for' loop here because
    // 'fields' can only be evaluated at compile time.  It seems
    // like we're overdue to learn about this "comptime" stuff,
    // doesn't it? Don't worry, we'll get there.
    // 呃，看看上面所有重复的代码！我不知道你的想法，但它让我感到不舒服。
    //
    // 唉，我们不能在这里使用常规的 'for' 循环，因为 'fields' 只能在编译时评估。
    // 看起来我们早就应该学习这个"comptime"的东西了，不是吗？别担心，我们会学到的。

    print(".\n", .{});
}

// NOTE: This exercise did not originally include the function below.
// But a change after Zig 0.10.0 added the source file name to the
// type. "Narcissus" became "065_builtins2.Narcissus".
//
// To fix this, we've added this function to strip the filename from
// the front of the type name. (It returns a slice of the type name
// starting at the index + 1 of character ".")
//
// We'll be seeing @typeName again in Exercise 070. For now, you can
// see that it takes a Type and returns a u8 "string".
// 注意：这个练习最初不包括下面的函数。
// 但是 Zig 0.10.0 之后的更改将源文件名添加到类型中。
// "Narcissus" 变成了 "065_builtins2.Narcissus"。
//
// 为了解决这个问题，我们添加了这个函数来从类型名称的前面剥离文件名。
// （它返回从字符 "." 的索引 + 1 开始的类型名称切片）
//
// 我们将在练习 070 中再次看到 @typeName。现在，你可以看到它接受一个 Type 并返回一个 u8 "字符串"。
fn maximumNarcissism(myType: anytype) []const u8 {
    const indexOf = @import("std").mem.indexOf;

    // Turn "065_builtins2.Narcissus" into "Narcissus"
    // 将 "065_builtins2.Narcissus" 转换为 "Narcissus"
    const name = @typeName(myType);
    return name[indexOf(u8, name, ".").? + 1 ..];
}
