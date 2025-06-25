//
// We've absorbed a lot of information about the variations of types
// 我们已经吸收了很多关于Zig中可以使用的类型变化的信息。
// we can use in Zig. Roughly, in order we have:
// 大致上，按顺序我们有：
//
//                          u8  single item
//                          u8  单个项目
//                         *u8  single-item pointer
//                         *u8  单项指针
//                        []u8  slice (size known at runtime)
//                        []u8  切片（运行时已知大小）
//                       [5]u8  array of 5 u8s
//                       [5]u8  5个u8的数组
//                       [*]u8  many-item pointer (zero or more)
//                       [*]u8  多项指针（零个或更多）
//                 enum {a, b}  set of unique values a and b
//                 enum {a, b}  唯一值a和b的集合
//                error {e, f}  set of unique error values e and f
//                error {e, f}  唯一错误值e和f的集合
//      struct {y: u8, z: i32}  group of values y and z
//      struct {y: u8, z: i32}  值y和z的组
// union(enum) {a: u8, b: i32}  single value either u8 or i32
// union(enum) {a: u8, b: i32}  单一值，要么是u8要么是i32
//
// Values of any of the above types can be assigned as "var" or "const"
// 上述任何类型的值都可以被赋值为"var"或"const"
// to allow or disallow changes (mutability) via the assigned name:
// 来允许或禁止通过赋值名称进行更改（可变性）：
//
//     const a: u8 = 5; // immutable
//     const a: u8 = 5; // 不可变
//       var b: u8 = 5; //   mutable
//       var b: u8 = 5; //   可变
//
// We can also make error unions or optional types from any of
// 我们也可以从上述任何类型制作错误联合或可选类型：
// the above:
//
//     var a: E!u8 = 5; // can be u8 or error from set E
//     var a: E!u8 = 5; // 可以是u8或来自集合E的错误
//     var b: ?u8 = 5;  // can be u8 or null
//     var b: ?u8 = 5;  // 可以是u8或null
//
// Knowing all of this, maybe we can help out a local hermit. He made
// 了解了所有这些，也许我们可以帮助一个当地的隐士。他制作了
// a little Zig program to help him plan his trips through the woods,
// 一个小的Zig程序来帮助他规划穿越森林的旅行，
// but it has some mistakes.
// 但它有一些错误。
//
// *************************************************************
// *                A NOTE ABOUT THIS EXERCISE                 *
// *                  关于这个练习的说明                        *
// *                                                           *
// * You do NOT have to read and understand every bit of this  *
// * 你不必阅读和理解这个程序的每一个细节。                     *
// * program. This is a very big example. Feel free to skim    *
// * 这是一个非常大的例子。随意浏览它，                         *
// * through it and then just focus on the few parts that are  *
// * 然后只关注实际有问题的几个部分！                           *
// * actually broken!                                          *
// *                                                           *
// *************************************************************
//
const print = @import("std").debug.print;

// The grue is a nod to Zork.
// grue是对Zork的致敬。
const TripError = error{ Unreachable, EatenByAGrue };

// Let's start with the Places on the map. Each has a name and a
// 让我们从地图上的地点开始。每个都有一个名称和
// distance or difficulty of travel (as judged by the hermit).
// 旅行的距离或难度（由隐士判断）。
//
// Note that we declare the places as mutable (var) because we need to
// 注意我们将地点声明为可变的（var），因为我们需要
// assign the paths later. And why is that? Because paths contain
// 稍后分配路径。为什么这样？因为路径包含
// pointers to places and assigning them now would create a dependency
// 指向地点的指针，现在分配它们会创建一个依赖
// loop!
// 循环！
const Place = struct {
    name: []const u8,
    paths: []const Path = undefined,
};

var a = Place{ .name = "Archer's Point" };
var b = Place{ .name = "Bridge" };
var c = Place{ .name = "Cottage" };
var d = Place{ .name = "Dogwood Grove" };
var e = Place{ .name = "East Pond" };
var f = Place{ .name = "Fox Pond" };

