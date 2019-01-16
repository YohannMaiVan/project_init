# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: yomai-va <yomai-va@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/12/05 19:40:56 by yomai-va          #+#    #+#              #
#    Updated: 2019/01/16 21:20:40 by yomai-va         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

############################## BIN #############################################

NAME = __PROJECT_NAME__

SRC = __PROJECT_NAME__.c

CC = clang

SRCDIR = srcs

OBJDIR = objs

OBJ = $(addprefix ${OBJDIR}/, $(SRC:.c=.o))

DEP = $(addprefix ${OBJDIR}/, $(SRC:.c=.d))

CFLAGS = -Wall -Wextra -Werror -fsanitize=address,undefined -g -MMD

LDFLAGS = -Ilibft/includes/ -Iincludes/

LIB = -Llibft/ -lft

EXT = libft/libft.a

############################## RULES ###########################################

all: ${NAME}

libft/%:
	@[[ -d libft ]] || (echo Cloning"   "[libft]... && git clone https://github.com/YohannMaiVan/Libft &>/dev/null)
	@make -C libft

${NAME}: ${OBJ}
	@echo ${B}Compiling [${NAME}]...
	@${CC} ${CFLAGS} ${LDFLAGS} ${LIB} -o $@ ${OBJ}
	@echo ${G}Success"   "[${NAME}]

${OBJDIR}/%.o: ${SRCDIR}/%.c ${EXT}
	@echo Compiling [$@]...
	@/bin/mkdir -p ${OBJDIR}
	@${CC} ${CFLAGS} ${LDFLAGS} -c -o $@ $<

############################## GENERAL #########################################

clean:
	@echo Cleaning"  "[libft objs]...
	@make -C libft/ clean
	@echo Cleaning"  "[objs]...
	@/bin/rm -Rf ${OBJDIR}

fclean: clean
	@make -C libft/ fclean
	@echo Cleaning"  "[${NAME}]...
	@/bin/rm -f ${NAME}
	@/bin/rm -Rf ${NAME}.dSYM

re: fclean all

.PHONY: all clean fclean re

-include ${DEP}
