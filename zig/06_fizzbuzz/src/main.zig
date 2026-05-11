// This should be called `zigzag` instead of `fizzbuzz`
const std = @import("std");
const common = @import("common.zig");

pub fn main(init: std.process.Init) !void {
    common.init(init.io);

    // The `100 + 1 ` is because the range is exclusive, so we need to add 1 to include 100
    for (1..100 + 1) |i| {
        if (i % 3 == 0 and i % 5 == 0) {
            try common.writeString("FizzBuzz\n");
        } else if (i % 3 == 0) {
            try common.writeString("Fizz\n");
        } else if (i % 5 == 0) {
            try common.writeString("Buzz\n");
        } else {
            try common.writeFormatted("{d}\n", .{i});
        }
    }
}
