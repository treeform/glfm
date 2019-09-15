##
##  GLFM
##  https://github.com/brackeen/glfm
##  Copyright (c) 2014-2017 David Brackeen
##
##  This software is provided 'as-is', without any express or implied warranty.
##  In no event will the authors be held liable for any damages arising from the
##  use of this software. Permission is granted to anyone to use this software
##  for any purpose, including commercial applications, and to alter it and
##  redistribute it freely, subject to the following restrictions:
##
##  1. The origin of this software must not be misrepresented; you must not
##     claim that you wrote the original software. If you use this software in a
##     product, an acknowledgment in the product documentation would be appreciated
##     but is not required.
##  2. Altered source versions must be plainly marked as such, and must not be
##     misrepresented as being the original software.
##  3. This notice may not be removed or altered from any source distribution.
##

const
  GLFM_VERSION_MAJOR* = 0
  GLFM_VERSION_MINOR* = 9
  GLFM_VERSION_REVISION* = 0

##  One of these will be defined:
##  GLFM_PLATFORM_IOS
##  GLFM_PLATFORM_TVOS
##  GLFM_PLATFORM_ANDROID
##  GLFM_PLATFORM_EMSCRIPTEN

when defined(android):
  const
    GLFM_PLATFORM_ANDROID* = true
elif defined(emscripten):
  const
    GLFM_PLATFORM_EMSCRIPTEN* = true
elif defined(ios):
  when TARGET_OS_IOS:
    const
      GLFM_PLATFORM_IOS* = true
  elif TARGET_OS_TV:
    const
      GLFM_PLATFORM_TVOS* = true


##  OpenGL ES includes

# when defined(GLFM_INCLUDE_ES32):
#   when defined(GLFM_PLATFORM_IOS) or defined(GLFM_PLATFORM_TVOS):
#   elif defined(GLFM_PLATFORM_EMSCRIPTEN):

# elif defined(GLFM_INCLUDE_ES31):
#   when defined(GLFM_PLATFORM_IOS) or defined(GLFM_PLATFORM_TVOS):
#   elif defined(GLFM_PLATFORM_EMSCRIPTEN):

# elif defined(GLFM_INCLUDE_ES3):
#   when defined(GLFM_PLATFORM_IOS) or defined(GLFM_PLATFORM_TVOS):
#   elif defined(GLFM_PLATFORM_EMSCRIPTEN):

# elif not defined(GLFM_INCLUDE_NONE):
#   when defined(GLFM_PLATFORM_IOS) or defined(GLFM_PLATFORM_TVOS):


##  MARK: Enums

type
  GLFMRenderingAPI* = enum
    GLFMRenderingAPIOpenGLES2, GLFMRenderingAPIOpenGLES3,
    GLFMRenderingAPIOpenGLES31, GLFMRenderingAPIOpenGLES32
  GLFMColorFormat* = enum
    GLFMColorFormatRGBA8888, GLFMColorFormatRGB565
  GLFMDepthFormat* = enum
    GLFMDepthFormatNone, GLFMDepthFormat16, GLFMDepthFormat24
  GLFMStencilFormat* = enum
    GLFMStencilFormatNone, GLFMStencilFormat8
  GLFMMultisample* = enum
    GLFMMultisampleNone, GLFMMultisample4X


## GLFMUserInterfaceChrome defines whether system UI chrome (status bar, navigation bar) is shown.
## This value is ignored on Emscripten.
## GLFMUserInterfaceChromeNavigation (default)
##  - Android: Show the navigation bar
##  - iOS: Show the home indicator on iPhone X
## GLFMUserInterfaceChromeNavigationAndStatusBar:
##  - Android: Show the navigation bar and status bar
##  - iOS: Show status bar, and show the home indicator on iPhone X
## GLFMUserInterfaceChromeFullscreen
##  - Android 2.3: Fullscreen
##  - Android 4.0 - 4.3: Navigation bar dimmed
##  - Android 4.4: Fullscreen immersive mode
##  - iOS: Fullscreen