//           The hermit's hand-drawn ASCII map
//             隐士手绘的ASCII地图
//  +---------------------------------------------------+
//  |         * Archer's Point                ~~~~      |
//  | ~~~                              ~~~~~~~~         |
//  |   ~~~| |~~~~~~~~~~~~      ~~~~~~~                 |
//  |         Bridge     ~~~~~~~~                       |
//  |  ^             ^                           ^      |
//  |     ^ ^                      / \                  |
//  |    ^     ^  ^       ^        |_| Cottage          |
//  |   Dogwood Grove                                   |
//  |                  ^     <boat>                     |
//  |  ^  ^  ^  ^          ~~~~~~~~~~~~~    ^   ^       |
//  |      ^             ~~ East Pond ~~~               |
//  |    ^    ^   ^       ~~~~~~~~~~~~~~                |
//  |                           ~~          ^           |
//  |           ^            ~~~ <-- short waterfall    |
//  |   ^                 ~~~~~                         |
//  |            ~~~~~~~~~~~~~~~~~                      |
//  |          ~~~~ Fox Pond ~~~~~~~    ^         ^     |
//  |      ^     ~~~~~~~~~~~~~~~           ^ ^          |
//  |                ~~~~~                              |
//  +---------------------------------------------------+
//
// We'll be reserving memory in our program based on the number of
// 我们将根据地图上的地点数量在程序中保留内存。
// places on the map. Note that we do not have to specify the type of
// 注意我们不必指定这个值的类型，因为一旦编译完成，
// this value because we don't actually use it in our program once
// 我们实际上在程序中不使用它！
// it's compiled! (Don't worry if this doesn't make sense yet.)
// （如果现在还不理解，不要担心。）
const place_count = 6;

// Now let's create all of the paths between sites. A path goes from
// 现在让我们创建所有地点之间的路径。路径从
// one place to another and has a distance.
// 一个地点到另一个地点，并有距离。
const Path = struct {
    from: *const Place,
    to: *const Place,
    dist: u8,
};

// By the way, if the following code seems like a lot of tedious
// 顺便说一下，如果下面的代码看起来像很多繁琐的
// manual labor, you're right! One of Zig's killer features is letting
// 手工劳动，你说得对！Zig的杀手级特性之一是让
// us write code that runs at compile time to "automate" repetitive
// 我们编写在编译时运行的代码来"自动化"重复性
// code (much like macros in other languages), but we haven't learned
// 代码（很像其他语言中的宏），但我们还没有学会
// how to do that yet!
// 如何做到这一点！
const a_paths = [_]Path{
    Path{
        .from = &a, // from: Archer's Point
        .to = &b, //   to: Bridge
        .dist = 2,
    },
};

const b_paths = [_]Path{
    Path{
        .from = &b, // from: Bridge
        .to = &a, //   to: Archer's Point
        .dist = 2,
    },
    Path{
        .from = &b, // from: Bridge
        .to = &d, //   to: Dogwood Grove
        .dist = 1,
    },
};

const c_paths = [_]Path{
    Path{
        .from = &c, // from: Cottage
        .to = &d, //   to: Dogwood Grove
        .dist = 3,
    },
    Path{
        .from = &c, // from: Cottage
        .to = &e, //   to: East Pond
        .dist = 2,
    },
};

const d_paths = [_]Path{
    Path{
        .from = &d, // from: Dogwood Grove
        .to = &b, //   to: Bridge
        .dist = 1,
    },
    Path{
        .from = &d, // from: Dogwood Grove
        .to = &c, //   to: Cottage
        .dist = 3,
    },
    Path{
        .from = &d, // from: Dogwood Grove
        .to = &f, //   to: Fox Pond
        .dist = 7,
    },
};

const e_paths = [_]Path{
    Path{
        .from = &e, // from: East Pond
        .to = &c, //   to: Cottage
        .dist = 2,
    },
    Path{
        .from = &e, // from: East Pond
        .to = &f, //   to: Fox Pond
        .dist = 1, // (one-way down a short waterfall!)
        .dist = 1, // （单向下一个小瀑布！）
    },
};

const f_paths = [_]Path{
    Path{
        .from = &f, // from: Fox Pond
        .to = &d, //   to: Dogwood Grove
        .dist = 7,
    },
};

