//
// If you thought the last exercise was a deep dive, hold onto your
// 如果你认为上一个练习是深度探讨，那就抓紧了
// hat because we are about to descend into the computer's molten
// 因为我们即将下降到计算机的熔融
// core.
// 核心。
//
// (Shouting) DOWN HERE, THE BITS AND BYTES FLOW FROM RAM TO THE CPU
// （大喊）在这里，比特和字节从RAM流向CPU
// LIKE A HOT, DENSE FLUID. THE FORCES ARE INCREDIBLE. BUT HOW DOES
// 就像热的、稠密的流体。力量是不可思议的。但这一切
// ALL OF THIS RELATE TO THE DATA IN OUR ZIG PROGRAMS? LET'S HEAD
// 如何与我们Zig程序中的数据相关？让我们回到
// BACK UP TO THE TEXT EDITOR AND FIND OUT.
// 文本编辑器中找出答案。
//
// Ah, that's better. Now we can look at some familiar Zig code.
// 啊，这样好多了。现在我们可以看一些熟悉的Zig代码。
//
// @import() adds the imported code to your own. In this case, code
// @import()将导入的代码添加到你自己的代码中。在这种情况下，来自
// from the standard library is added to your program and compiled
// 标准库的代码会被添加到你的程序中并与它一起编译。
// with it. All of this will be loaded into RAM when it runs. Oh, and
// 所有这些在运行时都会被加载到RAM中。哦，我们命名的
// that thing we name "const std"? That's a struct!
// "const std"？那是一个结构体！
//
const std = @import("std");

// Remember our old RPG Character struct? A struct is really just a
// 还记得我们之前的RPG角色结构体吗？结构体实际上只是
// very convenient way to deal with memory. These fields (gold,
// 处理内存的一种非常方便的方式。这些字段（gold、
// health, experience) are all values of a particular size. Add them
// health、experience）都是特定大小的值。将它们加起来
// together and you have the size of the struct as a whole.
// 就得到了整个结构体的大小。

const Character = struct {
    gold: u32 = 0,
    health: u8 = 100,
    experience: u32 = 0,
};

// Here we create a character called "the_narrator" that is a constant
// 这里我们创建了一个名为"the_narrator"的角色，它是Character结构体的
// (immutable) instance of a Character struct. It is stored in your
// 常量（不可变）实例。它作为数据存储在你的程序中，
// program as data, and like the instruction code, it is loaded into
// 像指令代码一样，在程序运行时被加载到RAM中。
// RAM when your program runs. The relative location of this data in
// 这个数据在内存中的相对位置是硬编码的，
// memory is hard-coded and neither the address nor the value changes.
// 地址和值都不会改变。

const the_narrator = Character{
    .gold = 12,
    .health = 99,
    .experience = 9000,
};

// This "global_wizard" character is very similar. The address for
// 这个"global_wizard"角色非常相似。这个数据的地址
// this data won't change, but the data itself can since this is a var
// 不会改变，但数据本身可以改变，因为这是一个var
// and not a const.
// 而不是const。

var global_wizard = Character{};

// A function is instruction code at a particular address. Function
// 函数是特定地址的指令代码。Zig中的函数
// parameters in Zig are always immutable. They are stored in "the
// 参数总是不可变的。它们存储在"栈"中。
// stack". A stack is a type of data structure and "the stack" is a
// 栈是一种数据结构类型，"栈"是为你的程序
// specific bit of RAM reserved for your program. The CPU has special
// 保留的特定RAM区域。CPU对于在"栈"中
// support for adding and removing things from "the stack", so it is
// 添加和移除内容有特殊支持，所以它是
// an extremely efficient place for memory storage.
// 极其高效的内存存储位置。
//
// Also, when a function executes, the input arguments are often
// 另外，当函数执行时，输入参数通常被加载到
// loaded into the beating heart of the CPU itself in registers.
// CPU本身的跳动心脏——寄存器中。
//
// Our main() function here has no input parameters, but it will have
// 我们这里的main()函数没有输入参数，但它会有
// a stack entry (called a "frame").
// 一个栈条目（称为"帧"）。

