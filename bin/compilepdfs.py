import argparse
import subprocess
import os
import sys
from colorama import Fore
from colorama import Style

def log(i: str, a=False):
    if args.Verbose:
        with open("./test.log", 'a') as f:
            f.write(i)
            f.write("\n")
        print(i)
    elif (args.verbose or a):
        print(i)

def main(inp: str):
    out = "."
    if not os.path.isdir(inp):
        log(f"{Fore.RED}input path is not a directory{Style.RESET_ALL}", True)
        quit()
    files = find_files(inp)
    compilepdfs(files)
    cleanup(inp)
    move_files(files)

def find_files(inp: str):
    files=[]
    if args.recursive:
        for r, d, f in os.walk(inp):
            for file in f:
                if file.endswith(".tex"):
                    files.append(os.path.join(r, file))
    else:
        for file in os.listdir(inp):
            if file.endswith(".tex"):
                files.append(file)
    log(files)
    return(files)

def create_folder(folder: str):
        if not os.path.exists(folder):
            process = subprocess.run(["mkdir", "-p", folder])
            log("mkdir {}".format(folder))
            if process.returncode != 0:
                log(f"{Fore.RED}directory could not be made{Style.RESET_ALL}", True)
                quit()

def move_files(files):
    folder = "compiledpdfs"
    if args.output == None:
        create_folder("compiledpdfs")
    else:
        create_folder(args.output)
        folder=args.output
    for File in files:
        subprocess.run(["mv", "{}.pdf".format(get_file_name(File)), folder])
        log("mv {}.pdf {}".format(get_file_name(File), folder))

def remove_files(file: str):
    rm=open("/dev/null", 'w')
    subprocess.run(["rm", "{}.log".format(get_file_name(file))], stdout=rm, stderr=subprocess.STDOUT)
    log("rm {}.log".format(get_file_name(file)))
    subprocess.run(["rm", "{}.aux".format(get_file_name(file))], stdout=rm, stderr=subprocess.STDOUT)
    log("rm {}.aux".format(get_file_name(file)))
    subprocess.run(["rm", "{}.toc".format(get_file_name(file))], stdout=rm, stderr=subprocess.STDOUT)
    log("rm {}.toc".format(get_file_name(file)))
    subprocess.run(["rm", "{}.out".format(get_file_name(file))], stdout=rm, stderr=subprocess.STDOUT)
    log("rm {}.out".format(get_file_name(file)))
    subprocess.run(["rm", "-r", "_minted-{}".format(get_file_name(file))], stdout=rm, stderr=subprocess.STDOUT)
    log("rm -r _minted-{}".format(get_file_name(file)))

def cleanup(inp: str):
    if args.recursive:
        for r, d, f in os.walk(inp):
            for file in f:
                if file.endswith(".tex"):
                    remove_files(file)
    else:
        for file in os.listdir(inp):
            if file.endswith(".tex"):
                remove_files(file)

def compilepdfs(files):
    process=""
    rm=open("/dev/null", 'w')
    for File in files:
        if File[:2-len(File)] == "./":
            File = File[2:] #remove the ./ before files that appears when run recursively
        with open(File, 'r') as f:
            if "\\tableofcontents" in f.read():
                # need to compile twice for table of contents
                subprocess.run(["pdflatex", "-shell-escape", File], stdout=rm)
                process = subprocess.run(["pdflatex", "-shell-escape", File], stdout=rm)
            else:
                process = subprocess.run(["pdflatex", "-shell-escape", File], stdout=rm)
                
        if process.returncode != 0:
            log(f"{Fore.RED}Failed to compile {File}{Style.RESET_ALL}", True)
        else:
            log(f"{Fore.GREEN}Compiled {File}{Style.RESET_ALL}", True)

def get_file_name(path: str):
    parts = path.split('/')
    last = parts[len(parts)-1]
    return last[:len(last)-4]

if __name__ == "__main__":
    try:
        parser = argparse.ArgumentParser(description="script for complining directories full of .tex files")
        parser.add_argument("-o", "--output", type=str, help="Specifiy an output directory (it will be created if it doesn't exist")
        parser.add_argument("-i", "--input", type=str, help="Specifiy the input directory")
        parser.add_argument("-r", "--recursive", action="store_true", help="compile .tex files recursively")
        parser.add_argument("-v", "--verbose", action="store_true", help="verbose mode")
        parser.add_argument("-V", "--Verbose", action="store_true", help="verbose mode with a log file")
        args = parser.parse_args()
        log(args)
        if args.input != None:
            main(args.input)
        else:
            main(".")
    except KeyboardInterrupt:
        quit()
