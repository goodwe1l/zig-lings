//
// The 'for' loop is not just limited to looping over one or two
// items. Let's try an example with a whole bunch!
// 'for' 循环不仅限于循环一个或两个项目。让我们尝试一个有很多项目的例子！
//
// But first, there's one last thing we've avoided mentioning
// until now: The special range that leaves off the last value:
// 但首先，有一件事我们到现在一直避免提及：省略最后值的特殊范围：
//
//     for ( things, 0.. ) |t, i| { ... }
//
// That's how we tell Zig that we want to get a numeric value for
// every item in "things", starting with 0.
// 这就是我们告诉 Zig 我们想要为 "things" 中的每个项目获取数值，从 0 开始。
//
// A nice feature of these index ranges is that you can have them
// start with any number you choose. The first value of "i" in
// this example will be 500, then 501, 502, etc.:
// 这些索引范围的一个好特性是您可以让它们从您选择的任何数字开始。
// 在此示例中，"i" 的第一个值将是 500，然后是 501、502 等：
//
//     for ( things, 500.. ) |t, i| { ... }
//
// Remember our RPG characters? They had the following
// properties, which we stored in a struct type:
// 还记得我们的 RPG 角色吗？它们有以下属性，我们将其存储在结构体类型中：
//
//     class
//     gold
//     experience
//
// What we're going to do now is store the same RPG character
// data, but in a separate array for each property.
// 我们现在要做的是存储相同的 RPG 角色数据，但每个属性使用单独的数组。
//
// It might look a little awkward, but let's bear with it.
// 这可能看起来有点笨拙，但让我们忍受一下。
//
// We've started writing a program to print a numbered list of
// characters with each of their properties, but it needs a
// little help:
// 我们已经开始编写一个程序来打印带有每个属性的角色编号列表，但它需要一点帮助：
//
const std = @import("std");
const print = std.debug.print;

// This is the same character role enum we've seen before.
const Role = enum {
    wizard,
    thief,
    bard,
    warrior,
};

pub fn main() void {
    // Here are the three "property" arrays:
    // 这里是三个"属性"数组：
    const roles = [4]Role{ .wizard, .bard, .bard, .warrior };
    const gold = [4]u16{ 25, 11, 5, 7392 };
    const experience = [4]u8{ 40, 17, 55, 21 };

    // We would like to number our list starting with 1, not 0.
    // How do we do that?
    // 我们希望我们的列表从 1 开始编号，而不是从 0 开始。我们该怎么做？
    for (roles, gold, experience, ???) |c, g, e, i| {
        const role_name = switch (c) {
            .wizard => "Wizard",
            .thief => "Thief",
            .bard => "Bard",
            .warrior => "Warrior",
        };

        std.debug.print("{d}. {s} (Gold: {d}, XP: {d})\n", .{
            i,
            role_name,
            g,
            e,
        });
    }
}
//
// By the way, storing our character data in arrays like this
// isn't *just* a silly way to demonstrate multi-object 'for'
// loops.
// 顺便说一下，像这样将我们的角色数据存储在数组中不仅仅是演示
// 多对象 'for' 循环的愚蠢方式。
//
// It's *also* a silly way to introduce a concept called
// "data-oriented design".
// 它也是介绍一个叫做"面向数据设计"概念的愚蠢方式。
//
// Let's use a metaphor to build up an intuition for what this is
// all about:
// 让我们使用一个比喻来建立对这个概念的直觉：
//
// Let's say you've been tasked with grabbing three glass
// marbles, three spoons, and three feathers from a magic bag.
// But you can't use your hands to grab them. Instead, you must
// use a marble scoop, spoon magnet, and feather tongs to grab
// each type of object.
// 假设您被要求从魔法袋中抓取三个玻璃弹珠、三个勺子和三根羽毛。
// 但您不能用手抓取它们。相反，您必须使用弹珠勺、勺子磁铁和羽毛钳
// 来抓取每种类型的物体。
//
// Now, would you rather use the magic bag:
// 现在，您更愿意使用魔法袋：
//
// A. Grouped the items in clusters so you have to pick up one
//    marble, then one spoon, then one feather?
// A. 将物品分组，这样您必须拿起一个弹珠，然后一个勺子，然后一根羽毛？
//
//    OR
//    或者
//
// B. Grouped the items by type so you can pick up all of the
//    marbles at once, then all the spoons, then all of the
//    feathers?
// B. 按类型分组物品，这样您可以一次拿起所有弹珠，然后所有勺子，
//    然后所有羽毛？
//
// If this metaphor is working, hopefully, it's clear that the 'B'
// option would be much more efficient.
// 如果这个比喻有效，希望很明显，'B' 选项会更高效得多。
//
// Well, it probably comes as little surprise that storing and
// using data in a sequential and uniform fashion is also more
// efficient for modern CPUs.
// 好吧，以顺序和统一的方式存储和使用数据对现代 CPU 来说也更高效，
// 这可能不足为奇。
//
// Decades of OOP practices have steered people towards grouping
// different data types together into mixed-type "objects" with
// the intent that these are easier on the human mind.
// Data-oriented design groups data by type in a way that is
// easier on the computer.
// 数十年的 OOP 实践引导人们将不同的数据类型组合到混合类型的"对象"中，
// 目的是这些对人类思维更容易。面向数据的设计按类型分组数据，
// 这对计算机来说更容易。
//
// With clever language design, maybe we can have both.
// 通过巧妙的语言设计，也许我们可以两者兼得。
//
// In the Zig community, you may see the difference in groupings
// presented with the terms "Array of Structs" (AoS) versus
// "Struct of Arrays" (SoA).
// 在 Zig 社区中，您可能会看到分组的差异用术语"结构体数组"(AoS)
// 与"数组结构体"(SoA)来表示。
//
// To envision these two designs in action, imagine an array of
// RPG character structs, each containing three different data
// types (AoS) versus a single RPG character struct containing
// three arrays of one data type each, like those in the exercise
// above (SoA).
// 要想象这两种设计的实际应用，想象一个 RPG 角色结构体数组，
// 每个包含三种不同的数据类型 (AoS)，相对于一个包含三个每种数据类型
// 一个数组的单一 RPG 角色结构体，就像上面练习中的那样 (SoA)。
//
// For a more practical application of "data-oriented design"
// watch the following talk from Andrew Kelley, the creator of Zig:
// https://vimeo.com/649009599
// 有关"面向数据设计"的更实际应用，请观看 Zig 创建者 Andrew Kelley 的演讲：
// https://vimeo.com/649009599
//
