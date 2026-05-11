const std = @import("std");
const common = @import("common.zig");

const Task = struct {
    id: u8,
    description: []const u8,
};

// One interesting thing about Zig is that you can use types as values, which allows us to create a type alias for an ArrayList of Tasks.
// See that we are using a common `const` instead of some kind of `type` keyword.
const TaskList = std.ArrayList(Task);

pub fn main(init: std.process.Init) !void {
    common.init(init.io);

    // Initialize the TaskList with a capacity of 4 tasks.
    // This means that the list can hold up to 4 tasks before it needs to resize itself.
    var tasks = try TaskList.initCapacity(init.gpa, 4);

    // This `defer` is to clean up all the allocated memory for task descriptions and the TaskList itself.
    // It will run when the main function exits.
    defer {
        for (tasks.items) |task| init.gpa.free(task.description);
        tasks.deinit(init.gpa);
    }

    try common.writeString(
        \\--------------------------
        \\Welcome to the To-Do List!
        \\--------------------------
        \\ Available options:
        \\ - 1: Add a task
        \\ - 2: View tasks
        \\ - 3: Remove a task
        \\ - 4: Exit
    );

    mainLoop: while (true) {
        try common.writeString("\nEnter your choice (1-4): ");
        const choice = try common.readInt() orelse return;

        // If the choice is not between 1 and 4, we inform the user and continue the loop to ask for input again.
        if (choice < 1 or choice > 4) {
            try common.writeString(" Invalid choice. Please enter a number between 1 and 4.\n");
            continue :mainLoop;
        }

        switch (choice) {
            1 => try addTask(&tasks, init.gpa),
            2 => try viewTasks(&tasks),
            3 => try removeTask(&tasks, init.gpa),
            4 => {
                try common.writeString(" Exiting the To-Do List. Goodbye!\n");
                break :mainLoop;
            },
            else => unreachable,
        }
    }
}

fn addTask(tasks: *TaskList, gpa: std.mem.Allocator) !void {
    try common.writeString(" Enter task description: ");
    const description = try common.readLine() orelse return;

    // We need to duplicate the description string because the buffer will be reused for the next input,
    // and we want to keep the task descriptions intact in our list.
    // The `dupe` function allocates new memory and copies the string,
    // ensuring that our tasks remain valid even after subsequent inputs.
    const owned_description = try gpa.dupe(u8, description);

    const newTask = Task{
        .id = @intCast(tasks.items.len + 1),
        .description = owned_description,
    };

    try tasks.append(gpa, newTask);
    try common.writeString(" Task added successfully!\n");
}

fn viewTasks(tasks: *TaskList) !void {
    if (tasks.items.len == 0) {
        try common.writeString(" No tasks in the list.\n");
        return;
    }

    try common.writeString(" Your Tasks:\n");
    for (tasks.items[0..tasks.items.len]) |task| {
        try common.writeFormatted(" - {}: {s}\n", .{ task.id, task.description });
    }
}

fn removeTask(tasks: *TaskList, gpa: std.mem.Allocator) !void {
    if (tasks.items.len == 0) {
        try common.writeString(" No tasks to remove.\n");
        return;
    }

    try common.writeString(" Enter the ID of the task to remove: ");
    const id = try common.readInt() orelse return;

    var found = false;
    for (tasks.items, 0..) |task, index| {
        if (task.id == id) {
            // When we found the task to remove, we free the memory allocated for its description
            gpa.free(task.description);
            // and then we remove it from the list using `swapRemove`
            _ = tasks.swapRemove(index);

            // This variable is to inform the user if the task was found and removed successfully
            found = true;
            break;
        }
    }

    if (found) {
        try common.writeString(" Task removed successfully!\n");
    } else {
        try common.writeString(" Task with the given ID not found.\n");
    }
}
