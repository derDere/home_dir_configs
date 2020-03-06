import random
import os

def main(argv):
  savers = [
		'tty-clock -sSc',
		'worms -d 60 -n 6 -l 100',
		'rain -d 120',
		'cmatrix -s',
		'asciiquarium',
		'pipes.sh',
		'aafire',
		'watch -t -n 1 "date +\\"%H : %M : %S\\" | figlet | cowsay -n -f dragon | center.sh"' #,
#		'bonsai -li'
	   ]
  choice = savers[random.randint(1000000, 9999999) % len(savers)]
  os.system(choice)

if __name__=="__main__":
  import sys
  if len(sys.argv) > 1:
    main(sys.argv[1:])
  else:
    main([])
