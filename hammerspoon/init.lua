---- Window Maximizer (Whitelist with app + title patterns)

local appPatterns = {
    { app = "^Safari$" },
    { app = "^Microsoft Teams$" },
    { app = "^Code$" },
    { app = "^IntelliJ IDEA$", title = "^.+%s–%s.+$" },
    { app = "^Notes$" },
    { app = "^Mail$" },
    { app = "^Calendar$" },
    { app = "^Things$" },
    { app = "^Anki$", title = "^$" },
    { app = "^Reminders$" },
    { app = "^Telegram$" },
    { app = "^Spotify$" },
    { app = "^ChatGPT$" },
    { app = "^Day One$" },
    { app = "^Google Chrome$" },
    { app = "^Docker Desktop$" },
    { app = "^iTerm2$"},
    { app = "^Finder$"},
}

local minWidth = 600
local minHeight = 400

local function isWhitelisted(appName, windowTitle)
    for _, entry in ipairs(appPatterns) do
        if appName:match(entry.app) then
            if entry.title then
                return windowTitle:match(entry.title) ~= nil
            end
            return true
        end
    end
    return false
end

hs.window.filter.default:subscribe(hs.window.filter.windowCreated, function(win)
    local app = win:application()
    if app then
        local appName = app:name()
        local windowTitle = win:title() or "(no title)"

        print(string.format("Window opened: %s — \"%s\"", appName, windowTitle))

        if win:isStandard() and isWhitelisted(appName, windowTitle) then
            local frame = win:frame()
            if frame.w < minWidth or frame.h < minHeight then
                print(string.format("Skipped (too small): %s — \"%s\"", appName, windowTitle))
                return
            end
            win:maximize()
        end
    end
end)

---

function toggleApplication(appName)
    local app = hs.application.find(appName)
    
    if app then
        if app:isFrontmost() then
            app:hide()
        else
            app:activate()
        end
    else
        hs.application.launchOrFocus(appName)
    end
end

function launchOrFocus(appName)
    hs.application.launchOrFocus(appName)
end

hs.hotkey.bind({"cmd", "alt"}, "t", function()
    toggleApplication("iTerm")
end)

hs.hotkey.bind({"cmd", "alt"}, "s", function()
    toggleApplication("Safari")
end)

hs.hotkey.bind({"cmd", "alt"}, "v", function()
    toggleApplication("Visual Studio Code")
end)

hs.hotkey.bind({"cmd", "alt"}, "n", function()
    toggleApplication("Notes")
end)

hs.hotkey.bind({"cmd", "alt"}, "c", function()
    toggleApplication("ChatGPT")
end)

hs.hotkey.bind({"cmd", "alt"}, "g", function()
    toggleApplication("Google Chrome")
end)

hs.hotkey.bind({"cmd", "alt"}, "i", function()
    toggleApplication("IntelliJ IDEA")
end)

hs.hotkey.bind({"cmd", "alt"}, "m", function()
    toggleApplication("Microsoft Teams")
end)

hs.hotkey.bind({"cmd", "alt"}, "d", function()
    toggleApplication("Things")
end)


hs.notify.new({
    title = "Hammerspoon",
    informativeText = "App launcher configuration loaded"
}):send()