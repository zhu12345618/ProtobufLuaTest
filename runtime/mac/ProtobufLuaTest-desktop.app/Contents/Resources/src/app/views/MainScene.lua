
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- add background image
    self:protoTest();
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World " .. self.test, "Arial", 40)
        :move(display.cx, display.cy + 200)
        :addTo(self)

end

function MainScene:protoTest()
	local pbFilePath = cc.FileUtils:getInstance():fullPathForFilename("client.pb");
	print("PB file path" .. pbFilePath);
	local buffer = read_protobuf_file_c(pbFilePath);
	protobuf.register(buffer);				--注:protobuf  是因为在protobuf.lua里面使用module(protobuf)来修改全局名字

	local stringbuffer = protobuf.encode("proto.AutoID", {
			id = 999
	});
	local slen = string.len(stringbuffer);
	print("slen = " .. slen);

	local temp = ""

	for i = 1, slen do
		temp = temp .. string.format("0xX, ", string.byte(stringbuffer, i));
	end

	print(temp);
	local result = protobuf.decode("proto.AutoID", stringbuffer);
	self.test = result.id;
	print("result id : " .. result.id);
end

return MainScene