// Once we've plotted the best course through the woods, we'll make a
// 一旦我们规划出穿越森林的最佳路线，我们将制作一个
// "trip" out of it. A trip is a series of Places connected by Paths.
// "旅行"。旅行是由路径连接的一系列地点。
// We use a TripItem union to allow both Places and Paths to be in the
// 我们使用TripItem联合来允许地点和路径都在
// same array.
// 同一个数组中。
const TripItem = union(enum) {
    place: *const Place,
    path: *const Path,

    // This is a little helper function to print the two different
    // 这是一个小的辅助函数来正确打印两种不同
    // types of item correctly.
    // 类型的项目。
    fn printMe(self: TripItem) void {
        switch (self) {
            // Oops! The hermit forgot how to capture the union values
            // 哎呀！隐士忘记了如何在switch语句中捕获联合值。
            // in a switch statement. Please capture each value as
            // 请将每个值捕获为'p'，这样打印语句就能工作！
            // 'p' so the print statements work!
            .place => print("{s}", .{p.name}),
            .path => print("--{}->", .{p.dist}),
        }
    }
};

// The Hermit's Notebook is where all the magic happens. A notebook
// 隐士的笔记本是所有魔法发生的地方。笔记本
// entry is a Place discovered on the map along with the Path taken to
// 条目是在地图上发现的地点，以及到达那里所采取的路径
// get there and the distance to reach it from the start point. If we
// 和从起始点到达它的距离。如果我们找到一条更好的路径
// find a better Path to reach a Place (shorter distance), we update the
// （更短的距离）来到达一个地点，我们会更新
// entry. Entries also serve as a "todo" list which is how we keep
// 条目。条目还用作"待办"列表，这是我们跟踪
// track of which paths to explore next.
// 下一步要探索哪些路径的方式。
const NotebookEntry = struct {
    place: *const Place,
    coming_from: ?*const Place,
    via_path: ?*const Path,
    dist_to_reach: u16,
};