pub fn main() void {

    // Here, the "glorp" character will be allocated on the stack
    // 这里，"glorp"角色将在栈上分配
    // because each instance of glorp is mutable and therefore unique
    // 因为glorp的每个实例都是可变的，因此对于
    // to the invocation of this function.
    // 这个函数的调用是唯一的。

    var glorp = Character{
        .gold = 30,
    };

    // The "reward_xp" value is interesting. It's an immutable
    // "reward_xp"值很有趣。它是一个不可变的
    // value, so even though it is local, it can be put in global
    // 值，所以即使它是局部的，也可以放在全局
    // data and shared between all invocations. But being such a
    // 数据中并在所有调用之间共享。但由于是如此
    // small value, it may also simply be inlined as a literal
    // 小的值，它也可能简单地作为字面量值
    // value in your instruction code where it is used.  It's up
    // 内联到使用它的指令代码中。这取决于
    // to the compiler.
    // 编译器。

    const reward_xp: u32 = 200;

    // Now let's circle back around to that "std" struct we imported
    // 现在让我们回到我们在顶部导入的"std"结构体。
    // at the top. Since it's just a regular Zig value once it's
    // 一旦导入，它就是一个常规的Zig值，
    // imported, we can also assign new names for its fields and
    // 我们也可以为它的字段和声明分配新名称。
    // declarations. "debug" refers to another struct and "print" is a
    // "debug"引用另一个结构体，"print"是一个
    // public function namespaced within THAT struct.
    // 在那个结构体内命名空间的公共函数。
    //
    // Let's assign the std.debug.print function to a const named
    // 让我们将std.debug.print函数分配给一个名为
    // "print" so that we can use this new name later!
    // "print"的常量，这样我们稍后可以使用这个新名称！

    const print = ???;

    // Now let's look at assigning and pointing to values in Zig.
    // 现在让我们看看在Zig中赋值和指向值。
    //
    // We'll try three different ways of making a new name to access
    // 我们将尝试三种不同的方式来创建一个新名称来访问
    // our glorp Character and change one of its values.
    // 我们的glorp角色并改变它的一个值。
    //
    // "glorp_access1" is incorrectly named! We asked Zig to set aside
    // "glorp_access1"命名不正确！我们要求Zig为另一个
    // memory for another Character struct. So when we assign glorp to
    // Character结构体留出内存。所以当我们将glorp赋值给
    // glorp_access1 here, we're actually assigning all of the fields
    // glorp_access1时，我们实际上是分配所有字段
    // to make a copy! Now we have two separate characters.
    // 来制作一个副本！现在我们有两个独立的角色。
    //
    // You don't need to fix this. But notice what gets printed in
    // 你不需要修复这个。但注意在你的程序输出中
    // your program's output for this one compared to the other two
    // 这个与下面其他两个赋值相比打印了什么！
    // assignments below!

    var glorp_access1: Character = glorp;
    glorp_access1.gold = 111;
    print("1:{}!. ", .{glorp.gold == glorp_access1.gold});

    // NOTE:
    // 注意：
    //
    //     If we tried to do this with a const Character instead of a
    //     如果我们尝试用const Character而不是var来做这件事，
    //     var, changing the gold field would give us a compiler error
    //     改变gold字段会给我们一个编译器错误，
    //     because const values are immutable!
    //     因为const值是不可变的！
    //
    // "glorp_access2" will do what we want. It points to the original
    // "glorp_access2"将做我们想要的事。它指向原始
    // glorp's address. Also remember that we get one implicit
    // glorp的地址。还记得我们对结构体字段有一个隐式
    // dereference with struct fields, so accessing the "gold" field
    // 解引用，所以从glorp_access2访问"gold"字段
    // from glorp_access2 looks just like accessing it from glorp
    // 看起来就像从glorp本身访问它一样。
    // itself.

    var glorp_access2: *Character = &glorp;
    glorp_access2.gold = 222;
    print("2:{}!. ", .{glorp.gold == glorp_access2.gold});

    // "glorp_access3" is interesting. It's also a pointer, but it's a
    // "glorp_access3"很有趣。它也是一个指针，但它是一个
    // const. Won't that disallow changing the gold value? No! As you
    // const。这不会禁止改变gold值吗？不会！正如你
    // may recall from our earlier pointer experiments, a constant
    // 可能从我们之前的指针实验中回忆的，一个常量
    // pointer can't change what it's POINTING AT, but the value at
    // 指针不能改变它指向的内容，但它指向的地址上的值
    // the address it points to is still mutable! So we CAN change it.
    // 仍然是可变的！所以我们可以改变它。

    const glorp_access3: *Character = &glorp;
    glorp_access3.gold = 333;
    print("3:{}!. ", .{glorp.gold == glorp_access3.gold});

    // NOTE:
    // 注意：
    //
    //     If we tried to do this with a *const Character pointer,
    //     如果我们尝试用*const Character指针来做这件事，
    //     that would NOT work and we would get a compiler error
    //     那将不起作用，我们会得到一个编译器错误，
    //     because the VALUE becomes immutable!
    //     因为值变成了不可变的！
    //
    // Moving along...
    // 继续...
    //
    // When arguments are passed to a function,
    // 当参数传递给函数时，
    // they are ALWAYS passed as constants within the function,
    // 它们在函数内总是作为常量传递，
    // regardless of how they were declared in the calling function.
    // 无论它们在调用函数中是如何声明的。
    //
    // Example:
    // 例子：
    // fn foo(arg: u8) void {
    //    arg = 42; // Error, 'arg' is const!
    //    arg = 42; // 错误，'arg'是const！
    // }
    //
    // fn bar() void {
    //    var arg: u8 = 12;
    //    foo(arg);
    //    ...
    // }
    //
    // Knowing this, see if you can make levelUp() work as expected -
    // 知道这一点，看看你是否能让levelUp()按预期工作 -
    // it should add the specified amount to the supplied character's
    // 它应该将指定的数量添加到提供的角色的
    // experience points.
    // 经验点数中。
    //
    print("XP before:{}, ", .{glorp.experience});

    // Fix 1 of 2 goes here:
    // 修复1/2在这里：
    levelUp(glorp, reward_xp);

    print("after:{}.\n", .{glorp.experience});
}

