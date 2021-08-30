import sys
def to_rgb(hex_val):
    r=int(hex_val[0:2], 16)
    g=int(hex_val[2:4], 16)
    b=int(hex_val[4:], 16)
    print(f'#{hex_val}=({r},{g},{b})')

if __name__ == "__main__":
    to_rgb("928374")


