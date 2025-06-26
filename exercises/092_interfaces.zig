//
// Remember our ant and bee simulator constructed with unions
// back in exercises 55 and 56? There, we demonstrated that
// unions allow us to treat different data types in a uniform
// manner.
// 还记得我们在练习 55 和 56 中用联合体构建的蚂蚁和蜜蜂模拟器吗？
// 在那里，我们演示了联合体允许我们以统一的方式处理不同的数据类型。
//
// One neat feature was using tagged unions to create a single
// function to print a status for ants *or* bees by switching:
// 一个巧妙的功能是使用标记联合体创建一个单一函数，
// 通过切换来打印蚂蚁或蜜蜂的状态：
//
//   switch (insect) {
//      .still_alive => ...      // (print ant stuff)
//      .flowers_visited => ...  // (print bee stuff)
//   }
//
// Well, that simulation was running just fine until a new insect
// arrived in the virtual garden, a grasshopper!
// 好吧，这个模拟运行得很好，直到一个新的昆虫来到虚拟花园——蚱蜢！
//
// Doctor Zoraptera started to add grasshopper code to the
// program, but then she backed away from her keyboard with an
// angry hissing sound. She had realized that having code for
// each insect in one place and code to print each insect in
// another place was going to become unpleasant to maintain when
// the simulation expanded to hundreds of different insects.
// Zoraptera 博士开始向程序中添加蚱蜢代码，但随后她愤怒地嘶嘶作响，
// 退离了键盘。她意识到当模拟扩展到数百种不同昆虫时，
// 将每种昆虫的代码放在一个地方，打印每种昆虫的代码放在另一个地方
// 将变得难以维护。
//
// Thankfully, Zig has another comptime feature we can use
// to get out of this dilemma called the 'inline else'.
// 幸运的是，Zig 有另一个编译时功能可以帮助我们摆脱这种困境，
// 叫做 'inline else'。
//
// We can replace this redundant code:
// 我们可以替换这种冗余代码：
//
//   switch (thing) {
//       .a => |a| special(a),
//       .b => |b| normal(b),
//       .c => |c| normal(c),
//       .d => |d| normal(d),
//       .e => |e| normal(e),
//       ...
//   }
//
// With:
// 用：
//
//   switch (thing) {
//       .a => |a| special(a),
//       inline else => |t| normal(t),
//   }
//
// We can have special handling of some cases and then Zig
// handles the rest of the matches for us.
// 我们可以特殊处理某些情况，然后 Zig 为我们处理其余的匹配。
//
// With this feature, you decide to make an Insect union with a
// single uniform 'print()' function. All of the insects can
// then be responsible for printing themselves. And Doctor
// Zoraptera can calm down and stop gnawing on the furniture.
// 使用此功能，您决定创建一个带有单一统一 'print()' 函数的 Insect 联合体。
// 所有昆虫都可以负责打印自己。Zoraptera 博士可以冷静下来，
// 不再啃咬家具。
//
const std = @import("std");

const Ant = struct {
    still_alive: bool,

    pub fn print(self: Ant) void {
        std.debug.print("Ant is {s}.\n", .{if (self.still_alive) "alive" else "dead"});
    }
};

const Bee = struct {
    flowers_visited: u16,

    pub fn print(self: Bee) void {
        std.debug.print("Bee visited {} flowers.\n", .{self.flowers_visited});
    }
};

// Here's the new grasshopper. Notice how we've also added print
// methods to each insect.
// 这是新的蚱蜢。注意我们也为每个昆虫添加了 print 方法。
const Grasshopper = struct {
    distance_hopped: u16,

    pub fn print(self: Grasshopper) void {
        std.debug.print("Grasshopper hopped {} meters.\n", .{self.distance_hopped});
    }
};

const Insect = union(enum) {
    ant: Ant,
    bee: Bee,
    grasshopper: Grasshopper,

    // Thanks to 'inline else', we can think of this print() as
    // being an interface method. Any member of this union with
    // a print() method can be treated uniformly by outside
    // code without needing to know any other details. Cool!
    // 感谢 'inline else'，我们可以将这个 print() 视为接口方法。
    // 这个联合体的任何具有 print() 方法的成员都可以被外部代码统一处理，
    // 而无需了解任何其他细节。酷！
    pub fn print(self: Insect) void {
        switch (self) {
            inline else => |case| return case.print(),
        }
    }
};

pub fn main() !void {
    const my_insects = [_]Insect{
        Insect{ .ant = Ant{ .still_alive = true } },
        Insect{ .bee = Bee{ .flowers_visited = 17 } },
        Insect{ .grasshopper = Grasshopper{ .distance_hopped = 32 } },
    };

    std.debug.print("Daily Insect Report:\n", .{});
    for (my_insects) |insect| {
        // Almost done! We want to print() each insect with a
        // single method call here.
        // 快完成了！我们想在这里用一个方法调用来 print() 每个昆虫。
        ???
    }
}

// Our print() method in the Insect union above demonstrates
// something very similar to the object-oriented concept of an
// abstract data type. That is, the Insect type doesn't contain
// the underlying data, and the print() function doesn't
// actually do the printing.
// 上面 Insect 联合体中的 print() 方法演示了与面向对象的
// 抽象数据类型概念非常相似的东西。也就是说，Insect 类型不包含
// 底层数据，print() 函数实际上不执行打印。
//
// The point of an interface is to support generic programming:
// the ability to treat different things as if they were the
// same to cut down on clutter and conceptual complexity.
// 接口的意义在于支持泛型编程：将不同的东西视为相同的能力，
// 以减少混乱和概念复杂性。
//
// The Daily Insect Report doesn't need to worry about *which*
// insects are in the report - they all print the same way via
// the interface!
// 昆虫日报不需要担心报告中有哪些昆虫——
// 它们都通过接口以相同的方式打印！
//
// Doctor Zoraptera loves it.
// Zoraptera 博士喜欢它。