// +------------------------------------------------+
// |              ~ Hermit's Notebook ~             |
// +---+----------------+----------------+----------+
// |   |      Place     |      From      | Distance |
// +---+----------------+----------------+----------+
// | 0 | Archer's Point | null           |        0 |
// | 1 | Bridge         | Archer's Point |        2 | < next_entry
// | 2 | Dogwood Grove  | Bridge         |        1 |
// | 3 |                |                |          | < end_of_entries
// |                      ...                       |
// +---+----------------+----------------+----------+
//
const HermitsNotebook = struct {
    // Remember the array repetition operator `**`? It is no mere
    // 还记得数组重复操作符`**`吗？它不仅仅是
    // novelty, it's also a great way to assign multiple items in an
    // 新奇的东西，它也是在数组中分配多个项目的好方法，
    // array without having to list them one by one. Here we use it to
    // 而不必一个一个地列出它们。这里我们用它来
    // initialize an array with null values.
    // 用null值初始化数组。
    entries: [place_count]?NotebookEntry = .{null} ** place_count,

    // The next entry keeps track of where we are in our "todo" list.
    // 下一个条目跟踪我们在"待办"列表中的位置。
    next_entry: u8 = 0,

    // Mark the start of empty space in the notebook.
    // 标记笔记本中空白空间的开始。
    end_of_entries: u8 = 0,

    // We'll often want to find an entry by Place. If one is not
    // 我们经常想要通过地点找到一个条目。如果没有找到，
    // found, we return null.
    // 我们返回null。
    fn getEntry(self: *HermitsNotebook, place: *const Place) ?*NotebookEntry {
        for (&self.entries, 0..) |*entry, i| {
            if (i >= self.end_of_entries) break;

            // Here's where the hermit got stuck. We need to return
            // 这是隐士卡住的地方。我们需要返回
            // an optional pointer to a NotebookEntry.
            // 一个指向NotebookEntry的可选指针。
            //
            // What we have with "entry" is the opposite: a pointer to
            // 我们用"entry"得到的是相反的：一个指向
            // an optional NotebookEntry!
            // 可选NotebookEntry的指针！
            //
            // To get one from the other, we need to dereference
            // 要从一个得到另一个，我们需要解引用
            // "entry" (with .*) and get the non-null value from the
            // "entry"（用.*）并从可选值中获取非null值
            // optional (with .?) and return the address of that. The
            // （用.?）并返回其地址。
            // if statement provides some clues about how the
            // if语句提供了一些关于解引用和可选值
            // dereference and optional value "unwrapping" look
            // "解包"如何一起看起来的线索。
            // together. Remember that you return the address with the
            // 记住你用"&"操作符返回地址。
            // "&" operator.
            if (place == entry.*.?.place) return entry;
            // Try to make your answer this long:__________;
            // 试着让你的答案有这么长：__________;
        }
        return null;
    }

    // The checkNote() method is the beating heart of the magical
    // checkNote()方法是神奇笔记本的跳动心脏。
    // notebook. Given a new note in the form of a NotebookEntry
    // 给定一个NotebookEntry结构体形式的新笔记，
    // struct, we check to see if we already have an entry for the
    // 我们检查是否已经有该笔记地点的条目。
    // note's Place.
    //
    // If we DON'T, we'll add the entry to the end of the notebook
    // 如果没有，我们会将条目添加到笔记本的末尾，
    // along with the Path taken and distance.
    // 以及所采取的路径和距离。
    //
    // If we DO, we check to see if the path is "better" (shorter
    // 如果有，我们检查路径是否"更好"（距离更短）
    // distance) than the one we'd noted before. If it is, we
    // 比我们之前记录的。如果是，我们
    // overwrite the old entry with the new one.
    // 用新条目覆盖旧条目。
    fn checkNote(self: *HermitsNotebook, note: NotebookEntry) void {
        const existing_entry = self.getEntry(note.place);

        if (existing_entry == null) {
            self.entries[self.end_of_entries] = note;
            self.end_of_entries += 1;
        } else if (note.dist_to_reach < existing_entry.?.dist_to_reach) {
            existing_entry.?.* = note;
        }
    }

    // The next two methods allow us to use the notebook as a "todo"
    // 接下来的两个方法允许我们将笔记本用作"待办"
    // list.
    // 列表。
    fn hasNextEntry(self: *HermitsNotebook) bool {
        return self.next_entry < self.end_of_entries;
    }

    fn getNextEntry(self: *HermitsNotebook) *const NotebookEntry {
        defer self.next_entry += 1; // Increment after getting entry
        defer self.next_entry += 1; // 获取条目后增加
        return &self.entries[self.next_entry].?;
    }

    // After we've completed our search of the map, we'll have
    // 在我们完成地图搜索后，我们将已经
    // computed the shortest Path to every Place. To collect the
    // 计算出到每个地点的最短路径。要收集从起点到目的地的
    // complete trip from the start to the destination, we need to
    // 完整旅行，我们需要从目的地的笔记本条目开始向后
    // walk backwards from the destination's notebook entry, following
    // 走，沿着coming_from指针回到起点。
    // the coming_from pointers back to the start. What we end up with
    // 我们最终得到的是一个包含我们旅行的TripItems数组，
    // is an array of TripItems with our trip in reverse order.
    // 按相反顺序排列。
    //
    // We need to take the trip array as a parameter because we want
    // 我们需要将trip数组作为参数，因为我们希望
    // the main() function to "own" the array memory. What do you
    // main()函数"拥有"数组内存。你认为如果我们在这个
    // suppose could happen if we allocated the array in this
    // 函数的栈帧（为函数的"局部"数据分配的空间）中
    // function's stack frame (the space allocated for a function's
    // 分配数组并返回指向它的指针或切片，
    // "local" data) and returned a pointer or slice to it?
    // 会发生什么？
    //
    // Looks like the hermit forgot something in the return value of
    // 看起来隐士忘记了这个函数返回值中的某些东西。
    // this function. What could that be?
    // 那可能是什么？
    fn getTripTo(self: *HermitsNotebook, trip: []?TripItem, dest: *Place) void {
        // We start at the destination entry.
        // 我们从目的地条目开始。
        const destination_entry = self.getEntry(dest);

        // This function needs to return an error if the requested
        // 如果请求的目的地从未到达，此函数需要返回错误。
        // destination was never reached. (This can't actually happen
        // （这在我们的地图中实际上不会发生，
        // in our map since every Place is reachable by every other
        // 因为每个地点都可以被其他地点到达。）
        // Place.)
        if (destination_entry == null) {
            return TripError.Unreachable;
        }

        // Variables hold the entry we're currently examining and an
        // 变量保存我们当前正在检查的条目和一个
        // index to keep track of where we're appending trip items.
        // 索引来跟踪我们在哪里追加旅行项目。
        var current_entry = destination_entry.?;
        var i: u8 = 0;

        // At the end of each looping, a continue expression increments
        // 在每次循环结束时，一个continue表达式增加
        // our index. Can you see why we need to increment by two?
        // 我们的索引。你能看出为什么我们需要增加2吗？
        while (true) : (i += 2) {
            trip[i] = TripItem{ .place = current_entry.place };

            // An entry "coming from" nowhere means we've reached the
            // 一个"来自"无处的条目意味着我们已经到达了
            // start, so we're done.
            // 起点，所以我们完成了。
            if (current_entry.coming_from == null) break;

            // Otherwise, entries have a path.
            // 否则，条目有一个路径。
            trip[i + 1] = TripItem{ .path = current_entry.via_path.? };

            // Now we follow the entry we're "coming from".  If we
            // 现在我们跟随我们"来自"的条目。如果我们
            // aren't able to find the entry we're "coming from" by
            // 无法通过地点找到我们"来自"的条目，
            // Place, something has gone horribly wrong with our
            // 我们的程序出了严重问题！
            // program! (This really shouldn't ever happen. Have you
            // （这真的不应该发生。你检查过grues了吗？）
            // checked for grues?)
            // Note: you do not need to fix anything here.
            // 注意：你不需要在这里修复任何东西。
            const previous_entry = self.getEntry(current_entry.coming_from.?);
            if (previous_entry == null) return TripError.EatenByAGrue;
            current_entry = previous_entry.?;
        }
    }
};

