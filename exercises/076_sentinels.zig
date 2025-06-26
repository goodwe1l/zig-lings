//
// A sentinel value indicates the end of data. Let's imagine a
// sequence of lowercase letters where uppercase 'S' is the
// sentinel, indicating the end of the sequence:
// 哨兵值表示数据的结束。让我们想象一个小写字母序列，其中大写的 'S' 是哨兵，
// 表示序列的结束：
//
//     abcdefS
//
// If our sequence also allows for uppercase letters, 'S' would
// make a terrible sentinel since it could no longer be a regular
// value in the sequence:
// 如果我们的序列也允许大写字母，'S' 将是一个糟糕的哨兵，
// 因为它不再是序列中的常规值：
//
//     abcdQRST
//          ^-- Oops! The last letter in the sequence is R!
//          ^-- 哎呀！序列中的最后一个字母是 R！
//
// A popular choice for indicating the end of a string is the
// value 0. ASCII and Unicode call this the "Null Character".
// 表示字符串结束的一个流行选择是值 0。ASCII 和 Unicode 称之为"空字符"。
//
// Zig supports sentinel-terminated arrays, slices, and pointers:
// Zig 支持哨兵终止的数组、切片和指针：
//
//     const a: [4:0]u32       =  [4:0]u32{1, 2, 3, 4};
//     const b: [:0]const u32  = &[4:0]u32{1, 2, 3, 4};
//     const c: [*:0]const u32 = &[4:0]u32{1, 2, 3, 4};
//
// Array 'a' stores 5 u32 values, the last of which is 0.
// However the compiler takes care of this housekeeping detail
// for you. You can treat 'a' as a normal array with just 4
// items.
// 数组 'a' 存储 5 个 u32 值，最后一个是 0。但是编译器为您处理这个内务管理细节。
// 您可以将 'a' 视为只有 4 个项目的普通数组。
//
// Slice 'b' is only allowed to point to zero-terminated arrays
// but otherwise works just like a normal slice.
// 切片 'b' 只允许指向零终止的数组，但在其他方面就像普通切片一样工作。
//
// Pointer 'c' is exactly like the many-item pointers we learned
// about in exercise 054, but it is guaranteed to end in 0.
// Because of this guarantee, we can safely find the end of this
// many-item pointer without knowing its length. (We CAN'T do
// that with regular many-item pointers!).
// 指针 'c' 完全像我们在练习 054 中学到的多项指针，但它保证以 0 结束。
// 由于这个保证，我们可以安全地找到这个多项指针的末尾而不知道其长度。
// （我们不能对常规多项指针这样做！）。
//
// Important: the sentinel value must be of the same type as the
// data being terminated!
// 重要：哨兵值必须与被终止的数据具有相同的类型！
//
const print = @import("std").debug.print;
const sentinel = @import("std").meta.sentinel;

pub fn main() void {
    // Here's a zero-terminated array of u32 values:
    // 这是一个以零终止的 u32 值数组：
    var nums = [_:0]u32{ 1, 2, 3, 4, 5, 6 };

    // And here's a zero-terminated many-item pointer:
    // 这是一个以零终止的多项指针：
    const ptr: [*:0]u32 = &nums;

    // For fun, let's replace the value at position 3 with the
    // sentinel value 0. This seems kind of naughty.
    // 为了好玩，让我们将位置 3 的值替换为哨兵值 0。这似乎有点顽皮。
    nums[3] = 0;

    // So now we have a zero-terminated array and a many-item
    // pointer that reference the same data: a sequence of
    // numbers that both ends in and CONTAINS the sentinel value.
    // 所以现在我们有一个零终止数组和一个多项指针，它们引用相同的数据：
    // 一个数字序列，既以哨兵值结束又包含哨兵值。
    //
    // Attempting to loop through and print both of these should
    // demonstrate how they are similar and different.
    // 尝试循环遍历并打印这两个应该演示它们如何相似和不同。
    //
    // (It turns out that the array prints completely, including
    // the sentinel 0 in the middle. The many-item pointer stops
    // at the first sentinel value.)
    // （事实证明，数组完全打印，包括中间的哨兵 0。多项指针在第一个哨兵值处停止。）
    printSequence(nums);
    printSequence(ptr);

    print("\n", .{});
}

// Here's our generic sequence printing function. It's nearly
// complete, but there are a couple of missing bits. Please fix
// them!
// 这是我们的通用序列打印函数。它几乎完成了，但有几个缺失的部分。请修复它们！
fn printSequence(my_seq: anytype) void {
    const my_typeinfo = @typeInfo(@TypeOf(my_seq));

    // The TypeInfo contained in my_typeinfo is a union. We use
    // a switch to handle printing the Array or Pointer fields,
    // depending on which type of my_seq was passed in:
    // my_typeinfo 中包含的 TypeInfo 是一个联合体。我们使用 switch 来处理打印
    // Array 或 Pointer 字段，这取决于传入的 my_seq 的类型：
    switch (my_typeinfo) {
        .array => {
            print("Array:", .{});

            // Loop through the items in my_seq.
            // 循环遍历 my_seq 中的项目。
            for (???) |s| {
                print("{}", .{s});
            }
        },
        .pointer => {
            // Check this out - it's pretty cool:
            // 看看这个 - 非常酷：
            const my_sentinel = sentinel(@TypeOf(my_seq));
            print("Many-item pointer:", .{});

            // Loop through the items in my_seq until we hit the
            // sentinel value.
            // 循环遍历 my_seq 中的项目，直到我们遇到哨兵值。
            var i: usize = 0;
            while (??? != my_sentinel) {
                print("{}", .{my_seq[i]});
                i += 1;
            }
        },
        else => unreachable,
    }
    print(". ", .{});
}
