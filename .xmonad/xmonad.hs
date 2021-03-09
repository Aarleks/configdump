import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run -- for spawnPipe
import XMonad.Util.EZConfig -- for easier reading of keybindings
import System.IO -- for hPutStrLn for xmobar
import System.Exit
import qualified XMonad.StackSet as W

{- TODO
- Get rid of defaultConfig
- Xmonad.Prompt.Ssh - for sshing
- Xmonad.Prompt.Man - for looking up man pages
- Xmonad.Prompt.Search?? - for browser, scholar, etc. searches

-}

-- MY DEFAULTS --
-----------------
myModMask = mod4Mask       -- Sets modkey to super/windows key
myTerminal = "alacritty"   -- Sets default terminal
myBorderWidth = 1          -- Sets border width for windows
myNormColor   = "#282C34"  -- Border color of normal windows
myFocusColor  = "#B48EAD"  -- Border color of focused windows
myFocusFollowsMouse = True

myKeys =
    [("M-C-q", spawn "xmonad --recompile; xmonad --restart")
    , ("M-b", spawn "xbar" >> sendMessage ToggleStruts)
    , ("M-c", spawn "togglecam")
    , ("M-e", spawn (myTerminal ++ " -e email"))
    , ("M-f", spawn (myTerminal ++ " -e lf"))
    , ("M-m", spawn (myTerminal ++ " -e ncmpcpp"))
    , ("M-q", kill)
    , ("M-x", spawn "slock")
    ]

{-
This is a block comment
-}

myWorkspaces = [" \62543 ","2","3","4","5"," \63212 ","7","8","9"]

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ docks defaultConfig
        { manageHook = manageHook defaultConfig -- make sure to include myManageHook definition from above
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "#8FBCBB" "" . shorten 50
                        }
        , modMask = myModMask
	, borderWidth = myBorderWidth
	, normalBorderColor = myNormColor
	, focusedBorderColor = myFocusColor
	, workspaces = myWorkspaces
        }
	`additionalKeysP` myKeys