pub fn main() void {
    // Here's where the hermit decides where he would like to go. Once
    // 这是隐士决定他想去哪里的地方。一旦
    // you get the program working, try some different Places on the
    // 你让程序工作起来，试试地图上的一些不同地点！
    // map!
    const start = &a; // Archer's Point
    const destination = &f; // Fox Pond

    // Store each Path array as a slice in each Place. As mentioned
    // 将每个路径数组作为切片存储在每个地点中。如前所述，
    // above, we needed to delay making these references to avoid
    // 我们需要延迟创建这些引用以避免在编译器试图
    // creating a dependency loop when the compiler is trying to
    // 计算如何为每个项目分配空间时创建依赖循环。
    // figure out how to allocate space for each item.
    a.paths = a_paths[0..];
    b.paths = b_paths[0..];
    c.paths = c_paths[0..];
    d.paths = d_paths[0..];
    e.paths = e_paths[0..];
    f.paths = f_paths[0..];

    // Now we create an instance of the notebook and add the first
    // 现在我们创建笔记本的实例并添加第一个
    // "start" entry. Note the null values. Read the comments for the
    // "起始"条目。注意null值。阅读上面checkNote()方法的
    // checkNote() method above to see how this entry gets added to
    // 注释，看看这个条目是如何添加到笔记本的。
    // the notebook.
    var notebook = HermitsNotebook{};
    var working_note = NotebookEntry{
        .place = start,
        .coming_from = null,
        .via_path = null,
        .dist_to_reach = 0,
    };
    notebook.checkNote(working_note);

    // Get the next entry from the notebook (the first being the
    // 从笔记本获取下一个条目（第一个是我们刚刚添加的
    // "start" entry we just added) until we run out, at which point
    // "起始"条目），直到我们用完，此时
    // we'll have checked every reachable Place.
    // 我们将检查了每个可到达的地点。
    while (notebook.hasNextEntry()) {
        const place_entry = notebook.getNextEntry();

        // For every Path that leads FROM the current Place, create a
        // 对于从当前地点出发的每条路径，创建一个
        // new note (in the form of a NotebookEntry) with the
        // 新笔记（以NotebookEntry的形式），包含
        // destination Place and the total distance from the start to
        // 目的地点和从起点到达该地点的总距离。
        // reach that place. Again, read the comments for the
        // 再次，阅读checkNote()方法的注释
        // checkNote() method to see how this works.
        // 来看看这是如何工作的。
        for (place_entry.place.paths) |*path| {
            working_note = NotebookEntry{
                .place = path.to,
                .coming_from = place_entry.place,
                .via_path = path,
                .dist_to_reach = place_entry.dist_to_reach + path.dist,
            };
            notebook.checkNote(working_note);
        }
    }

    // Once the loop above is complete, we've calculated the shortest
    // 一旦上面的循环完成，我们已经计算出到每个可到达地点的
    // path to every reachable Place! What we need to do now is set
    // 最短路径！我们现在需要做的是为旅行留出内存，
    // aside memory for the trip and have the hermit's notebook fill
    // 让隐士的笔记本从目的地填充到路径的旅行。
    // in the trip from the destination back to the path. Note that
    // 注意这是我们第一次实际使用目的地！
    // this is the first time we've actually used the destination!
    var trip = [_]?TripItem{null} ** (place_count * 2);

    notebook.getTripTo(trip[0..], destination) catch |err| {
        print("Oh no! {}\n", .{err});
        return;
    };

    // Print the trip with a little helper function below.
    // 用下面的小辅助函数打印旅行。
    printTrip(trip[0..]);
}

