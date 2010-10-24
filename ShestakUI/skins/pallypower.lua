----------------------------------------------------------------------------------------
--	By MrRuben5
----------------------------------------------------------------------------------------
if not SettingsCF["skins"].pallypower == true then return end

local PPSkin = CreateFrame("Frame")
PPSkin:RegisterEvent("PLAYER_LOGIN")
PPSkin:SetScript("OnEvent", function(self, event, addon)
	if IsAddOnLoaded("PallyPower") then
		local _G = _G
		local _, frame, tex, settings
		local font = SettingsCF.media.pixel_font
		local one = SettingsDB.Scale(1)
		local two = SettingsDB.Scale(2)
		local three = SettingsDB.Scale(3)
		local four = SettingsDB.Scale(4)
		local thirty = SettingsDB.Scale(30)
		local forty = SettingsDB.Scale(40)
		local sixty = SettingsDB.Scale(60)
		local hundred = SettingsDB.Scale(100)		
		
		self.db = LibStub("AceDB-3.0"):New("PallyPowerDB", PallyPower.defaults, "Default")
		settings = self.db.profile
		settings.buffscale = one
		settings.display.buttonWidth = hundred+three
		settings.display.buttonHeight = forty-three
		
		local _applyskin = PallyPower.ApplySkin
		function PallyPower:ApplySkin(skinname)

			local needSkinning = {PallyPowerAutoBtn, PallyPowerRFBtn, PallyPowerAuraBtn}
			
			for _, frame in pairs(needSkinning) do
				frame:SetBackdrop({
					bgFile = SettingsCF["media"].blank,
					insets = { left = two, right = two, top = two, bottom = two }
				})
				if not frame.bg then
					frame.bg = CreateFrame('Frame', nil, frame)
					frame.bg:SetAllPoints(frame)
					frame.bg:SetFrameLevel(frame:GetFrameLevel()-1)
					SettingsDB.SkinFadedPanel(frame.bg)
				end
				
				local fname = frame:GetName()
				for _, fontstring in pairs({"Time", "Text", "TimeSeal"}) do
					local fs = _G[fname..fontstring]
					if fs then
						local _, size = fs:GetFont()
						fs:SetFont(font, SettingsCF["media"].pixel_font_size/settings.buffscale, SettingsCF["media"].pixel_font_style)
						fs:SetShadowColor(0, 0, 0, 0)
						if not fname:find("PowerC%d+P%d+$") then
							if fontstring == "Text" then
								fs:ClearAllPoints()
								fs:SetJustifyH("LEFT")
								fs:SetWidth(999)
								fs:SetPoint("TOPLEFT", thirty+three, 0)
							else
								fs:ClearAllPoints()
								fs:SetWidth(999)
								fs:SetJustifyH("RIGHT")
								fs:SetPoint("RIGHT", frame, "RIGHT", -four, 0)
							end
						end
					end
				end
				for _, tex in pairs({"Icon", "IconAura", "BuffIcon", "IconSeal", "IconRF"}) do
					if _G[fname..tex] and not _G[fname..'New'..tex] then
						local oldicon = _G[fname..tex]
						oldicon:SetAlpha(0)	
						oldicon:ClearAllPoints()
						-- Swap seal and RF icon
						if fname == "PallyPowerAuraBtn" then
							if tex == "IconSeal" then
								oldicon:SetPoint("LEFT", four, 0)
							else
								oldicon:SetPoint("LEFT", thirty + four, 0)
							end
						-- Aura icon / Auto icon
						elseif fname:find("(Au[rt][ao])$") then
							oldicon:SetPoint("LEFT", four, 0)
						else
							oldicon:SetPoint("TOPLEFT", four, -four)
						end
						
						local panel = CreateFrame("Frame", fname..'New'..tex, frame)
						panel:SetAllPoints(oldicon)
						SettingsDB.CreateTemplate(panel)
						
						local icon = panel:CreateTexture()
						panel.icon = panel
						icon:SetPoint("TOPLEFT", panel, SettingsDB.Scale(2), SettingsDB.Scale(-2))
						icon:SetPoint("BOTTOMRIGHT", panel, SettingsDB.Scale(-2), SettingsDB.Scale(2))
						icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
						icon:SetTexture(oldicon:GetTexture())
						-- ? :)
						oldicon.SetTexture = function(tex,texstring)
							icon:SetTexture(texstring)
							-- Hide the border/bg if icon:SetTexture() is sued to hide the icon
							if not texstring then
								panel:SetAlpha(0)
							else
								panel:SetAlpha(1)
							end
						end
						oldicon.SetVertexColor = function(self, ...)
						icon:SetVertexColor(...)
						end
					end
				end			
			end
		end

		local _updatelayout = PallyPower.UpdateLayout
		function PallyPower:UpdateLayout()
			_updatelayout(self)
			
			-- Update button layout for aura, rf and auto
			for _, button in pairs({PallyPowerAutoBtn, PallyPowerRFBtn, PallyPowerAuraBtn}) do
				local a, p, b, x, y = button:GetPoint()
				
				--local align = tonumber(self.opt.display.alignClassButtons)
				
				--y = align < 4 and (y - three) or (y + three)
				y = y + three
				
				if not InCombatLockdown() then
					button:SetPoint(a,p,b,x,y)
				end
			end
		end
		PallyPower:ApplySkin()
		PallyPower:UpdateLayout()
	end
end)