GXXFLAGS=`pkg-config --cflags --libs gtkmm-4.0` -std=c++17 -Wall -Wextra -Wconversion

all: binary

binary: knobs

knobs: main.cpp config.hpp $(wildcard ui/*.hpp)
	g++ $(GXXFLAGS) -o knobs main.cpp
