if __name__ == '__main__':

    try:
        with open("course.txt", mode='r', encoding="utf-8") as f:
            for line in f:
                print(line)

    except FileNotFoundError as e:

        with open("course.txt", mode='w', encoding="utf-8") as f:
            pass


