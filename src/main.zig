const std = @import("std");
const rt_zig = @import("rt_zig");
const vec = @import("vec3.zig");
const Progress = std.Progress;
const Writer = std.io.Writer;
const Vec3 = vec.Vec3;

//int
const image_width = 256;
const image_height = 256;

pub fn main() !void {
    // fs std io out
    var wbuf: [4096]u8 = undefined;
    var file_writer = std.fs.File.stdout().writer(&wbuf);
    const out = &file_writer.interface;

    //progress stuff
    var pbuf: [1024]u8 = [_]u8{0} ** 1024;
    const pr = Progress.start(.{
        .draw_buffer = &pbuf,
        .estimated_total_items = image_height * image_width,
        .root_name = "sampling"
    });
    defer pr.end();



    //header
    try out.print("P3\n{d} {d}\n255\n", .{ image_height, image_width });
    //renderer
    for (0..image_height) |h| {
        for (0..image_width) |w| {
                
            const fw: f32 = @floatFromInt(w);
            const fh: f32 = @floatFromInt(h);
            
            const pixel: Vec3 = .{
                fw / (image_width - 1),
                fh / (image_height - 1),
                0,
            };
            
            try out.print("{f}", .{ vec.color{ .data = pixel } });
        }
    }
    try out.flush();
}