// Fix 2 of 2 goes here:
// 修复2/2在这里：
fn levelUp(character_access: Character, xp: u32) void {
    character_access.experience += xp;
}

// And there's more!
// 还有更多！
//
// Data segments (allocated at compile time) and "the stack"
// 数据段（在编译时分配）和"栈"
// (allocated at run time) aren't the only places where program data
// （在运行时分配）不是程序数据可以存储在内存中的
// can be stored in memory. They're just the most efficient. Sometimes
// 唯一地方。它们只是最高效的。有时
// we don't know how much memory our program will need until the
// 我们直到程序运行时才知道程序需要多少内存。
// program is running. Also, there is a limit to the size of stack
// 另外，分配给程序的栈内存大小有限制
// memory allotted to programs (often set by your operating system).
// （通常由你的操作系统设置）。
// For these occasions, we have "the heap".
// 对于这些场合，我们有"堆"。
//
// You can use as much heap memory as you like (within physical
// 你可以使用你喜欢的任意多的堆内存（在物理
// limitations, of course), but it's much less efficient to manage
// 限制内，当然），但管理起来效率要低得多，
// because there is no built-in CPU support for adding and removing
// 因为没有像栈那样的CPU内建支持来添加和移除
// items as we have with the stack. Also, depending on the type of
// 项目。另外，根据分配的类型，
// allocation, your program MAY have to do expensive work to manage
// 你的程序可能必须做昂贵的工作来管理
// the use of heap memory. We'll learn about heap allocators later.
// 堆内存的使用。我们稍后会学习堆分配器。
//
// Whew! This has been a lot of information. You'll be pleased to know
// 呼！这是很多信息。你会高兴地知道
// that the next exercise gets us back to learning Zig language
// 下一个练习让我们回到学习Zig语言特性，
// features we can use right away to do more things!
// 我们可以立即使用它们来做更多事情！
