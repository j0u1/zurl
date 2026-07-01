const std = @import("std");
const log = std.log.scoped(.zurl);

pub fn main(init: std.process.Init) !void {
    const allocator = init.gpa;
    const io = init.io;
    const arena = init.arena.allocator();

    const args = try init.minimal.args.toSlice(arena);

    if (args.len < 2) {
        log.warn("Usage: {s} <url>", .{args[0]});
        return;
    }

    const url = args[1];

    var client = std.http.Client{ .allocator = allocator, .io = io };
    defer client.deinit();

    const res = client.fetch(.{
        .location = .{ .url = url },
        .method = .GET,
    }) catch |err| {
        log.err("Failed to get status: {s}", .{@errorName(err)});
        return;
    };

    const code: u10 = @intFromEnum(res.status);
    log.info("Status: {s} ({d})", .{ @tagName(res.status), code });
}
