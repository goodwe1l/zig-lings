//
// Being able to pass types to functions at compile time lets us
// generate code that works with multiple types. But it doesn't
// help us pass VALUES of different types to a function.
// 能够在编译时将类型传递给函数让我们生成适用于多种类型的代码。
// 但这并不能帮助我们将不同类型的值传递给函数。
//
// For that, we have the 'anytype' placeholder, which tells Zig
// to infer the actual type of a parameter at compile time.
// 为此，我们有 'anytype' 占位符，它告诉 Zig 在编译时推断参数的实际类型。
//
//     fn foo(thing: anytype) void { ... }
//
// Then we can use builtins such as @TypeOf(), @typeInfo(),
// @typeName(), @hasDecl(), and @hasField() to determine more
// about the type that has been passed in. All of this logic will
// be performed entirely at compile time.
// 然后我们可以使用诸如 @TypeOf()、@typeInfo()、@typeName()、@hasDecl() 和 @hasField()
// 等内置函数来确定传入类型的更多信息。所有这些逻辑都将完全在编译时执行。
//
const print = @import("std").debug.print;

// Let's define three structs: Duck, RubberDuck, and Duct. Notice
// that Duck and RubberDuck both contain waddle() and quack()
// methods declared in their namespace (also known as "decls").
// 让我们定义三个结构体：Duck、RubberDuck 和 Duct。注意 Duck 和 RubberDuck
// 都包含在其命名空间中声明的 waddle() 和 quack() 方法（也称为"decls"）。

const Duck = struct {
    eggs: u8,
    loudness: u8,
    location_x: i32 = 0,
    location_y: i32 = 0,

    fn waddle(self: *Duck, x: i16, y: i16) void {
        self.location_x += x;
        self.location_y += y;
    }

    fn quack(self: Duck) void {
        if (self.loudness < 4) {
            print("\"Quack.\" ", .{});
        } else {
            print("\"QUACK!\" ", .{});
        }
    }
};

const RubberDuck = struct {
    in_bath: bool = false,
    location_x: i32 = 0,
    location_y: i32 = 0,

    fn waddle(self: *RubberDuck, x: i16, y: i16) void {
        self.location_x += x;
        self.location_y += y;
    }

    fn quack(self: RubberDuck) void {
        // Assigning an expression to '_' allows us to safely
        // "use" the value while also ignoring it.
        // 将表达式赋值给 '_' 允许我们安全地"使用"值同时也忽略它。
        _ = self;
        print("\"Squeek!\" ", .{});
    }

    fn listen(self: RubberDuck, dev_talk: []const u8) void {
        // Listen to developer talk about programming problem.
        // Silently contemplate problem. Emit helpful sound.
        // 听开发者谈论编程问题。静静地思考问题。发出有用的声音。
        _ = dev_talk;
        self.quack();
    }
};

const Duct = struct {
    diameter: u32,
    length: u32,
    galvanized: bool,
    connection: ?*Duct = null,

    fn connect(self: *Duct, other: *Duct) !void {
        if (self.diameter == other.diameter) {
            self.connection = other;
        } else {
            return DuctError.UnmatchedDiameters;
        }
    }
};

const DuctError = error{UnmatchedDiameters};

pub fn main() void {
    // This is a real duck!
    // 这是一只真鸭子！
    const ducky1 = Duck{
        .eggs = 0,
        .loudness = 3,
    };

    // This is not a real duck, but it has quack() and waddle()
    // abilities, so it's still a "duck".
    // 这不是一只真鸭子，但它有 quack() 和 waddle() 能力，所以它仍然是一只"鸭子"。
    const ducky2 = RubberDuck{
        .in_bath = false,
    };

    // This is not even remotely a duck.
    // 这甚至一点都不像鸭子。
    const ducky3 = Duct{
        .diameter = 17,
        .length = 165,
        .galvanized = true,
    };

    print("ducky1: {}, ", .{isADuck(ducky1)});
    print("ducky2: {}, ", .{isADuck(ducky2)});
    print("ducky3: {}\n", .{isADuck(ducky3)});
}

// This function has a single parameter which is inferred at
// compile time. It uses builtins @TypeOf() and @hasDecl() to
// perform duck typing ("if it walks like a duck and it quacks
// like a duck, then it must be a duck") to determine if the type
// is a "duck".
// 这个函数有一个在编译时推断的单个参数。它使用内置函数 @TypeOf() 和 @hasDecl()
// 来执行鸭子类型判断（"如果它像鸭子一样走路，像鸭子一样叫，那么它一定是鸭子"）
// 来确定类型是否是"鸭子"。
fn isADuck(possible_duck: anytype) bool {
    // We'll use @hasDecl() to determine if the type has
    // everything needed to be a "duck".
    // 我们将使用 @hasDecl() 来确定类型是否具有成为"鸭子"所需的一切。
    //
    // In this example, 'has_increment' will be true if type Foo
    // has an increment() method:
    // 在这个例子中，如果类型 Foo 有 increment() 方法，'has_increment' 将为 true：
    //
    //     const has_increment = @hasDecl(Foo, "increment");
    //
    // Please make sure MyType has both waddle() and quack()
    // methods:
    // 请确保 MyType 有 waddle() 和 quack() 方法：
    const MyType = @TypeOf(possible_duck);
    const walks_like_duck = ???;
    const quacks_like_duck = ???;

    const is_duck = walks_like_duck and quacks_like_duck;

    if (is_duck) {
        // We also call the quack() method here to prove that Zig
        // allows us to perform duck actions on anything
        // sufficiently duck-like.
        // 我们还在这里调用 quack() 方法来证明 Zig 允许我们对任何足够像鸭子的东西执行鸭子动作。
        //
        // Because all of the checking and inference is performed
        // at compile time, we still have complete type safety:
        // attempting to call the quack() method on a struct that
        // doesn't have it (like Duct) would result in a compile
        // error, not a runtime panic or crash!
        // 因为所有的检查和推断都在编译时执行，我们仍然有完整的类型安全：
        // 尝试在没有 quack() 方法的结构体（如 Duct）上调用该方法会导致编译错误，
        // 而不是运行时恐慌或崩溃！
        possible_duck.quack();
    }

    return is_duck;
}