// Remember that trips will be a series of alternating TripItems
// 记住旅行将是一系列交替的TripItems，
// containing a Place or Path from the destination back to the start.
// 包含从目的地到起点的地点或路径。
// The remaining space in the trip array will contain null values, so
// 旅行数组中的剩余空间将包含null值，所以
// we need to loop through the items in reverse, skipping nulls, until
// 我们需要反向循环遍历项目，跳过null，直到
// we reach the destination at the front of the array.
// 我们到达数组前面的目的地。
fn printTrip(trip: []?TripItem) void {
    // We convert the usize length to a u8 with @intCast(), a
    // 我们用@intCast()将usize长度转换为u8，这是一个
    // builtin function just like @import().  We'll learn about
    // 内置函数，就像@import()一样。我们将在后面的练习中
    // these properly in a later exercise.
    // 正确学习这些。
    var i: u8 = @intCast(trip.len);

    while (i > 0) {
        i -= 1;
        if (trip[i] == null) continue;
        trip[i].?.printMe();
    }

    print("\n", .{});
}

// Going deeper:
// 深入了解：
//
// In computer science terms, our map places are "nodes" or "vertices" and
// 在计算机科学术语中，我们地图上的地点是"节点"或"顶点"，
// the paths are "edges". Together, they form a "weighted, directed
// 路径是"边"。它们一起形成一个"加权有向
// graph". It is "weighted" because each path has a distance (also
// 图"。它是"加权的"，因为每条路径都有距离（也
// known as a "cost"). It is "directed" because each path goes FROM
// 称为"成本"）。它是"有向的"，因为每条路径从
// one place TO another place (undirected graphs allow you to travel
// 一个地点到另一个地点（无向图允许你在
// on an edge in either direction).
// 边上的任一方向行进）。
//
// Since we append new notebook entries at the end of the list and
// 由于我们在列表末尾追加新的笔记本条目，然后
// then explore each sequentially from the beginning (like a "todo"
// 从开始按顺序探索每个（像"待办"
// list), we are treating the notebook as a "First In, First Out"
// 列表），我们将笔记本视为"先进先出"
// (FIFO) queue.
// （FIFO）队列。
//
// Since we examine all closest paths first before trying further ones
// 由于我们在尝试更远的路径之前首先检查所有最近的路径
// (thanks to the "todo" queue), we are performing a "Breadth-First
// （多亏了"待办"队列），我们正在执行"广度优先
// Search" (BFS).
// 搜索"（BFS）。
//
// By tracking "lowest cost" paths, we can also say that we're
// 通过跟踪"最低成本"路径，我们也可以说我们正在
// performing a "least-cost search".
// 执行"最小成本搜索"。
//
// Even more specifically, the Hermit's Notebook most closely
// 更具体地说，隐士的笔记本最接近
// resembles the Shortest Path Faster Algorithm (SPFA), attributed to
// 最短路径快速算法（SPFA），归功于
// Edward F. Moore. By replacing our simple FIFO queue with a
// Edward F. Moore。通过用"优先队列"替换我们简单的FIFO队列，
// "priority queue", we would basically have Dijkstra's algorithm. A
// 我们基本上就有了Dijkstra算法。
// priority queue retrieves items sorted by "weight" (in our case, it
// 优先队列按"权重"排序检索项目（在我们的情况下，它
// would keep the paths with the shortest distance at the front of the
// 会将最短距离的路径保持在队列的前面）。
// queue). Dijkstra's algorithm is more efficient because longer paths
// Dijkstra算法更高效，因为更长的路径
// can be eliminated more quickly. (Work it out on paper to see why!)
// 可以更快地被消除。（在纸上演算一下看看为什么！）
