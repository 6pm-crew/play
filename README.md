# 6pm-crew/play

"6pm-crew/play"는 raylib 실습 환경 구축을 위한 템플릿 저장소입니다.

## GNU/Linux 환경에서 GNU/Linux용 실행 파일 만들기

```console
$ make raylib && make
```

## GNU/Linux 환경에서 Windows용 실행 파일 만들기

```console
$ make -f Makefile.mingw raylib
$ make -f Makefile.mingw
```

## GNU/Linux 환경에서 WebAssembly 형태로 컴파일하기

```console
$ sudo apt install build-essential git
$ git clone https://github.com/emscripten-core/emsdk && cd emsdk
$ ./emsdk install latest
$ ./emsdk activate latest
$ source ./emsdk_env.sh
```

```console
$ make -f Makefile.emcc raylib
$ make -f Makefile.emcc
```