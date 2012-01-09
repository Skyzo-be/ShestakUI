local T, C, L = unpack(select(2, ...))
if C.skins.blizzard_frames ~= true then return end

----------------------------------------------------------------------------------------
--	AuctionUI skin
----------------------------------------------------------------------------------------
local function LoadSkin()
	T.SkinCloseButton(AuctionFrameCloseButton)
	AuctionFrame:StripTextures(true)
	AuctionFrame:SetTemplate("Transparent")

	BrowseFilterScrollFrame:StripTextures()
	BrowseScrollFrame:StripTextures()
	AuctionsScrollFrame:StripTextures()
	BidScrollFrame:StripTextures()

	T.SkinDropDownBox(BrowseDropDown)
	T.SkinDropDownBox(PriceDropDown)
	T.SkinDropDownBox(DurationDropDown, 80)

	T.SkinCheckBox(IsUsableCheckButton)
	T.SkinCheckBox(ShowOnPlayerCheckButton)

	-- Dress Up Frame
	SideDressUpFrame:StripTextures()
	SideDressUpFrame:SetTemplate("Transparent")
	SideDressUpModelResetButton:SkinButton()
	T.SkinCloseButton(SideDressUpModelCloseButton, SideDressUpFrame)

	SideDressUpFrame:HookScript("OnShow", function()
		SideDressUpFrame:ClearAllPoints()
		SideDressUpFrame:Point("TOPLEFT", AuctionFrame, "TOPRIGHT", 3, 0)
	end)

	-- Progress Frame
	AuctionProgressFrame:StripTextures()
	AuctionProgressFrame:SetTemplate("Transparent")
	AuctionProgressFrameCancelButton:StyleButton()
	AuctionProgressFrameCancelButton:SetTemplate("Default")
	AuctionProgressFrameCancelButton:SetHitRectInsets(0, 0, 0, 0)
	AuctionProgressFrameCancelButton:GetNormalTexture():ClearAllPoints()
	AuctionProgressFrameCancelButton:GetNormalTexture():Point("TOPLEFT", 2, -2)
	AuctionProgressFrameCancelButton:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
	AuctionProgressFrameCancelButton:GetNormalTexture():SetTexCoord(0.67, 0.37, 0.61, 0.26)
	AuctionProgressFrameCancelButton:Size(28)
	AuctionProgressFrameCancelButton:Point("LEFT", AuctionProgressBar, "RIGHT", 8, 0)

	AuctionProgressBarIcon:SetTexCoord(0.1, 0.9, 0.1, 0.9)

	local backdrop = CreateFrame("Frame", nil, AuctionProgressBarIcon:GetParent())
	backdrop:Point("TOPLEFT", AuctionProgressBarIcon, "TOPLEFT", -2, 2)
	backdrop:Point("BOTTOMRIGHT", AuctionProgressBarIcon, "BOTTOMRIGHT", 2, -2)
	backdrop:SetTemplate("Default")
	AuctionProgressBarIcon:SetParent(backdrop)

	AuctionProgressBarText:ClearAllPoints()
	AuctionProgressBarText:SetPoint("CENTER")

	AuctionProgressBar:StripTextures()
	AuctionProgressBar:CreateBackdrop("Default")
	AuctionProgressBar:SetStatusBarTexture(C.media.texture)
	AuctionProgressBar:SetStatusBarColor(1, 1, 0)

	T.SkinNextPrevButton(BrowseNextPageButton)
	T.SkinNextPrevButton(BrowsePrevPageButton)

	local buttons = {
		"BrowseBidButton",
		"BidBidButton",
		"BrowseBuyoutButton",
		"BidBuyoutButton",
		"BrowseCloseButton",
		"BidCloseButton",
		"BrowseSearchButton",
		"AuctionsCreateAuctionButton",
		"AuctionsCancelAuctionButton",
		"AuctionsCloseButton",
		"BrowseResetButton",
		"AuctionsStackSizeMaxButton",
		"AuctionsNumStacksMaxButton"
	}

	for _, button in pairs(buttons) do
		_G[button]:SkinButton()
	end

	-- Fix Button Positions
	AuctionsCloseButton:Point("BOTTOMRIGHT", AuctionFrameAuctions, "BOTTOMRIGHT", 66, 10)
	AuctionsCancelAuctionButton:Point("RIGHT", AuctionsCloseButton, "LEFT", -4, 0)
	BidCloseButton:Point("BOTTOMRIGHT", AuctionFrameBid, "BOTTOMRIGHT", 66, 10)
	BidBuyoutButton:Point("RIGHT", BidCloseButton, "LEFT", -4, 0)
	BidBidButton:Point("RIGHT", BidBuyoutButton, "LEFT", -4, 0)
	BrowseCloseButton:Point("BOTTOMRIGHT", AuctionFrameBrowse, "BOTTOMRIGHT", 66, 10)
	BrowseBuyoutButton:Point("RIGHT", BrowseCloseButton, "LEFT", -4, 0)
	BrowseBidButton:Point("RIGHT", BrowseBuyoutButton, "LEFT", -4, 0)
	BrowseResetButton:Point("TOPLEFT", AuctionFrameBrowse, "TOPLEFT", 81, -74)
	BrowseSearchButton:Point("TOPRIGHT", AuctionFrameBrowse, "TOPRIGHT", 25, -34)

	AuctionsItemButton:StripTextures()
	AuctionsItemButton:StyleButton()
	AuctionsItemButton:SetTemplate("Default", true)

	AuctionsItemButton:SetScript("OnUpdate", function()
		if AuctionsItemButton:GetNormalTexture() then
			AuctionsItemButton:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			AuctionsItemButton:GetNormalTexture():ClearAllPoints()
			AuctionsItemButton:GetNormalTexture():Point("TOPLEFT", 2, -2)
			AuctionsItemButton:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
		end
	end)

	local sorttabs = {
		"BrowseQualitySort",
		"BrowseLevelSort",
		"BrowseDurationSort",
		"BrowseHighBidderSort",
		"BrowseCurrentBidSort",
		"BidQualitySort",
		"BidLevelSort",
		"BidDurationSort",
		"BidBuyoutSort",
		"BidStatusSort",
		"BidBidSort",
		"AuctionsQualitySort",
		"AuctionsDurationSort",
		"AuctionsHighBidderSort",
		"AuctionsBidSort"
	}

	for _, sorttab in pairs(sorttabs) do
		_G[sorttab.."Left"]:Kill()
		_G[sorttab.."Middle"]:Kill()
		_G[sorttab.."Right"]:Kill()
	end

	for i = 1, 3 do
		T.SkinTab(_G["AuctionFrameTab"..i])
	end

	for i = 1, NUM_FILTERS_TO_DISPLAY do
		local tab = _G["AuctionFilterButton"..i]
		tab:StripTextures()
		tab:StyleButton()
	end

	local editboxs = {
		"BrowseName",
		"BrowseMinLevel",
		"BrowseMaxLevel",
		"BrowseBidPriceGold",
		"BrowseBidPriceSilver",
		"BrowseBidPriceCopper",
		"BidBidPriceGold",
		"BidBidPriceSilver",
		"BidBidPriceCopper",
		"AuctionsStackSizeEntry",
		"AuctionsNumStacksEntry",
		"StartPriceGold",
		"StartPriceSilver",
		"StartPriceCopper",
		"BuyoutPriceGold",
		"BuyoutPriceSilver",
		"BuyoutPriceCopper"
	}

	for _, editbox in pairs(editboxs) do
		T.SkinEditBox(_G[editbox])
		_G[editbox]:SetTextInsets(1, 1, -1, 1)
	end
	BrowseMaxLevel:Point("LEFT", BrowseMinLevel, "RIGHT", 8, 0)
	AuctionsStackSizeEntry.backdrop:SetAllPoints()
	AuctionsNumStacksEntry.backdrop:SetAllPoints()

	for i = 1, NUM_BROWSE_TO_DISPLAY do
		local button = _G["BrowseButton"..i]
		local icon = _G["BrowseButton"..i.."Item"]

		if _G["BrowseButton"..i.."ItemIconTexture"] then
			_G["BrowseButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["BrowseButton"..i.."ItemIconTexture"]:ClearAllPoints()
			_G["BrowseButton"..i.."ItemIconTexture"]:Point("TOPLEFT", 2, -2)
			_G["BrowseButton"..i.."ItemIconTexture"]:Point("BOTTOMRIGHT", -2, 2)
		end

		if icon then
			icon:StyleButton()
			icon:HookScript("OnUpdate", function() icon:GetNormalTexture():Kill() end)

			icon:CreateBackdrop("Default")
			icon.backdrop:SetAllPoints()
		end

		if button then
			button:StripTextures()
			button:StyleButton()
			_G["BrowseButton"..i.."Highlight"] = button:GetHighlightTexture()
			button:GetHighlightTexture():ClearAllPoints()
			button:GetHighlightTexture():Point("TOPLEFT", icon, "TOPRIGHT", 2, 0)
			button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
			button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
		end
	end

	for i = 1, NUM_AUCTIONS_TO_DISPLAY do
		local button = _G["AuctionsButton"..i]
		local icon = _G["AuctionsButton"..i.."Item"]

		_G["AuctionsButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		_G["AuctionsButton"..i.."ItemIconTexture"].SetTexCoord = T.dummy
		_G["AuctionsButton"..i.."ItemIconTexture"]:ClearAllPoints()
		_G["AuctionsButton"..i.."ItemIconTexture"]:Point("TOPLEFT", 2, -2)
		_G["AuctionsButton"..i.."ItemIconTexture"]:Point("BOTTOMRIGHT", -2, 2)

		icon:StyleButton()
		icon:HookScript("OnUpdate", function() icon:GetNormalTexture():Kill() end)

		icon:CreateBackdrop("Default")
		icon.backdrop:SetAllPoints()

		button:StripTextures()
		button:StyleButton()
		_G["AuctionsButton"..i.."Highlight"] = button:GetHighlightTexture()
		button:GetHighlightTexture():ClearAllPoints()
		button:GetHighlightTexture():Point("TOPLEFT", icon, "TOPRIGHT", 2, 0)
		button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
		button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
	end

	for i = 1, NUM_BIDS_TO_DISPLAY do
		local button = _G["BidButton"..i]
		local icon = _G["BidButton"..i.."Item"]

		_G["BidButton"..i.."ItemIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
		_G["BidButton"..i.."ItemIconTexture"]:ClearAllPoints()
		_G["BidButton"..i.."ItemIconTexture"]:Point("TOPLEFT", 2, -2)
		_G["BidButton"..i.."ItemIconTexture"]:Point("BOTTOMRIGHT", -2, 2)

		icon:StyleButton()
		icon:HookScript("OnUpdate", function() icon:GetNormalTexture():Kill() end)

		icon:CreateBackdrop("Default")
		icon.backdrop:SetAllPoints()

		button:StripTextures()
		button:StyleButton()
		_G["BidButton"..i.."Highlight"] = button:GetHighlightTexture()
		button:GetHighlightTexture():ClearAllPoints()
		button:GetHighlightTexture():Point("TOPLEFT", icon, "TOPRIGHT", 2, 0)
		button:GetHighlightTexture():SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", -2, 5)
		button:GetPushedTexture():SetAllPoints(button:GetHighlightTexture())
	end

	-- Custom Backdrops
	AuctionFrameBrowse.bg1 = CreateFrame("Frame", nil, AuctionFrameBrowse)
	AuctionFrameBrowse.bg1:SetTemplate("Overlay")
	AuctionFrameBrowse.bg1:Point("TOPLEFT", 20, -103)
	AuctionFrameBrowse.bg1:Point("BOTTOMRIGHT", -575, 40)
	BrowseFilterScrollFrame:Height(300)

	AuctionFrameBrowse.bg2 = CreateFrame("Frame", nil, AuctionFrameBrowse)
	AuctionFrameBrowse.bg2:SetTemplate("Overlay")
	AuctionFrameBrowse.bg2:Point("TOPLEFT", AuctionFrameBrowse.bg1, "TOPRIGHT", 4, 0)
	AuctionFrameBrowse.bg2:Point("BOTTOMRIGHT", AuctionFrame, "BOTTOMRIGHT", -8, 40)
	AuctionFrameBrowse.bg2:SetFrameLevel(AuctionFrameBrowse.bg2:GetFrameLevel() - 2)
	BrowseScrollFrame:Height(300)

	AuctionFrameBid.bg = CreateFrame("Frame", nil, AuctionFrameBid)
	AuctionFrameBid.bg:SetTemplate("Overlay")
	AuctionFrameBid.bg:Point("TOPLEFT", 22, -72)
	AuctionFrameBid.bg:Point("BOTTOMRIGHT", 66, 39)
	AuctionFrameBid.bg:SetFrameLevel(AuctionFrameBid.bg:GetFrameLevel() - 2)
	BidScrollFrame:Height(332)

	AuctionsScrollFrame:Height(336)
	AuctionFrameAuctions.bg1 = CreateFrame("Frame", nil, AuctionFrameAuctions)
	AuctionFrameAuctions.bg1:SetTemplate("Overlay")
	AuctionFrameAuctions.bg1:Point("TOPLEFT", 15, -70)
	AuctionFrameAuctions.bg1:Point("BOTTOMRIGHT", -545, 35)
	AuctionFrameAuctions.bg1:SetFrameLevel(AuctionFrameAuctions.bg1:GetFrameLevel() - 2)

	AuctionFrameAuctions.bg2 = CreateFrame("Frame", nil, AuctionFrameAuctions)
	AuctionFrameAuctions.bg2:SetTemplate("Overlay")
	AuctionFrameAuctions.bg2:Point("TOPLEFT", AuctionFrameAuctions.bg1, "TOPRIGHT", 3, 0)
	AuctionFrameAuctions.bg2:Point("BOTTOMRIGHT", AuctionFrame, -8, 35)
	AuctionFrameAuctions.bg2:SetFrameLevel(AuctionFrameAuctions.bg2:GetFrameLevel() - 2)

	-- Auctionator
	if not IsAddOnLoaded("Auctionator") then return end

	local buttons = {
		"Atr_Search_Button",
		"Atr_Back_Button",
		"Atr_Buy1_Button",
		"Atr_Adv_Search_Button",
		"Atr_FullScanButton",
		"Auctionator1Button",
		"Atr_ListTabsTab1",
		"Atr_ListTabsTab2",
		"Atr_ListTabsTab3",
		"Atr_CreateAuctionButton",
		"Atr_RemFromSListButton",
		"Atr_AddToSListButton",
		"Atr_SrchSListButton",
		"Atr_DelSListButton",
		"Atr_NewSListButton",
		"Atr_CheckActiveButton",
		"AuctionatorCloseButton",
		"Atr_CancelSelectionButton",
		"Atr_FullScanStartButton",
		"Atr_FullScanDone",
		"Atr_CheckActives_Yes_Button",
		"Atr_CheckActives_No_Button",
		"Atr_Adv_Search_ResetBut",
		"Atr_Adv_Search_OKBut",
		"Atr_Adv_Search_CancelBut",
		"Atr_Buy_Confirm_OKBut",
		"Atr_Buy_Confirm_CancelBut",
		"Atr_MngSListsButton",
		"Auctionator_Search"
	}

	for i = 1, getn(buttons) do
		local frame = _G[buttons[i]]
		if frame then
			_G[buttons[i]]:SkinButton(true)
		end
	end

	local dropdown = {
		"Atr_DropDown1",
		"Atr_Duration",
		"Atr_DropDownSL",
		"Atr_ASDD_Class",
		"Atr_ASDD_Subclass"
	}

	for i = 1, getn(dropdown) do
		local frame = _G[dropdown[i]]
		if frame then
			T.SkinDropDownBox(_G[dropdown[i]])
		end
	end

	local editbox = {
		"Atr_StackPriceGold",
		"Atr_StackPriceSilver",
		"Atr_StackPriceCopper",
		"Atr_ItemPriceGold",
		"Atr_ItemPriceSilver",
		"Atr_ItemPriceCopper",
		"Atr_Batch_NumAuctions",
		"Atr_Batch_Stacksize",
		"Atr_Search_Box",
		"Atr_AS_Searchtext",
		"Atr_AS_Minlevel",
		"Atr_AS_Maxlevel",
		"Atr_AS_MinItemlevel",
		"Atr_AS_MaxItemlevel"
	}

	for i = 1, getn(editbox) do
		local frame = _G[editbox[i]]
		if frame then
			T.SkinEditBox(_G[editbox[i]])
		end
	end

	local frames = {
		"Atr_FullScanResults",
		"Atr_Adv_Search_Dialog",
		"Atr_FullScanFrame",
		"Atr_HeadingsBar",
		"Atr_Error_Frame",
		"Atr_Hlist",
		"Atr_Buy_Confirm_Frame",
		"Atr_CheckActives_Frame",
		"Atr_Hilite1",
		"Atr_BasicOptionsFrame",
		"Atr_TooltipsOptionsFrame",
		"Atr_UCConfigFrame",
		"Atr_StackingOptionsFrame",
		"Atr_ShpList_Options_Frame",
		"AuctionatorResetsFrame",
		"Atr_ScanningOptionsFrame",
		"AuctionatorDescriptionFrame",
		"Atr_LUA_Error"
	}

	for i = 1, getn(frames) do
		local frame = _G[frames[i]]
		if frame then
			_G[frames[i]]:StripTextures()
		end
	end

	Atr_Mask:ClearAllPoints()
	Atr_Mask:Point("TOPLEFT", AuctionFrame, "TOPLEFT", 0, 0)
	Atr_Mask:Point("BOTTOMRIGHT", AuctionFrame, "BOTTOMRIGHT", 0, 0)

	Atr_Adv_Search_Dialog:SetTemplate("Transparent")
	Atr_FullScanFrame:SetTemplate("Overlay")
	Atr_Buy_Confirm_Frame:SetTemplate("Default")
	Atr_CheckActives_Frame:SetTemplate("Default")
	Atr_Error_Frame:SetTemplate("Transparent")
	Atr_LUA_Error:SetTemplate("Transparent")

	Atr_HeadingsBar:CreateBackdrop("Overlay")
	Atr_HeadingsBar.backdrop:Point("TOPLEFT", 0, -25)
	Atr_HeadingsBar.backdrop:Point("BOTTOMRIGHT", 3, -182)

	Atr_SellControls:CreateBackdrop("Overlay")
	Atr_SellControls.backdrop:Point("TOPLEFT", -2, 0)
	Atr_SellControls.backdrop:Point("BOTTOMRIGHT", 24, 1)

	Atr_Hlist:SetTemplate("Overlay")
	Atr_Hlist:Width(196)
	Atr_Hlist:ClearAllPoints()
	Atr_Hlist:Point("TOPLEFT", -195, -75)

	Atr_Hilite1:CreateBackdrop("Overlay")
	Atr_Hilite1.backdrop:Point("TOPLEFT", 1, -3)
	Atr_Hilite1.backdrop:Point("BOTTOMRIGHT", 3, -1)

	Atr_Search_Box:Height(Atr_Search_Box:GetHeight() - 2)
	Auctionator1Button:Height(22)
	Atr_Search_Button:Height(22)
	Atr_Adv_Search_Button:Height(22)
	Atr_Back_Button:Height(22)
	Atr_FullScanButton:Height(22)
	Atr_FullScanButton:Point("LEFT", Atr_Adv_Search_Button, "RIGHT", 3, 0)
	Atr_FullScanButton:Point("RIGHT", Auctionator1Button, "LEFT", -3, 0)

	Atr_CreateAuctionButton:Width(165)
	Atr_CreateAuctionButton:ClearAllPoints()
	Atr_CreateAuctionButton:Point("CENTER", 14, -20)

	for i = 4, 6 do
		T.SkinTab(_G["AuctionFrameTab"..i])
	end

	AuctionatorCloseButton:ClearAllPoints()
	AuctionatorCloseButton:Point("BOTTOMLEFT", Atr_Main_Panel, "BOTTOMRIGHT", -14, 10)
	Atr_Buy1_Button:Point("RIGHT", AuctionatorCloseButton, "LEFT", -4, 0)
	Atr_CancelSelectionButton:Point("RIGHT", Atr_Buy1_Button, "LEFT", -4, 0)

	Atr_RecommendItem_Tex:SetTemplate("Default")
	Atr_RecommendItem_Tex:StyleButton()
	Atr_RecommendItem_Tex:SetScript("OnUpdate", function()
		if Atr_RecommendItem_Tex:GetNormalTexture() then
			Atr_RecommendItem_Tex:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			Atr_RecommendItem_Tex:GetNormalTexture():ClearAllPoints()
			Atr_RecommendItem_Tex:GetNormalTexture():Point("TOPLEFT", 2, -2)
			Atr_RecommendItem_Tex:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
		end
	end)

	Atr_SellControls_Tex:SetTemplate("Default")
	Atr_SellControls_Tex:StyleButton()

	Atr_SellControls_Tex:SetScript("OnUpdate", function()
		if Atr_SellControls_Tex:GetNormalTexture() then
			Atr_SellControls_Tex:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			Atr_SellControls_Tex:GetNormalTexture():ClearAllPoints()
			Atr_SellControls_Tex:GetNormalTexture():Point("TOPLEFT", 2, -2)
			Atr_SellControls_Tex:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
		end
	end)

	T.SkinCloseButton(Atr_LUA_ErrorClose)

	for i = 1, Atr_LUA_Error:GetNumChildren() do
		local child = select(i, Atr_LUA_Error:GetChildren())
		if child:GetObjectType() == "Button" and child:GetText() then
			child:SkinButton()
		end
	end
end

T.SkinFuncs["Blizzard_AuctionUI"] = LoadSkin