#include "raylib.h"

#define TARGET_FPS     60

#define SCREEN_WIDTH   800
#define SCREEN_HEIGHT  600

int main(void) {
    // 게임의 목표 FPS를 설정한다.
    SetTargetFPS(TARGET_FPS);
    
    // 게임 창을 생성한다.
    InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "6pm-crew/play");

    // 사용자가 창을 닫거나, `ESC` 키를 누르기 전까지 반복한다.
    while (!WindowShouldClose()) {
        // 게임 화면을 그리기 위해 프레임 버퍼를 초기화한다.
        BeginDrawing();
        
        // 게임 화면을 검은색으로 칠한다.
        ClearBackground(BLACK);

        /* TODO: 텍스처 그리기 */

        // 게임 화면에 현재 FPS를 표시한다.
        DrawFPS(8, 8);

        // 더블 버퍼링 기법을 사용하여, 게임 화면을 그리고,
        // 다음 프레임 버퍼를 준비한다.
        EndDrawing();
    }
    
    // 게임에 할당된 메모리를 해제한다.
    CloseWindow();

    return 0;
}