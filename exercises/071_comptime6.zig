//
// There have been several instances where it would have been
// nice to use loops in our programs, but we couldn't because the
// things we were trying to do could only be done at compile
// time. We ended up having to do those things MANUALLY, like
// NORMAL people. Bah! We are PROGRAMMERS! The computer should be
// doing this work.
// 有几次我们希望在程序中使用循环，但我们不能，因为我们试图做的事情只能在编译时完成。
// 我们最终不得不像普通人一样手动完成这些事情。呸！我们是程序员！
// 计算机应该做这个工作。
//
// An 'inline for' is performed at compile time, allowing you to
// programmatically loop through a series of items in situations
// like those mentioned above where a regular runtime 'for' loop
// wouldn't be allowed:
// 'inline for' 在编译时执行，允许您在上述情况下以编程方式循环遍历一系列项目，
// 在这些情况下不允许使用常规的运行时 'for' 循环：
//
//     inline for (.{ u8, u16, u32, u64 }) |T| {
//         print("{} ", .{@typeInfo(T).Int.bits});
//     }
//
// In the above example, we're looping over a list of types,
// which are available only at compile time.
// 在上面的例子中，我们正在循环遍历一个类型列表，这些类型只在编译时可用。
//
const print = @import("std").debug.print;

// Remember Narcissus from exercise 065 where we used builtins
// for reflection? He's back and loving it.
// 还记得练习 065 中我们使用内置函数进行反射的 Narcissus 吗？他回来了，很喜欢这样。
const Narcissus = struct {
    me: *Narcissus = undefined,
    myself: *Narcissus = undefined,
    echo: void = undefined,
};

pub fn main() void {
    print("Narcissus has room in his heart for:", .{});

    // Last time we examined the Narcissus struct, we had to
    // manually access each of the three fields. Our 'if'
    // statement was repeated three times almost verbatim. Yuck!
    // 上次我们检查 Narcissus 结构体时，我们必须手动访问三个字段中的每一个。
    // 我们的 'if' 语句几乎逐字重复了三次。讨厌！
    //
    // Please use an 'inline for' to implement the block below
    // for each field in the slice 'fields'!
    // 请使用 'inline for' 为切片 'fields' 中的每个字段实现下面的块！

    const fields = @typeInfo(Narcissus).@"struct".fields;

    ??? {
        if (field.type != void) {
            print(" {s}", .{field.name});
        }
    }

    // Once you've got that, go back and take a look at exercise
    // 065 and compare what you've written to the abomination we
    // had there!
    // 完成后，回去看看练习 065，比较您所写的和我们在那里的恶心代码！
    // had there!

    print(".\n", .{});
}
