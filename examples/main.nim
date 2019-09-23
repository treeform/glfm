##  Example app that draws a triangle. The triangle can be moved via touch or keyboard arrow keys.

import glfm, opengl


type
  ExampleApp* = object
    program*: GLuint
    vertexBuffer*: GLuint
    lastTouchX*: cdouble
    lastTouchY*: cdouble
    offsetX*: cdouble
    offsetY*: cdouble


proc onFrame*(display: ptr GLFMDisplay; frameTime: cdouble)
proc onSurfaceCreated*(display: ptr GLFMDisplay; width: cint; height: cint)
proc onSurfaceDestroyed*(display: ptr GLFMDisplay)
proc onTouch*(display: ptr GLFMDisplay; touch: cint; phase: GLFMTouchPhase; x: cdouble;
             y: cdouble): bool
proc onKey*(display: ptr GLFMDisplay; keyCode: GLFMKey; action: GLFMKeyAction;
           modifiers: cint): bool
##  Main entry point


var app: ExampleApp

proc NimMain() {.importc.} # use --noMain:on which generates NimMain() instead of C main()

proc glfmMain*(display: ptr GLFMDisplay) {.exportc.} =

  # echo "run NimMain"
  NimMain() # call nim main to setup GC and other things.
  # echo "end of NimMain"

  echo "test allocation"
  var s = newSeq[byte](100)
  echo s.len
  echo "done allocation test"

  #var app: ptr ExampleApp = calloc(1, sizeof((ExampleApp)))
  #app = ExampleApp()

  glfmSetDisplayConfig(display, GLFMRenderingAPIOpenGLES2,
                       GLFMColorFormatRGBA8888, GLFMDepthFormatNone,
                       GLFMStencilFormatNone, GLFMMultisampleNone)
  glfmSetUserData(display, addr app)
  glfmSetSurfaceCreatedFunc(display, onSurfaceCreated)
  glfmSetSurfaceResizedFunc(display, onSurfaceCreated)
  glfmSetSurfaceDestroyedFunc(display, onSurfaceDestroyed)
  glfmSetMainLoopFunc(display, onFrame)
  glfmSetTouchFunc(display, onTouch)
  glfmSetKeyFunc(display, onKey)

proc onTouch*(display: ptr GLFMDisplay; touch: cint; phase: GLFMTouchPhase; x: cdouble;
             y: cdouble): bool =
  if phase == GLFMTouchPhaseHover:
    return false
  #var app: ptr ExampleApp = cast[ptr ExampleApp](glfmGetUserData(display))
  if phase != GLFMTouchPhaseBegan:
    var
      width: cint
      height: cint
    glfmGetDisplaySize(display, addr(width), addr(height))
    #inc(app.offsetX, 2 * (x - app.lastTouchX) / float(width))
    app.offsetX += 2 * (x - app.lastTouchX) / float(width)
    #dec(app.offsetY, 2 * (y - app.lastTouchY) / float(height))
    app.offsetY -= 2 * (y - app.lastTouchY) / float(height)

    echo "touch", app.offsetX, " ", app.offsetY


  app.lastTouchX = x
  app.lastTouchY = y
  return true

proc onKey*(display: ptr GLFMDisplay; keyCode: GLFMKey; action: GLFMKeyAction;
           modifiers: cint): bool =
  var handled: bool = false
  if action == GLFMKeyActionPressed:
    #var app: ptr ExampleApp = cast[ptr ExampleApp](glfmGetUserData(display))
    case keyCode
    of GLFMKeyLeft:
      app.offsetX -= 0.1
      handled = true
    of GLFMKeyRight:
      app.offsetX += 0.1
      handled = true
    of GLFMKeyUp:
      app.offsetY -= 0.1
      handled = true
    of GLFMKeyDown:
      app.offsetY += 0.1
      handled = true
    else:
      discard
  return handled

proc onSurfaceCreated*(display: ptr GLFMDisplay; width: cint; height: cint) =
  glViewport(0, 0, width, height)
  var api: GLFMRenderingAPI = glfmGetRenderingAPI(display)
  # printf("Hello from GLFM! Using OpenGL %s\n", if api ==
  #     GLFMRenderingAPIOpenGLES32: "ES 3.2" else: if api ==
  #     GLFMRenderingAPIOpenGLES31: "ES 3.1" else: if api ==
  #     GLFMRenderingAPIOpenGLES3: "ES 3.0" else: "ES 2.0")

proc onSurfaceDestroyed*(display: ptr GLFMDisplay) =
  ##  When the surface is destroyed, all existing GL resources are no longer valid.
  #var app: ptr ExampleApp = cast[ptr ExampleApp](glfmGetUserData(display))
  app.program = 0
  app.vertexBuffer = 0