type
  GLFMUserInterfaceChrome* = enum
    GLFMUserInterfaceChromeNavigation,
    GLFMUserInterfaceChromeNavigationAndStatusBar,
    GLFMUserInterfaceChromeFullscreen
  GLFMUserInterfaceOrientation* = enum
    GLFMUserInterfaceOrientationAny, GLFMUserInterfaceOrientationPortrait,
    GLFMUserInterfaceOrientationLandscape
  GLFMTouchPhase* = enum
    GLFMTouchPhaseHover, GLFMTouchPhaseBegan, GLFMTouchPhaseMoved,
    GLFMTouchPhaseEnded, GLFMTouchPhaseCancelled
  GLFMMouseCursor* = enum
    GLFMMouseCursorAuto, GLFMMouseCursorNone, GLFMMouseCursorDefault,
    GLFMMouseCursorPointer, GLFMMouseCursorCrosshair, GLFMMouseCursorText
  GLFMKey* = enum
    GLFMKeyBackspace = 0x00000008, GLFMKeyTab = 0x00000009, GLFMKeyEnter = 0x0000000D,
    GLFMKeyEscape = 0x0000001B, GLFMKeySpace = 0x00000020, GLFMKeyLeft = 0x00000025,
    GLFMKeyUp = 0x00000026, GLFMKeyRight = 0x00000027, GLFMKeyDown = 0x00000028,
    GLFMKeyNavBack = 0x00001000, GLFMKeyNavMenu = 0x00001001,
    GLFMKeyNavSelect = 0x00001002, GLFMKeyPlayPause = 0x00002000
  GLFMKeyModifier* = enum
    GLFMKeyModifierShift = (1 shl 0), GLFMKeyModifierCtrl = (1 shl 1),
    GLFMKeyModifierAlt = (1 shl 2), GLFMKeyModifierMeta = (1 shl 3)
  GLFMKeyAction* = enum
    GLFMKeyActionPressed, GLFMKeyActionRepeated, GLFMKeyActionReleased

##  MARK: Structs and function pointers
type
  GLFMDisplay* = pointer

## Function pointer returned from glfmGetProcAddress

type
  GLFMProc* = proc ()

## Main loop callback function. The frame time is in seconds, and is not related to wall time.

type
  GLFMMainLoopFunc* = proc (display: ptr GLFMDisplay; frameTime: cdouble)

## Callback function for mouse or touch events. The (x,y) values are in pixels.
## The function should return true if the event was handled, and false otherwise.

type
  GLFMTouchFunc* = proc (display: ptr GLFMDisplay; touch: cint; phase: GLFMTouchPhase;
                      x: cdouble; y: cdouble): bool

## Callback function for key events.
## The function should return true if the event was handled, and false otherwise.

type
  GLFMKeyFunc* = proc (display: ptr GLFMDisplay; keyCode: GLFMKey;
                    action: GLFMKeyAction; modifiers: cint): bool

## Callback function for character input events.

type
  GLFMCharFunc* = proc (display: ptr GLFMDisplay; utf8: cstring; modifiers: cint)

## Callback function for keyboard visibility, in pixels.

type
  GLFMKeyboardVisibilityChangedFunc* = proc (display: ptr GLFMDisplay; visible: bool;
      x: cdouble; y: cdouble; width: cdouble; height: cdouble)

## Callback when the surface could not be created.

type
  GLFMSurfaceErrorFunc* = proc (display: ptr GLFMDisplay; message: cstring)

## Callback function when the OpenGL surface is created

type
  GLFMSurfaceCreatedFunc* = proc (display: ptr GLFMDisplay; width: cint; height: cint)

## Callback function when the OpenGL surface is resized (or rotated).

type
  GLFMSurfaceResizedFunc* = proc (display: ptr GLFMDisplay; width: cint; height: cint)

## Callback function when the OpenGL surface is destroyed.

type
  GLFMSurfaceDestroyedFunc* = proc (display: ptr GLFMDisplay)

## Callback function when the system recieves a low memory warning.

type
  GLFMMemoryWarningFunc* = proc (display: ptr GLFMDisplay)
  GLFMAppFocusFunc* = proc (display: ptr GLFMDisplay; focused: bool)

##  MARK: Functions
## Main entry point for the app, where the display can be initialized and the GLFMMainLoopFunc
## can be set.

{.push importc.}

proc glfmMain*(display: ptr GLFMDisplay)
## Init the display condifuration. Should only be called in glfmMain.
## If the device does not support the preferred rendering API, the next available rendering API is
## chosen (OpenGL ES 3.0 if OpenGL ES 3.1 is not available, and OpenGL ES 2.0 if OpenGL ES 3.0 is
## not available). Call glfmGetRenderingAPI in the GLFMSurfaceCreatedFunc to see which rendering
## API was chosen.

proc glfmSetDisplayConfig*(display: ptr GLFMDisplay; preferredAPI: GLFMRenderingAPI;
                          colorFormat: GLFMColorFormat;
                          depthFormat: GLFMDepthFormat;
                          stencilFormat: GLFMStencilFormat;
                          multisample: GLFMMultisample)
proc glfmSetUserData*(display: ptr GLFMDisplay; userData: pointer)
proc glfmGetUserData*(display: ptr GLFMDisplay): pointer
## Sets the allowed user interface orientations

proc glfmSetUserInterfaceOrientation*(display: ptr GLFMDisplay; allowedOrientations: GLFMUserInterfaceOrientation)
## Returns the allowed user interface orientations

proc glfmGetUserInterfaceOrientation*(display: ptr GLFMDisplay): GLFMUserInterfaceOrientation
## Sets whether multitouch input is enabled. By default, multitouch is disabled.

