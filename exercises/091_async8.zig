//
// You have doubtless noticed that 'suspend' requires a block
// expression like so:
// 您无疑已经注意到 'suspend' 需要一个块表达式，如下所示：
//
//     suspend {}
//
// The suspend block executes when a function suspends. To get
// sense for when this happens, please make the following
// program print the string
// 挂起块在函数挂起时执行。为了了解何时发生这种情况，请让以下程序打印字符串
//
//     "ABCDEF"
//
const print = @import("std").debug.print;

pub fn main() void {
    print("A", .{});

    var frame = async suspendable();

    print("X", .{});

    resume frame;

    print("F", .{});
}

fn suspendable() void {
    print("X", .{});

    suspend {
        print("X", .{});
    }

    print("X", .{});
}
