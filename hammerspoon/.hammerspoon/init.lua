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

---- Alfred Theme Switcher
local alfredLightTheme = "Light"
local alfredDarkTheme  = "Dark"

local function setAlfredTheme(themeName)
    local script = string.format([[
        tell application "Alfred 5"
            set theme "%s"
        end tell
    ]], themeName)
    hs.osascript.applescript(script)
end

local function updateAlfredTheme()
    if hs.host.interfaceStyle() == "Dark" then
        setAlfredTheme(alfredDarkTheme)
    else
        setAlfredTheme(alfredLightTheme)
    end
end

hs.distributednotifications.new(function()
    updateAlfredTheme()
end, "AppleInterfaceThemeChangedNotification"):start()

updateAlfredTheme()