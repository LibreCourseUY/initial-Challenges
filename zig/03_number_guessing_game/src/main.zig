const std = @import("std");
const common = @import("common.zig");

pub fn main(init: std.process.Init) !void {
    common.init(init.io);

    // First we create a Pseudo-Random Number Generator (PRNG)
    var prng = std.Random.DefaultPrng.init(@bitCast(std.Io.Clock.real.now(init.io).toMicroseconds()));

    // And we generate a random number between 1 and 100
    const rng = prng.random().intRangeAtMost(u8, 1, 100);

    // Now we go into the main loop of the game
    mainLoop: while (true) {
        try common.writeString("Guess the number between 1 and 100: ");

        // We read the input from the user or we continue the loop if there was an error
        const guess = try common.readInt() orelse continue :mainLoop;

        // Now we compare the guess with the random number, and we give feedback to the user
        if (guess < rng) {
            try common.writeString("Too low!\n");
        } else if (guess > rng) {
            try common.writeString("Too high!\n");
        } else {
            break :mainLoop;
        }
    }

    try common.writeString("Congratulations! You guessed the number!\n");
}