proc glfmSetMultitouchEnabled*(display: ptr GLFMDisplay; multitouchEnabled: bool)
## Gets whether multitouch input is enabled. By default, multitouch is disabled.

proc glfmGetMultitouchEnabled*(display: ptr GLFMDisplay): bool
## Gets the display size, in pixels.

proc glfmGetDisplaySize*(display: ptr GLFMDisplay; width: ptr cint; height: ptr cint)
## Gets the display scale. On Apple devices, the value will be 1.0 for non-retina displays and 2.0
## for retina.

proc glfmGetDisplayScale*(display: ptr GLFMDisplay): cdouble
## Gets the chrome insets, in pixels (AKA "safe area insets" in iOS). This is the space taken
## on the outer edges of the display by status bars, navigation bars, and other UI elements.

proc glfmGetDisplayChromeInsets*(display: ptr GLFMDisplay; top: ptr cdouble;
                                right: ptr cdouble; bottom: ptr cdouble;
                                left: ptr cdouble)
## Gets the user interface chrome.

proc glfmGetDisplayChrome*(display: ptr GLFMDisplay): GLFMUserInterfaceChrome
## Sets the user interface chrome.
## On Emscripten, to switch to fullscreen, this function must be called from an user-generated event handler.

proc glfmSetDisplayChrome*(display: ptr GLFMDisplay;
                          uiChrome: GLFMUserInterfaceChrome)
## Gets the rendering API of the display. The return value is not valid until the surface is
## created. Defaults to GLFMRenderingAPIOpenGLES2.

proc glfmGetRenderingAPI*(display: ptr GLFMDisplay): GLFMRenderingAPI
## Gets whether the display has touch capabilities.

proc glfmHasTouch*(display: ptr GLFMDisplay): bool
## Sets the mouse cursor (only on platforms with a mouse)

proc glfmSetMouseCursor*(display: ptr GLFMDisplay; mouseCursor: GLFMMouseCursor)
## Checks if a named OpenGL extension is supported

proc glfmExtensionSupported*(extension: cstring): bool
## Gets the address of the specified function.

proc glfmGetProcAddress*(functionName: cstring): GLFMProc
## Sets the function to call before each frame is displayed.

proc glfmSetMainLoopFunc*(display: ptr GLFMDisplay; mainLoopFunc: GLFMMainLoopFunc)
## Sets the function to call when a mouse or touch event occurs.

proc glfmSetTouchFunc*(display: ptr GLFMDisplay; touchFunc: GLFMTouchFunc)
## Sets the function to call when a key event occurs.
## Note, on iOS, only pressed events are sent (no repeated or released events) and with no
## modifiers.

proc glfmSetKeyFunc*(display: ptr GLFMDisplay; keyFunc: GLFMKeyFunc)
## Sets the function to call when character input events occur.

proc glfmSetCharFunc*(display: ptr GLFMDisplay; charFunc: GLFMCharFunc)
## Sets the function to call when the surface could not be created.
## For example, the browser does not support WebGL.

proc glfmSetSurfaceErrorFunc*(display: ptr GLFMDisplay;
                             surfaceErrorFunc: GLFMSurfaceErrorFunc)
## Sets the function to call when the surface was created.

proc glfmSetSurfaceCreatedFunc*(display: ptr GLFMDisplay;
                               surfaceCreatedFunc: GLFMSurfaceCreatedFunc)
## Sets the function to call when the surface was resized (or rotated).

proc glfmSetSurfaceResizedFunc*(display: ptr GLFMDisplay;
                               surfaceResizedFunc: GLFMSurfaceResizedFunc)
## Sets the function to call when the surface was destroyed. For example, OpenGL context loss.
## All OpenGL resources should be deleted in this call.

proc glfmSetSurfaceDestroyedFunc*(display: ptr GLFMDisplay;
                                 surfaceDestroyedFunc: GLFMSurfaceDestroyedFunc)
proc glfmSetMemoryWarningFunc*(display: ptr GLFMDisplay;
                              lowMemoryFunc: GLFMMemoryWarningFunc)
proc glfmSetAppFocusFunc*(display: ptr GLFMDisplay; focusFunc: GLFMAppFocusFunc)
## Requests to show or hide the onscreen virtual keyboard. On Emscripten, this function does
## nothing.

proc glfmSetKeyboardVisible*(display: ptr GLFMDisplay; visible: bool)
## Returns true if the virtual keyboard is currently visible.

proc glfmIsKeyboardVisible*(display: ptr GLFMDisplay): bool
## Sets the function to call when the virtual keyboard changes visibility or changes bounds.

proc glfmSetKeyboardVisibilityChangedFunc*(display: ptr GLFMDisplay;
    visibilityChangedFunc: GLFMKeyboardVisibilityChangedFunc)
when defined(android):
  proc glfmAndroidGetActivity*(): pointer #ptr ANativeActivity

{.pop.}