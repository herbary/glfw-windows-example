#ifndef HERBARY_GLFW_WINDOWS_EXAMPLE_LOCAL_DEFINE_GL3W_H_INCLUDED
#define HERBARY_GLFW_WINDOWS_EXAMPLE_LOCAL_DEFINE_GL3W_H_INCLUDED

#include "gl3w/gl3w.h"

typedef GLboolean gl_bool_t;
typedef GLbyte gl_sint8_t;
typedef GLubyte gl_uint8_t;
typedef GLshort gl_sint16_t;
typedef GLushort gl_uint16_t;
typedef GLint gl_sint32_t;
typedef GLuint gl_uint32_t;
typedef GLint64 gl_sint64_t;
typedef GLuint64 gl_uint64_t;
typedef GLsizei gl_usize_t;
typedef GLenum gl_enum_t;
typedef GLintptr gl_sintptr_t;
typedef GLsizeiptr gl_usizeptr_t;
typedef GLsync gl_sync_t;
typedef GLbitfield gl_bitfield_t;
typedef GLhalf gl_float16_t;
typedef GLfloat gl_float32_t;
typedef GLclampf gl_float32_clamp_t;
typedef GLdouble gl_float64_t;
typedef GLclampd gl_float64_clamp_t;

typedef gl_sint8_t gl_int8_t;
typedef gl_sint16_t gl_int16_t;
typedef gl_sint32_t gl_int32_t;
typedef gl_sint64_t gl_int64_t;
typedef gl_usize_t gl_size_t;
typedef gl_sintptr_t gl_intptr_t;
typedef gl_usizeptr_t gl_sizeptr_t;

#define GL_SINT8 GL_BYTE
#define GL_UINT8 GL_UNSIGNED_BYTE
#define GL_SINT16 GL_SHORT
#define GL_UINT16 GL_UNSIGNED_SHORT
#define GL_SINT32 GL_INT
#define GL_UINT32 GL_UNSIGNED_INT
#define GL_FLOAT16 GL_HALF_FLOAT
#define GL_FLOAT32 GL_FLOAT
#define GL_FLOAT64 GL_DOUBLE

#define GL_INT8 GL_SINT8
#define GL_INT16 GL_SINT16
#define GL_INT32 GL_SINT32

#define gl3w_init() !gl3wInit()
#define gl_viewport glViewport
#define gl_clear_color glClearColor
#define gl_clear glClear

#endif // HERBARY_GLFW_WINDOWS_EXAMPLE_LOCAL_DEFINE_GL3W_H_INCLUDED
