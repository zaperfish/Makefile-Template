# Compiler and flags
CXX := c++
CXXFLAGS := --std=c++98 -Wall

# Final binary
BIN := webserver

# Directories
SRC_DIR := src
BIN_DIR := bin
BLD_DIR := build

# List all source files
SRC :=	src/main.cpp \
		src/Utils/Utils.cpp \
		src/Webserver/Webserver.cpp \
		src/Webserver/ConfigParser.cpp  

OBJ := $(addprefix $(BLD_DIR)/, $(SRC:.cpp=.o))

# Dependency files
DEP := $(OBJ:.o=.d)

# Default target named after the binary
BIN := $(BIN_DIR)/$(BIN)

# Build rules
all: $(BIN)

$(BIN): $(OBJ)
	@mkdir -p $(BIN_DIR)
	$(CXX) $(CXXFLAGS) $(OBJ) -o $@

$(BLD_DIR)/%.o: %.cpp
	@mkdir -p $(BLD_DIR)
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -MMD -c $< -o $@

# Include the dependency files
-include $(DEP)

clean:
	rm -rf $(BLD_DIR)

fclean: clean
	rm -rf $(BIN_DIR)

re: fclean all

print-%:
	@echo $* = $($*)

.PHONY: all clean fclean re print
