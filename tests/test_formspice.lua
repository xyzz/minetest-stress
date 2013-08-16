function test_empty()
	assert_equal("size[1337,0]", formspec(1337, 0))
end

function test_image_and_background()
	assert_equal("size[1,2]image[5,6;7,8;b.png]background[10,11;12,13;a.png]", formspec(1, 2,
		{"image", x=5, y=6, w=7, h=8, image="b.png"},
		{"background", x=10, y=11, w=12, h=13, image="a.png"}
	))
end

function test_labels()
	assert_equal("size[0,0]vertlabel[0,1;abacaba]label[2,3;baka]", formspec(0, 0,
		{"label", x=0, y=1, vertical=true, value="abacaba"},
		{"label", x=2, y=3, value="baka"}
	))
end

function test_inputs()
	assert_equal("size[0,0]field[0,1;2,3;a;b;c]", formspec(0, 0,
		{"input", x=0, y=1, w=2, h=3, name="a", default="c", label="b"}
	))
end
