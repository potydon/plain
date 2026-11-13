-- Workspaces: all ten live on HDMI-A-1, workspace 1 is the default
hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1", default = true })

for i = 2, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1" })
end
