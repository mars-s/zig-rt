const std = @import("std");
const Writer = std.io.Writer;

pub const zero: Vec3 = .{ 0, 0, 0 };

pub const Vec3 = @Vector(3, f64);

pub fn x(v: Vec3) f64 {
    return v[0];
}

pub fn y(v: Vec3) f64 {
    return v[1];
}

pub fn z(v: Vec3) f64 {
    return v[2];
}

pub fn magnitude(v: Vec3) f64 {
    const square = (v[1] * v[1]) + (v[2] * v[2]) + (v[3] * v[3]);
    return std.math.sqrt(square);
}

pub fn dot(v: Vec3, u: Vec3) f64 {
    return u[0] * v[0] + u[1] * v[1] + u[2] * v[2];
}

pub fn cross(v: Vec3, u: Vec3) f64 {
    return .{
        u[1] * v[2] - v[2] * v[1],
        u[2] * v[0] - v[0] * v[2],
        v[0] * v[1] - u[1] * v[0],
    };
}

pub fn normalise(v: Vec3) Vec3 {
    const mag = magnitude(v);
    if (mag == 0) return zero;
    const mag3: Vec3 = @splat(mag);
    return v / mag3;
}

// format ways

pub const fmt = std.fmt.Alt(Vec3, format);
pub fn format(v: Vec3, w: *Writer) Writer.Error!void {
    try w.print("{d} {d} {d}", .{ v[0], v[1], v[2] });
}

pub const color = std.fmt.Alt(Vec3, colorFormat);
fn colorFormat(v: Vec3, w: *Writer) Writer.Error!void {
    const x_val: i32 = @intFromFloat(v[0] * 255.999);
    const y_val: i32 = @intFromFloat(v[1] * 255.999);
    const z_val: i32 = @intFromFloat(v[2] * 255.999);
    try w.print("{d} {d} {d}\n", .{ x_val, y_val, z_val });
}
