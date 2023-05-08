-- This is a lua script for use in Conky.
require 'cairo'
require "imlib2"

function conky_main ()
    if conky_window == nil then
        return
    end
    local cs = cairo_xlib_surface_create (conky_window.display,
                                         conky_window.drawable,
                                         conky_window.visual,
                                         conky_window.width,
                                         conky_window.height)
    cr = cairo_create (cs)

    spotify_open = conky_parse("${exec pgrep -x spotify}") ~= ""

    -- start of drawing
    if spotify_open then
        dinmor = "${color #ff0000}"
        box = {
            ["top_left_x"]   = 100,
            ["top_left_y"]   = 100,
            ["width"]        = 700,
            ["height"]       = 700,
            ["song_start"]   = 530,
            ["song_height"]  = 40,
            ["song_font_size"] = 35,
            ["artist_start"]  = 570,
            ["artist_height"] = 50,
            ["artist_font_size"] = 27,
            ["album_size"]       = 500,
        }

        box["song_x"] = box["top_left_x"]
        box["song_y"] = box["top_left_y"] + box["song_start"]
        box["song_width"] = box["width"]

        box["artist_x"] = box["top_left_x"]
        box["artist_y"] = box["top_left_y"] + box["artist_start"]
        box["artist_width"] = box["width"]
        
        songartist = {}
        for str in string.gmatch(conky_parse("${exec sh /home/mathias/.config/conky/scripts/songname.sh}"), "([^;]+)") do
            table.insert(songartist, str)
        end

        set_draw_color("bg")
        rounded_rectangle(box["top_left_x"], box["top_left_y"], box["width"], box["height"], 50)
        set_draw_color("fg")
        draw_text(box["song_x"], box["song_y"], box["song_width"], box["song_height"], songartist[1], box["song_font_size"], "Consolas")
        draw_text(box["artist_x"], box["artist_y"], box["artist_width"], box["artist_height"], songartist[2], box["artist_font_size"], "Consolas")

        draw_bar(10, 600, box["top_left_x"], box["top_left_y"] + box["height"] - 100, box["width"], 70)

        draw_image(box["top_left_x"], box["top_left_y"], box["width"], box["song_y"] - box["top_left_y"], box["album_size"], box["album_size"], conky_parse("${exec /home/mathias/.config/conky/scripts/arturl.sh}"))
    end

    -- end of drawing

    cairo_destroy (cr)
    cairo_surface_destroy (cs)
    cr = nil

end

function rounded_rectangle(top_left_x, top_left_y, width, height, radius)
    cairo_set_line_width(cr, 3)
    cairo_move_to(cr, top_left_x + radius, top_left_y)
    cairo_rel_line_to(cr, width - radius * 2, 0)
    cairo_arc(cr, top_left_x + width - radius, top_left_y + radius, radius, 1.5 * math.pi, 0)
    cairo_rel_line_to(cr, 0, height - radius * 2)
    cairo_arc(cr, top_left_x + width - radius, top_left_y + height - radius, radius, 0, 0.5 * math.pi)
    cairo_rel_line_to(cr, -width + radius, 0)
    cairo_arc(cr, top_left_x + radius, top_left_y + height - radius, radius, 0.5 * math.pi, 1 * math.pi)
    cairo_rel_line_to(cr, 0, -height)
    cairo_arc(cr, top_left_x + radius, top_left_y + radius, radius, 1 * math.pi, 1.5 * math.pi)
    cairo_fill(cr)
end

function draw_text(top_left_x, top_left_y, width, height, text, font_size, font)
    cairo_select_font_face (cr, font, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size(cr, font_size)

    local extents = cairo_text_extents_t:create()
    tolua.takeownership(extents)
    cairo_text_extents(cr, text, extents)

    centerx = top_left_x + width / 2
    centery = top_left_y + height / 2
    cairo_move_to(cr, centerx - extents.width / 2, centery + extents.height / 2)
    cairo_show_text(cr, text)
end

function draw_bar(line_width, width, bounding_x, bounding_y, bounding_width, bounding_height)
    set_draw_color("fg")
    cairo_set_line_width(cr, line_width)
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND)

    centerx = bounding_width / 2 + bounding_x
    centery = bounding_y + bounding_height / 2

    cairo_move_to(cr, centerx - width / 2, centery)
    cairo_rel_line_to(cr, width, 0)
    cairo_stroke(cr)

    perc = tonumber(conky_parse("${exec /home/mathias/.config/conky/scripts/spotifyPercentage}"))

    cairo_move_to(cr, centerx - width / 2, centery)
    cairo_rel_line_to(cr, width * perc, 0)
    set_draw_color("green")
    cairo_stroke(cr)
end

function set_draw_color(color)
    colors = {
        bg      = "1a1b26",
        fg      = "a9b1d6",
        red     = "f7768e",
        green   = "73daca",
        yellow  = "e0af68",
        blue    = "7aa2f7",
        magenta = "bb9af7",
        cyan    = "7dcfff",
        white   = "c0caf5",
    }

    split_color = {}
    for i=1,colors[color]:len() / 2 do
        hex_pair = colors[color]:sub(i * 2 - 1, i * 2)

        table.insert(split_color, un_hex(hex_pair))
    end

    cairo_set_source_rgba(cr, split_color[1], split_color[2], split_color[3], 1)
end

function un_hex(n)
    lookup = {
        ["0"] = 0,
        ["1"] = 1,
        ["2"] = 2,
        ["3"] = 3,
        ["4"] = 4,
        ["5"] = 5,
        ["6"] = 6,
        ["7"] = 7,
        ["8"] = 8,
        ["9"] = 9,
        ["a"] = 10,
        ["b"] = 11,
        ["c"] = 12,
        ["d"] = 13,
        ["e"] = 14,
        ["f"] = 15,
    }

    res = lookup[n:sub(2, 2)] + lookup[n:sub(1, 1)] * 16

    return res / 255
end

function draw_image (bounding_x, bounding_y, bounding_width, bounding_height, w, h, file)
    x = (bounding_width / 2 + bounding_x) - w / 2
    y = (bounding_height / 2 + bounding_y) - h / 2
	if file == nil then print ("set image file") end
	local show = imlib_load_image (file)
	if show == nil then return end
	imlib_context_set_image (show)
	if tonumber (w) == 0 then
		width = imlib_image_get_width ()
	else
		width = tonumber (w)
	end

	if tonumber (h) == 0 then
		height = imlib_image_get_height ()
	else
		height = tonumber (h)
	end

	imlib_context_set_image (show) 
	local scaled = imlib_create_cropped_scaled_image (0, 0,
			imlib_image_get_width (), imlib_image_get_height (), width, height) 
	imlib_free_image ()
	imlib_context_set_image (scaled)
	imlib_render_image_on_drawable (x, y)
	imlib_free_image ()
	show = nil
end
