import sys

def main(word: str):
    print(word)





if __name__ == "__main__":
    try:
        main(sys.argv[1])
    except Exception as e:
        print(e)