proc compileShader*(`type`: GLenum; shaderString: string): GLuint =

  # var fullPath: array[PATH_MAX, char]
  # fc_resdir(fullPath, sizeof((fullPath)))
  # strncat(fullPath, shaderName, sizeof((fullPath)) - strlen(fullPath) - 1)
  # ##  Get shader string
  # var shaderString: cstring = nil
  # var shaderFile: ptr FILE = fopen(fullPath, "rb")
  # if shaderFile:
  #   fseek(shaderFile, 0, SEEK_END)
  #   var length: clong = ftell(shaderFile)
  #   fseek(shaderFile, 0, SEEK_SET)
  #   shaderString = malloc(length + 1)
  #   if shaderString:
  #     fread(shaderString, length, 1, shaderFile)
  #     shaderString[length] = 0
  #   fclose(shaderFile)
  # if not shaderString:
  #   printf("Couldn\'t read file: %s\n", fullPath)
  #   return 0

  var shader: GLuint = glCreateShader(`type`)
  var shaderTextArr = [cstring(shaderString)]
  echo "glShaderSource..."
  glShaderSource(shader, 1, cast[cstringArray](shaderTextArr.addr), nil)
  echo "glCompileShader..."
  glCompileShader(shader)
  #free(shaderString)
  #  Check compile status

  var status: GLint
  glGetShaderiv(shader, GL_COMPILE_STATUS, addr(status))
  if status == GLint(GL_FALSE):
    echo "So... Couldn't compile shader"
    var logLength: GLint
    echo "glGetShaderiv GL_INFO_LOG_LENGTH"
    glGetShaderiv(shader, GL_INFO_LOG_LENGTH, addr(logLength))
    echo "Log lengh ", logLength
    if logLength > 0:
      var log = newStringOfCap(logLength)
      glGetShaderInfoLog(shader, logLength, addr(logLength), log)
      echo("Shader log: ", log)
    glDeleteShader(shader)
    shader = 0
  return shader

# const
#   simpleVert = staticRead("simple.vert")
#   simpleFrag = staticRead("simple.frag")

proc readAssetFile*(filename: string): string =
  let size = int glfmReadFileSize(filename)
  result = newString(size)
  discard glfmReadFileBuffer(filename, result)

proc onFrame*(display: ptr GLFMDisplay; frameTime: cdouble) {.exportc.} =
  #var app: ptr ExampleApp = cast[ptr ExampleApp](glfmGetUserData(display))
  #echo "onFrame"
  ##  Draw background
  glClearColor(0.0, 0.0, 0.0, 1.0)
  glClear(GL_COLOR_BUFFER_BIT)
  ##  Draw triangle
  if app.program == 0:
    echo "setup"
    var vertShader: GLuint = compileShader(GL_VERTEX_SHADER, readAssetFile("simple.vert"))
    var fragShader: GLuint = compileShader(GL_FRAGMENT_SHADER, readAssetFile("simple.frag"))
    if vertShader == 0 or fragShader == 0:
      glfmSetMainLoopFunc(display, nil)
      return
    app.program = glCreateProgram()
    glAttachShader(app.program, vertShader)
    glAttachShader(app.program, fragShader)
    glBindAttribLocation(app.program, 0, "a_position")
    glBindAttribLocation(app.program, 1, "a_color")
    glLinkProgram(app.program)
    glDeleteShader(vertShader)
    glDeleteShader(fragShader)
    echo "setup done"

  glUseProgram(app.program)
  if app.vertexBuffer == 0:
    glGenBuffers(1, addr(app.vertexBuffer))
  glBindBuffer(GL_ARRAY_BUFFER, app.vertexBuffer)
  var stride: GLsizei = sizeof(GLfloat) * 6
  glEnableVertexAttribArray(0)
  glVertexAttribPointer(0, 3, cGL_FLOAT, GL_FALSE, stride, cast[pointer](0))
  glEnableVertexAttribArray(1)
  glVertexAttribPointer(1, 3, cGL_FLOAT, GL_FALSE, stride, cast[pointer](sizeof(GLfloat) * 3))

  var vertices = @[
    app.offsetX.float32 + 0.0.float32, app.offsetY.float32 + 0.5, 0.0, 1.0, 0.0, 0.0,
    app.offsetX.float32 - 0.5.float32, app.offsetY.float32 - 0.5, 0.0, 0.0, 1.0, 0.0,
    app.offsetX.float32 + 0.5.float32, app.offsetY.float32 - 0.5, 0.0, 0.0, 0.0, 1.0] ##  x,y,z, r,g,b

  glBufferData(GL_ARRAY_BUFFER, vertices.len*4, addr(vertices[0]), GL_STATIC_DRAW)
  glDrawArrays(GL_TRIANGLES, 0, 3)


echo "test allocation 1"
var s = newSeq[byte](100)
echo s.len
echo "done allocation test 1"

#glfmStart()