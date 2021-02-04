//
//  cimguizmo.h
//  
//
//  Created by Josef Zoller on 24.01.21.
//

#ifndef cimguizmo_h
#define cimguizmo_h

#include <stdio.h>
#include <stdint.h>
#include <string.h>

#ifndef __cplusplus
    #include <stdarg.h>
    #include <stdbool.h>
#endif


#include <cimgui.h>


#ifdef __cplusplus
extern "C" {
#endif


void igzSetDrawlist(CImDrawList * drawlist);
void igzBeginFrame();

void igzSetImGuiContext(CImGuiContext * ctx);

bool igzIsOver();
bool igzIsUsing();
void igzEnable(bool enable);

void igzDecomposeMatrixToComponents(const float * matrix, float * translation, float * rotation, float * scale);
void igzRecomposeMatrixFromComponents(const float * translation, const float * rotation, const float * scale, float * matrix);

void igzSetRect(float x, float y, float width, float height);
void igzSetOrthographic(bool isOrthographic);

void igzDrawCubes(const float * view, const float * projection, const float * matrices, int matrixCount);
void igzDrawGrid(const float * view, const float * projection, const float * matrix, const float gridSize);


typedef enum {
   TRANSLATE,
   ROTATE,
   SCALE,
   BOUNDS,
} C_OPERATION;

typedef enum {
   LOCAL,
   WORLD
} C_MODE;

bool igzManipulate(const float * view, const float * projection, C_OPERATION operation, C_MODE mode, float * matrix, float * deltaMatrix, const float * snap, const float * localBounds, const float * boundsSnap);
void igzViewManipulate(float * view, float length, CImVec2 position, CImVec2 size, CImU32 backgroundColor);

void igzSetID(int id);

bool igzIsOverOperation(C_OPERATION op);
void igzSetGizmoSizeClipSpace(float value);


#ifdef __cplusplus
}
#endif

#endif /* cimguizmo_h */
