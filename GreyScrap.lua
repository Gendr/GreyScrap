--[[	GreyScrap	]]--

local format = string.format
local select = select

----------------------

local AddMessage = AddMessage
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local GetCoinTextureString = GetCoinTextureString
local GetContainerItemInfo = GetContainerItemInfo
local GetContainerItemLink = GetContainerItemLink
local GetContainerNumSlots = GetContainerNumSlots
local GetItemInfo = GetItemInfo
local UseContainerItem = UseContainerItem

----------------------

local GreyScrap = CreateFrame("Frame")
GreyScrap:RegisterEvent("MERCHANT_SHOW")

local addon_prefix = "|cffa0a0a0GreyScrap:|r"

----------------------

local function out(...)
	DEFAULT_CHAT_FRAME:AddMessage(string.join(" ", addon_prefix, ...))
end

----------------------

GreyScrap:SetScript("OnEvent", function()
	local soldCount = 0
	local total = 0
	for bag=0,4 do
		for slot=0,GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link and select(3, GetItemInfo(link)) == 0 then
				local price = select(11, GetItemInfo(link))
				local count = select(2, GetContainerItemInfo(bag, slot))
				UseContainerItem(bag, slot)
				soldCount = soldCount+count
				total = total+price*count
			end
		end
	end
	if total == 0 then return
	else
		out(format("Sold %d items for %s", soldCount, GetCoinTextureString(total, "12")))
	end
end)
